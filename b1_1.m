% 参数设置
p0 = 0.10;           % 标称次品率 10%
alpha = 0.05;        % 显著性水平 5% (95%置信度)
Z_alpha = norminv(1 - alpha);  % 正态分布临界值
p_target = 0.12;     % 假设次品率阈值
beta = 0.10;         % 接收决策的目标置信度

% 最小样本量计算公式
n_min = ceil((Z_alpha^2 * p0 * (1 - p0)) / (p_target - p0)^2);

% 标准误差计算
SE = sqrt(p0 * (1 - p0) / n_min);

% 临界次品率
p_critical = p0 + Z_alpha * SE;

% 打印结果
fprintf('最小样本量 n = %d\n', n_min);
fprintf('在 95%% 置信度下，次品率超过 %.2f%% 将拒收该批次零件\n', p_critical * 100);
