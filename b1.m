% 参数设置
p0 = 0.10;           % 标称次品率 10%
alpha = 0.05;        % 显著性水平 5% (95%置信度)
beta = 0.10;         % 接受率 90% (对于接收决策)
p_reject = 0.12;     % 拒收次品率假设
p_accept = 0.08;     % 接受次品率假设
confidence_level = 0.95;

% 初始样本量估计
n_start = 30;        % 起始样本量
n_max = 1000;        % 最大样本量限制

% 二项分布方法找到最优n和c
for n = n_start:n_max
    % 计算拒收次品数的上界
    c_reject = binoinv(1 - alpha, n, p0);
    % 计算接受次品数的下界
    c_accept = binoinv(beta, n, p0);

    % 检查样本量是否合理
    p_value_reject = 1 - binocdf(c_reject - 1, n, p_reject);
    p_value_accept = binocdf(c_accept, n, p_accept);

    % 如果置信度和接受条件同时满足，找到n并终止
    if p_value_reject <= alpha && p_value_accept >= 1 - beta
        break;
    end
end

% 输出结果
fprintf('最优样本量 n = %d\n', n);
fprintf('拒收临界值 c_reject = %d\n', c_reject);
fprintf('接收临界值 c_accept = %d\n', c_accept);

% 使用正态近似的方法计算n和c
Z_alpha = norminv(1 - alpha);        % 正态分布的alpha临界值
Z_beta = norminv(beta);              % 正态分布的beta临界值

n_normal = ceil((Z_alpha + Z_beta)^2 * p0 * (1 - p0) / (p_reject - p_accept)^2);
c_normal_reject = round(n_normal * p0 + Z_alpha * sqrt(n_normal * p0 * (1 - p0)));
c_normal_accept = round(n_normal * p0 - Z_beta * sqrt(n_normal * p0 * (1 - p0)));

% 输出正态近似结果
fprintf('正态近似的最优样本量 n_normal = %d\n', n_normal);
fprintf('正态近似拒收临界值 c_normal_reject = %d\n', c_normal_reject);
fprintf('正态近似接收临界值 c_normal_accept = %d\n', c_normal_accept);
