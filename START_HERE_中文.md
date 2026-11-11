# 项目启动清单（2026-11-11）

## 1. 先准备 11 月 16 日咨询会

- 时间：2026 年 11 月 16 日（周一）11:00–11:30，德国时间，Microsoft Teams。
- 组别：Intra-household allocation of tasks。这是**组咨询会**，每人应简洁介绍项目。
- 必读：`docs/consultation_2026-11-16.md`（有英文 60 秒发言稿和给老师的 3 个优先问题）。
- 记得在课程组织表检查 Teams 链接。

## 2. 研究题目（暂定，咨询后可改）

**Beyond the 50/50 Split: Gender, Housework Shares, and Perceived Time Scarcity**

以 ELKiD 2021 第二轮调查为基础，检验自报家务承担比例与主观时间不足感的相关性，以及该相关性是否因性别不同而不同。

关键界限：**Q201_4 不是直接测量 mental load；关联不等于因果。**

## 3. 在 Windows 开始项目

1. 解压本 ZIP，进入 `beyond-50-50-housework` 文件夹。
2. 安装 R 与 RStudio；双击 `.Rproj` 文件。
3. 在 R 控制台执行：

```r
install.packages(c("readr", "dplyr", "tidyr", "ggplot2", "broom", "knitr", "testthat"))
```

4. 从老师的 Google Drive 下载 `Data_Wave2.csv`，放到 `data/raw/Data_Wave2.csv`，**不要上传到 GitHub**。
5. 在 RStudio 中运行：

```r
source("scripts/run_all.R")
results <- run_project()
testthat::test_dir("tests/testthat")
```

生成的图表和结果保存在 `outputs/`，该目录默认被 `.gitignore` 排除。

## 4. 在 GitHub 建立私有仓库

打开 https://github.com/new ，Owner 选 `willowkatze`，仓库名 `beyond-50-50-housework`，选 **Private**。不要让 GitHub 初始化 README，因为本地已有。

在本地项目目录打开 PowerShell 或 Git Bash，执行：

```bash
git init -b main
git add .
git status
git commit -m "chore: bootstrap TUM seminar research project"
git remote add origin https://github.com/willowkatze/beyond-50-50-housework.git
git push -u origin main
```

如果 `git commit` 提示 `Author identity unknown`，请在你自己的电脑配置 `git config --global user.name "你的 GitHub 显示名"` 和 `git config --global user.email "与你的 GitHub 关联的邮箱"`，之后重试提交。

务必先看 `git status`：如果出现 `Data_Wave2.csv`、`Data_Wave1.csv`、个人信息或 `outputs/` 的文件，不要继续 push，应先排查 `.gitignore`。

如果已经安装并登录了 GitHub CLI (`gh`)，也可先在本地完成 git 初始化和 commit，再执行 `gh repo create willowkatze/beyond-50-50-housework --private --source=. --remote=origin --push`，代替网页创建 + remote/push 步骤；二者不要同时执行。

## 5. 用 Codex 协作

打开新仓库对应的 Codex 项目（前提是你的账户及仓库已获得相应访问权限）。向 Codex 粘贴 `docs/codex_first_task.md` 的内容。让它：

- 先读 `AGENTS.md`；
- 仅在 `research/sample-audit` 分支上修改；
- 用合成数据写测试；
- 提交 Draft PR，由你检查再合并。

不应该让云端 Codex 在没有课程数据使用授权确认前读取老师提供的原始个人调查数据。

## 6. 研究顺序

1. **11/11–11/15：** 环境安装、变量核对、初步样本量审计、文献摘要。
2. **11/16：** 参加 Q&A，并记录老师关于变量、模型、样本的决定。
3. **11/17 起：** 根据老师意见修改代码，完善两张图和两张回归表。
4. **1 月（待老师公布具体日期）：** 准备最终 10 分钟展示。

课程资料入口：https://drive.google.com/drive/folders/1FhI0Iqd7UhXWXqHBNZG2kRKfNsTxhTB9
