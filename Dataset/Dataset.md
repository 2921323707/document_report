### 公开数据集

**含来源，模态，样本量，字段概览**

## 1)WESAD — **Wearable Stress and Affect Detection**（强烈推荐做基线与 HRV 模型）[reserach = 1][推荐]

![image-20251114163736155](C:\Users\29213\Desktop\数据调研\Dataset\imgs\image-20251114163736155.png)



- ** 下载**：ACM 会议论文 + UCI / Kaggle 镜像。[ACM Digital Library+1](https://dl.acm.org/doi/10.1145/3242969.3242985?utm_source=chatgpt.com)
- **实验设计**：15 被试，实验为基线（neutral）、压力诱发（cognitive + social-evaluation）、娱乐（amusement）等阶段。[UCI机器学习库](https://archive.ics.uci.edu/ml/datasets/WESAD%2B(Wearable%2BStress%2Band%2BAffect%2BDetection)?utm_source=chatgpt.com)
- **传感器 / 字段（可穿戴）**：胸部设备（ECG、EMG、RESP、体温、三轴加速度）；手腕设备（BVP（PPG）、EDA/GSR、皮肤温度、三轴加速度）。因此可以直接计算 HRV（来自 ECG 或 BVP/PPG）。[UCI机器学习库+1](https://archive.ics.uci.edu/ml/datasets/WESAD%2B(Wearable%2BStress%2Band%2BAffect%2BDetection)?utm_source=chatgpt.com)
- **标签**：时段级别的情绪/应激标签（stress / non-stress / amusement / baseline），并有事件时间戳与自评。[ACM Digital Library](https://dl.acm.org/doi/10.1145/3242969.3242985?utm_source=chatgpt.com)
- **reason**：经典且被大量后续工作当作 benchmark，适合从原始 ECG/BVP 得到 HRV 指标并训练 stress vs. non-stress 的模型（可比较传统 ML 与深度学习结果）。[ACM Digital Library+1](https://dl.acm.org/doi/10.1145/3242969.3242985?utm_source=chatgpt.com)



## 2)DEAP — **A Dataset for Emotion Analysis using Physiological Signals**（情感识别的经典多模态集）[research = 0]

**来源 / 下载**：Queen Mary University of London 页面（公开）。[电子与计算机工程系](https://www.eecs.qmul.ac.uk/mmv/datasets/deap/?utm_source=chatgpt.com)

**样本 / 设计**：32 受试者，每人观看 40 个 1 分钟音乐视频片段；同步记录 EEG + 周边生理信号并有 valence/arousal 等标注。[电子与计算机工程系](https://www.eecs.qmul.ac.uk/mmv/datasets/deap/?utm_source=chatgpt.com)

**传感器 / 字段**：EEG、面部视频、GSR（EDA）、呼吸、心率或 BVP（可计算 HRV）等。[电子与计算机工程系](https://www.eecs.qmul.ac.uk/mmv/datasets/deap/?utm_source=chatgpt.com)

**适用性**：不是 VR，但包含周边生理（可穿戴）与情感自评，适合做情感（valence/arousal）识别与 HRV 特征对比研究。[电子与计算机工程系](https://www.eecs.qmul.ac.uk/mmv/datasets/deap/?utm_source=chatgpt.com)



## 3)AVDOS-VR — **Audiovisual VR dataset with continuous self-ratings & physiological measures**（专门 VR 的情感数据集）

- **来源 / 下载 / 论文**：Nature Scientific Data（2024）发布的 VR 数据库（AVDOS-VR）。[Nature](https://www.nature.com/articles/s41597-024-02953-6?utm_source=chatgpt.com)
- **样本 / 设计**：37 位被试，在 HMD（VR）中观看 30 视频（10 positive/neutral/negative），连续自评并记录生理。[Nature](https://www.nature.com/articles/s41597-024-02953-6?utm_source=chatgpt.com)
- **传感器 / 字段**：PPG（BVP）、面部 EMG（多通道）、IMU（头部运动/加速度）、连续 valence/arousal 自评；部分记录还有皮温/GSR（文中有列出）。非常贴合“VR 干预 + 可穿戴生理指标”的场景。[Nature](https://www.nature.com/articles/s41597-024-02953-6?utm_source=chatgpt.com)



## 4) EEVR — **Emotion Elicitation in Virtual Reality**（专门为 VR 生理情感识别设计）

- **来源 / 论文**：NeurIPS Datasets & Benchmarks Track（EEVR，2024）。文献和数据说明中指出包含 EDA 与 PPG，在 360° VR 视频诱发情绪。[NeurIPS 会议录](https://proceedings.neurips.cc/paper_files/paper/2024/file/1cba8502063fab9df252a63968691768-Paper-Datasets_and_Benchmarks_Track.pdf?utm_source=chatgpt.com)
- **为何重要**：专为 VR 设计，并附带主观描述文本（可用于多模态学习 / 语言监督预训练），含可从 PPG 得到 HRV 的原始信号。[NeurIPS 会议录](https://proceedings.neurips.cc/paper_files/paper/2024/file/1cba8502063fab9df252a63968691768-Paper-Datasets_and_Benchmarks_Track.pdf?utm_source=chatgpt.com)



## 5) VREED / VREED-like 数据集（VR + 眼动 + 生理）[google推荐]

- **来源 / 论文**：VREED（VR Emotion Recognition Dataset），相关论文与测量包含眼动（eye-tracking）、ECG/GSR 等，在 VR 环境中采集情绪试验数据。[ResearchGate+1](https://www.researchgate.net/publication/357443708_VREED_Virtual_Reality_Emotion_Recognition_Dataset_Using_Eye_Tracking_Physiological_Measures?utm_source=chatgpt.com)
- **适用性**：如果你同时考虑**眼动 + HRV + GSR** 的融合模型，这类 VR 数据集非常有价值（多模态，提高泛化）。



## 6) VRMN-bD（VR 恐惧情绪、多模态自然行为数据集）

- **来源**：arXiv（2024），公开 repo 可下载（作者提供 GitHub）。样本约 23 玩家，目标是 VR 恐惧反应（horror game），包含心率/姿态/音频等。可用于恐惧/高 arousal 类别的识别。[arXiv](https://arxiv.org/abs/2401.12133?utm_source=chatgpt.com)

------

## 7) SWELL (SWELL-KW) — 工作场景压力数据 + HRV 指标（HRV 指数镜像在 Kaggle）

- **来源**：原始 SWELL 论文 + Kaggle HRV 指数文件。适用于日常知识工作类压力识别（非 VR），但含多模态（电脑日志、面部、行为、生理）。[鲁大学计算机科学+1](https://cs.ru.nl/~skoldijk/Papers/ICMI 2014 paper_final_cr.pdf?utm_source=chatgpt.com)

------

## 8) TILES (TILES-2018 / TILES-2019) — 长期纵向的穿戴生理与行为数据（医疗环境）

- **来源**：官方数据页与 Scientific Data 文章（2019/2022）。57+ 名医护人员，长期佩戴 Fitbit、音频、近场传感器等。含 HR / RR / 运动等；可用于研究模型在真实/纵向数据上的泛化与干预效果。[TILES+1](https://tiles-data.isi.edu/dataset2019_details?utm_source=chatgpt.com)

------

## 9) PhysioNet exam-stress / Driving stress / DriverDB 等（若要真实场景压力识别）

- **来源**：PhysioNet 上的若干数据集（如驾驶压力数据库包含 ECG、EMG、GSR、呼吸等），适合研究真实任务下的压力识别与 HRV 变化。[PhysioNet+1](https://archive.physionet.org/pn3/drivedb/?utm_source=chatgpt.com)







- ### **扩展补充:**

- **VitaStress：用于压力检测的多模态数据集......**

- ### 每个数据集你能直接得到 / 可派生的重要字段（面向 HRV 与情绪识别）

  对于所有“含 ECG / BVP / PPG” 的数据集，你都可以直接或间接得到下面**关键表征**（建议作为特征池）：

  - **时域 HR/HRV 特征**：RR 间期（NN/IBI）、Mean RR、SDNN、RMSSD、pNN50、NNx 等。
  - **频域 HRV 特征**：LF、HF、LF/HF、总功率（通过 Welch / Lomb-Scargle 等方法）。
  - **非线性特征**：Poincaré (SD1/SD2)、样本熵、近似熵、DFA α1/α2。
  - **EDA / GSR 特征**：皮肤电基线（SCL）、皮肤电反应（SCR）数/幅度、导数、phasic/tonic 分量。
  - **呼吸**：呼吸频率、呼吸幅度、呼吸与 HR 同步性（RSA 指标）。
  - **运动 / 加速度**：用于去噪、分段、评估活动水平（避免把运动误判为情绪/压力）。
  - **主观标签**：自评的 valence/arousal、stress label、实验阶段时间戳。

  > （上面特征做法与 HRV 教程/综述一致，后面文献里也有示例实现）。[MDPI+1](https://www.mdpi.com/1424-8220/23/4/1807?utm_source=chatgpt.com)



学术文献见Scholar.md









