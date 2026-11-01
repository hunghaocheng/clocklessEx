# clocklessEx 文档站

独立的 Antora 站点，介绍本仓库里无全局同步时钟的开发工作。中文在 `zh/modules/ROOT/pages/`，英文在 `en/modules/ROOT/pages/`。

在本目录执行：

```text
npm install
npm run build
```

生成结果在 `build/site/`。用浏览器打开 `build/site/index.html`，进入中文首页。顶栏右侧可切到英文。

Playbook 读取上一级 Git 仓库的工作区，因此这里必须位于 clocklessEx 仓库的 `docs-site/` 下，且仓库根目录有 `.git`。未提交的文档也会被编进站点。
