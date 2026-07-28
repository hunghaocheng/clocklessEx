`timescale 1ns/1ns
//==============================================================================
// 文件: physical_model_testdata.v
// 说明: 物理模型测试数据 — 「人为编写」定性物理知识 + 运行时证据匹配
// 对应图: physical_model.drawio
//
// 设计原则:
//   · 因果/常态规则由人固化编写，不运行时用物理公式推导
//   · 传感只提供「现在有没有 / 多强」的证据
//   · 判断 = 证据 匹配 人工规则 → 动作码
//   · 简化阈值仅用于强度打分，不定义「谁对谁有何功效」
//
// 规则表编码 (rule_* 低 16bit 示例):
//   [15:12] agent  [11:8] target  [7:4] relation  [3:0] expect/action hint
// 关系码: 1=抑制 2=期望 3=需要 4=冲突 5=增强
//==============================================================================

module physical_model_testdata;

    //--------------------------------------------------------------------------
    // A. 人为编写的定性物理知识库 (静态固化，仿真里用 reg 装载初值)
    //--------------------------------------------------------------------------
    reg [31:0] rule_water_fire;     // 水 抑制 火
    reg [31:0] rule_gravity_ground; // 引力 期望 贴地
    reg [31:0] rule_support_stable; // 支撑 需要 接触
    reg [31:0] rule_metal_conduct;  // 金属 增强 导电通路 (示例)
    reg [31:0] rule_cliff_fall;     // 悬崖 冲突 前进
    reg [31:0] rule_impact_stop;    // 碰撞 期望 停止/避让

    // 规则命中结果
    reg        hit_water_fire;
    reg        hit_gravity_ground;
    reg        hit_support_stable;
    reg        hit_cliff_fall;
    reg        hit_impact_stop;

    //--------------------------------------------------------------------------
    // B. 运行时观测证据 (传感浓缩，非公式推导功效)
    //--------------------------------------------------------------------------
    reg [31:0] evid_has_water;      // 是否具备水/灭火剂
    reg [31:0] evid_has_fire;       // 是否检测到火/高温代理
    reg [31:0] evid_ground_contact; // 是否贴地/有法向支撑
    reg [31:0] evid_airborne;       // 是否离地异常
    reg [31:0] evid_cliff;          // 悬崖
    reg [31:0] evid_collision;      // 碰撞风险 0..3
    reg [31:0] evid_near_obstacle;  // 近障

    // 可选: 强度打分用简单阈值 (不是因果来源)
    reg [31:0] score_collision;     // 由距离/速度档位粗算

    //--------------------------------------------------------------------------
    // C. 判断输出
    //    0=KEEP 1=SLOW 2=TURN 3=STOP 4=EXTINGUISH 5=RECOVER_GROUND 6=AVOID_CLIFF
    //--------------------------------------------------------------------------
    reg [31:0] judge_action;
    reg [31:0] judge_rule_id;       // 命中的人工规则编号
    reg [31:0] judge_note;          // 附加说明码

    //--------------------------------------------------------------------------
    // 装载人为编写规则 (模拟 ROM/关联表上电写入)
    //--------------------------------------------------------------------------
    task load_human_rules;
        begin
            // agent=水(1), target=火(2), rel=抑制(1), hint=灭火(4)
            rule_water_fire     = 32'h0001_2214;
            // agent=引力(3), target=地面(4), rel=期望(2), hint=贴地(5)
            rule_gravity_ground = 32'h0003_4425;
            // agent=稳定(5), target=支撑(6), rel=需要(3), hint=接触(1)
            rule_support_stable = 32'h0005_6631;
            // agent=金属(7), target=电路(8), rel=增强(5), hint=导通(1)
            rule_metal_conduct  = 32'h0007_8851;
            // agent=悬崖(9), target=前进(A), rel=冲突(4), hint=回避(6)
            rule_cliff_fall     = 32'h0009_AA46;
            // agent=碰撞(B), target=运动(C), rel=期望(2), hint=停止(3)
            rule_impact_stop    = 32'h000B_CC23;
        end
    endtask

    //--------------------------------------------------------------------------
    // 证据 × 人工规则 → 命中 (人为逻辑，非物理公式)
    //--------------------------------------------------------------------------
    task match_rules;
        begin
            hit_water_fire      = (evid_has_water != 0) && (evid_has_fire != 0);
            hit_gravity_ground  = (evid_airborne != 0); // 违反「应贴地」期望
            hit_support_stable  = (evid_ground_contact == 0);
            hit_cliff_fall      = (evid_cliff != 0);
            hit_impact_stop     = (evid_collision >= 2) || (evid_near_obstacle != 0 && evid_collision >= 1);
        end
    endtask

    //--------------------------------------------------------------------------
    initial begin
        rule_water_fire = 0; rule_gravity_ground = 0; rule_support_stable = 0;
        rule_metal_conduct = 0; rule_cliff_fall = 0; rule_impact_stop = 0;
        hit_water_fire = 0; hit_gravity_ground = 0; hit_support_stable = 0;
        hit_cliff_fall = 0; hit_impact_stop = 0;
        evid_has_water = 0; evid_has_fire = 0; evid_ground_contact = 0;
        evid_airborne = 0; evid_cliff = 0; evid_collision = 0; evid_near_obstacle = 0;
        score_collision = 0;
        judge_action = 0; judge_rule_id = 0; judge_note = 0;

        $dumpfile("physical_model.vcd");
        $dumpvars(0, physical_model_testdata);
        #5;

        //======================================================================
        // 0) 上电: 装载人为编写的物理常识
        //======================================================================
        //----------------------------------------------------------------------
        // rule_* — 人工知识表
        // 作用: 固化「谁对谁有何关系」；不由 F=ma / 热化学公式在线推导。
        //----------------------------------------------------------------------
        load_human_rules();
        #5;
        $display("[rules] water_fire=%0h gravity_ground=%0h impact_stop=%0h",
                 rule_water_fire, rule_gravity_ground, rule_impact_stop);

        //======================================================================
        // 场景 1: 有火且有水 → 命中「水抑制火」→ EXTINGUISH
        //======================================================================
        //----------------------------------------------------------------------
        // evid_has_fire / evid_has_water — 运行时证据
        // 作用: 只回答「有没有」；「能不能灭」来自人工规则 rule_water_fire。
        //----------------------------------------------------------------------
        evid_has_fire  = 32'h0000_0001;
        evid_has_water = 32'h0000_0001;
        evid_ground_contact = 32'h0000_0001;
        evid_airborne = 0; evid_cliff = 0; evid_collision = 0; evid_near_obstacle = 0;
        #2;
        match_rules();
        #2;
        if (hit_water_fire) begin
            judge_action  = 32'h0000_0004; // EXTINGUISH
            judge_rule_id = 32'h0000_0001; // rule_water_fire
            judge_note    = 32'h0000_0001;
        end
        #10;
        $display("[S1] fire=%0d water=%0d hit=%0d -> EXTINGUISH (human rule)",
                 evid_has_fire, evid_has_water, hit_water_fire);

        //======================================================================
        // 场景 2: 离地异常 → 违反「引力期望贴地」→ RECOVER_GROUND
        //======================================================================
        evid_has_fire = 0; evid_has_water = 0;
        evid_ground_contact = 32'h0000_0000;
        evid_airborne = 32'h0000_0001;
        #2;
        match_rules();
        #2;
        if (hit_gravity_ground || hit_support_stable) begin
            judge_action  = 32'h0000_0005; // RECOVER_GROUND
            judge_rule_id = 32'h0000_0002; // rule_gravity_ground
            judge_note    = 32'h0000_0002;
        end
        #10;
        $display("[S2] airborne=%0d contact=%0d -> RECOVER_GROUND (expect ground)",
                 evid_airborne, evid_ground_contact);

        //======================================================================
        // 场景 3: 悬崖证据 → 命中「悬崖冲突前进」→ AVOID_CLIFF
        //======================================================================
        evid_airborne = 0;
        evid_ground_contact = 32'h0000_0001;
        evid_cliff = 32'h0000_0001;
        #2;
        match_rules();
        #2;
        if (hit_cliff_fall) begin
            judge_action  = 32'h0000_0006; // AVOID_CLIFF
            judge_rule_id = 32'h0000_0005; // rule_cliff_fall
            judge_note    = 32'h0000_0003;
        end
        #10;
        $display("[S3] cliff=%0d hit=%0d -> AVOID_CLIFF", evid_cliff, hit_cliff_fall);

        //======================================================================
        // 场景 4: 近障 + 粗强度分 → 命中「碰撞期望停/避」→ STOP
        // 说明: score 只用阈值打分；「应当停」仍来自人工规则 rule_impact_stop
        //======================================================================
        evid_cliff = 0;
        evid_near_obstacle = 32'h0000_0001;
        // 人为阈值打分 (非因果定义): 近障档 2 + 假定速度档 1 → score=3
        score_collision = 32'h0000_0003;
        evid_collision  = (score_collision >= 2) ? 32'h0000_0002 : 32'h0000_0001;
        #2;
        match_rules();
        #2;
        if (hit_impact_stop) begin
            judge_action  = 32'h0000_0003; // STOP
            judge_rule_id = 32'h0000_0006; // rule_impact_stop
            judge_note    = score_collision;
        end
        #10;
        $display("[S4] near=%0d score=%0d collision=%0d -> STOP (rule+threshold)",
                 evid_near_obstacle, score_collision, evid_collision);

        //======================================================================
        // 场景 5: 证据安静、无规则命中 → KEEP
        //======================================================================
        evid_near_obstacle = 0; evid_collision = 0; score_collision = 0;
        evid_has_fire = 0; evid_has_water = 0; evid_airborne = 0; evid_cliff = 0;
        evid_ground_contact = 32'h0000_0001;
        #2;
        match_rules();
        #2;
        if (!hit_water_fire && !hit_gravity_ground && !hit_support_stable &&
            !hit_cliff_fall && !hit_impact_stop) begin
            judge_action  = 32'h0000_0000; // KEEP
            judge_rule_id = 32'h0000_0000;
            judge_note    = 32'h0000_0000;
        end
        #10;
        $display("[S5] no hit -> KEEP");

        $display("[physical_model] human-rule stimulus done.");
        $finish;
    end

endmodule
