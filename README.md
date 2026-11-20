# WqxEmulator-GameShell
> 适配GameShell的文曲星NC1020模拟器


感谢 孤獨愛你 提供的png图标，使用了nw.js来运行，原项目地址：https://github.com/hackwaly/jswqx

## 预览

![GameShell 320×240 画面：上面是 NC1020 的日历，下面是文曲星风格的虚拟键盘。](docs/images/showcase.png)

窗口按 GameShell 的 320×240 屏幕排布：上面是 320×160 的 LCD，下面是仿文曲星外壳的虚拟键盘（GameShell 没有键盘）。

## 操作

- **Select**：打开或收起虚拟键盘；**方向键** 选键，**A** 按下选中的键
- 键盘收起时：**A** 是回车，方向键就是文曲星的方向键
- **B**：AC（清除）　**Start**：大写锁定　**Menu**：退出

## 字体

虚拟键盘的按键文字用 [Zpix（最像素）](https://github.com/SolidZORO/zpix-pixel-font) 显示，在 320×240 下像素清晰。Zpix 的许可不允许二次分发，所以仓库里不附带：一键安装会从它的 [Releases](https://github.com/SolidZORO/zpix-pixel-font/releases) 下载；手动安装时请自己下载 `zpix.ttf`，放到 `WqxEmulator/fonts/` 里（系统装了 Zpix 也可以）。没有的话会退回到 Arial。

## 一键安装

SSH 连上 GameShell 后执行：

```bash
bash <(curl -sL https://raw.githubusercontent.com/zzxzzk115/WqxEmulator-GameShell/master/install.sh)
```

脚本会下载本仓库，把 `WqxEmulator` 装到 `~/apps/Menu`（启动脚本里的 `/home/cpi` 会换成你自己的用户目录），再从 Zpix 官方 Releases 下载字体。装完刷新菜单，桌面上就会出现图标。启动脚本使用 `~/apps/nwjs-sdk-v0.27.6-linux-arm` 里的 NW.js。

GitHub 访问慢的话，可以在命令前加上你自己的 GitHub 代理前缀：`GH_PROXY=https://你的代理/ bash <(curl -sL …)`。

## 手动安装

把 `WqxEmulator` 文件夹放到 GameShell 的 `/home/cpi/apps/Menu` 中，刷新菜单后桌面就会出现 Logo，打开即可。
如果你的用户名修改过，不叫 cpi，可以编辑 `WqxEmulator` 文件夹里的启动脚本 `WqxEmulator.sh`，把其中的 cpi 改成你的用户名。

## 浏览器预览

从仓库根目录执行 `python3 -m http.server 8000 --bind 127.0.0.1`，然后打开
`http://127.0.0.1:8000/WqxEmulator/`，把浏览器窗口当作 320×240 的屏幕。空格键对应 Select，打开虚拟键盘；方向键选键，K 键对应 A。
