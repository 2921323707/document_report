# 数据集与机器学习模型资料汇总

本项目收集整理了用于生理信号分析、情绪识别和压力检测的相关数据集和深度学习模型架构资料。

## 📁 项目结构

```
.
├── Dataset/              # 数据集相关文档
│   ├── Dataset.md       # 公开数据集详细说明
│   ├── scholar.md       # 学术资源
│   └── imgs/            # 数据集相关图片
├── Frame/               # 深度学习框架与模型
│   ├── reference.md     # 深度学习架构参考
│   ├── src/             # 源代码
│   └── imgs/            # 框架相关图片
├── AI高质量数据集、平台及工具指南.pdf  # 数据集平台指南
└── git/                 # Git相关文件
    ├── README.md        # Git使用说明
    └── commit.ps1       # GitHub提交脚本
```

## 📊 数据集内容

### 主要数据集
- **WESAD** - 可穿戴压力与情感检测数据集（强烈推荐）
- **DEAP** - 基于生理信号的情感分析数据集
- **AVDOS-VR** - 视听VR数据集（含连续自评与生理测量）
- **EEVR** - VR环境中的情感诱发数据集
- **VREED** - VR情感识别数据集（含眼动追踪）

详细说明请查看 [Dataset/Dataset.md](Dataset/Dataset.md)

## 🤖 深度学习模型

### 主要架构
- **RNN/LSTM/GRU** - 循环神经网络及其变体
- **CNN** - 卷积神经网络（1D-CNN用于时序信号）
- **Transformer** - 注意力机制模型
- **多模态融合** - 多信号融合模型

详细说明请查看 [Frame/reference.md](Frame/reference.md)

## 🚀 快速开始

### 使用Git提交脚本

1. **首次使用**（初始化仓库）：
```powershell
cd git
.\commit.ps1 -init
```

2. **日常提交**：
```powershell
cd git
.\commit.ps1 -message "更新内容描述"
```

3. **查看帮助**：
```powershell
.\commit.ps1 -help
```

## 📝 使用说明

### 提交脚本功能
- 自动初始化Git仓库（如果未初始化）
- 添加所有更改的文件
- 创建提交记录
- 推送到GitHub远程仓库
- 支持自定义提交信息

### 手动Git操作

如果需要手动操作，可以使用以下命令：

```powershell
# 初始化仓库（首次使用）
git init

# 添加远程仓库
git remote add origin https://github.com/2921323707/document_report.git

# 添加文件
git add .

# 提交更改
git commit -m "提交信息"

# 推送到GitHub
git push -u origin main
```

## 🔗 相关链接

- GitHub仓库: https://github.com/2921323707/document_report
- 数据集来源: 详见 Dataset/Dataset.md 中的链接

## 📄 许可证

本项目为资料汇总项目，数据集和论文的版权归原作者所有。

## 👤 作者

小驴同学

---

**注意**: 使用提交脚本前，请确保已安装Git并配置好GitHub认证信息。
