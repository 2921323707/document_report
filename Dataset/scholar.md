### 核心数据集 / 方法论文（可直接参考）

1. **Introducing WESAD** — Schmidt et al., ICMI 2018（WESAD 原始论文）：介绍数据采集协议、传感器与基准评估。适合作为压力识别基线。[ACM Digital Library+1](https://dl.acm.org/doi/10.1145/3242969.3242985?utm_source=chatgpt.com)
2. **DEAP dataset** — Koelstra et al., 2012：EEG + peripheral 生理情感数据集（经典情感识别基准）。[电子与计算机工程系](https://www.eecs.qmul.ac.uk/mmv/datasets/deap/?utm_source=chatgpt.com)
3. **AVDOS-VR (2024)** — Gnacek et al., Sci Data: 第一个带连续自评与生理信号的 VR 视频数据库（PPG、facial-EMG、IMU 等）。非常适合 VR 情感诱发与干预效果评估。[Nature](https://www.nature.com/articles/s41597-024-02953-6?utm_source=chatgpt.com)
4. **EEVR (NeurIPS Datasets 2024)** — EEVR 数据集，专注 VR 情感诱导与 PPG/EDA 信号，文中讨论了语言+生理多模态预训练的可能性。适合想做多模态深度学习预训练的项目。[NeurIPS 会议录](https://proceedings.neurips.cc/paper_files/paper/2024/file/1cba8502063fab9df252a63968691768-Paper-Datasets_and_Benchmarks_Track.pdf?utm_source=chatgpt.com)

------

### VR 与 HRV / 干预效果相关实证研究（表明 VR 干预会改变 HRV 等指标）

- **Immersion in a relaxing VR environment — Pratviel et al., 2024 (Frontiers in VR)**：VR relaxation 与 HRV biofeedback 有相似放松效果（HRV 指标变化）。适合支持“用 HRV 量化 VR 干预效果”的可行性说明。[Frontiers](https://www.frontiersin.org/journals/virtual-reality/articles/10.3389/frvir.2024.1358981/full?utm_source=chatgpt.com)
- **Heart rate variability (HRV) during virtual reality immersion — Malińska et al., 2015**：早期研究，分析 VR 沉浸对 HRV 的影响。[PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC4536947/?utm_source=chatgpt.com)
- **Virtual reality-supported biofeedback for stress management (Weibel et al., 2023)**：将 HRV biofeedback 与 VR 结合的干预研究（对减压有效）。[科学直通车](https://www.sciencedirect.com/science/article/pii/S0747563222004277?utm_source=chatgpt.com)

------

### 用到深度学习 / 融合方法的代表工作（可直接借鉴模型结构与训练流程）

- **Hybrid deep learning model for wearable sensor-based stress detection (2023, Wiley)** — 在 WESAD 上用了深度模型（说明可用 CNN / LSTM 等在生理时序上取得好结果），可借鉴架构与训练策略。[Wiley Online Library](https://onlinelibrary.wiley.com/doi/10.1002/dac.5657?utm_source=chatgpt.com)
- **Cross-dataset analysis for HRV generalizability (Sensors 2023)** — 对 HRV 基于不同数据集的泛化问题做了比较（提示数据源差异、传感器差异会影响模型泛化），建议你在训练时注意设备/协议偏差与域自适应。[MDPI](https://www.mdpi.com/1424-8220/23/4/1807?utm_source=chatgpt.com)







## 可复用开源代码 / 实现参考（进一步落地会用）

- WESAD 有多个开源实现 / preprocessing repo（例如 GitHub 上有 E4/EDA 的读取与 HRV 提取脚本）。[GitHub+1](https://github.com/WJMatthew/WESAD?utm_source=chatgpt.com)
- HRV 特征提取常用库：`neurokit2`、`hrv-analysis`、`pyHRV` 等（这些库可以直接从 ECG/PPG 计算时域/频域/非线性指标）。（若需要我可以列出具体代码范例并在数据上跑出示例特征表）。（文中方法与 review 文献一致）[PhysioNet+1](https://physionet.org/content/ecg-spider-clip/?utm_source=chatgpt.com)