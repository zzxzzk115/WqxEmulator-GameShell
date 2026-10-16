# Showcase capture

Captured on 2026-10-16 in a newly created independent workspace. Source checkout: `0432044ed442a92274b5774ea8526a07a9a9caeb`.

从仓库根目录启动静态服务器：

```sh
python3 -m http.server 4335 --bind 127.0.0.1
```

浏览器访问 `http://127.0.0.1:4335/WqxEmulator/`，等待仓库内置 ROM 加载，截取左上角 320×160 的完整 LCD 区域。图片按最近邻放大到 960×480 后保存为 WebP，没有添加外框或圆角。

这是仓库中适配界面的浏览器运行截图；没有在 GameShell 实机上验证。本次没有添加或修改 ROM，保留 README 中对原始 jswqx 项目与图标作者的致谢。
