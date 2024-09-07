% 参数设置
alpha = 0.05; % 显著性水平
p0 = 0.10; % 零假设下的次品率
p1 = 0.11; % 备择假设下的次品率
Z = norminv(1 - alpha, 0, 1); % 对应于95%信度的Z值（单侧检验）

% 计算样本量
n = (Z^2 * p0 * (1 - p0)) / (p1 - p0)^2;
n = ceil(n); % 向上取整

fprintf('所需样本量为: %d\n', n);

% 模拟抽样检测（假设我们有样本数据）
% 这里我们假设样本数据已经获得并计算样本比例
% 示例中使用随机生成的次品率作为样本比例
sample_size = n; % 使用计算出的样本量
sample_defective_rate = 0.12; % 假设实际样本中的次品率

% 计算检验统计量
p_hat = sample_defective_rate; % 样本比例
std_error = sqrt(p0 * (1 - p0) / sample_size);
Z_stat = (p_hat - p0) / std_error;

fprintf('计算得到的Z值为: %.4f\n', Z_stat);

% 检验结果
if Z_stat > Z
    fprintf('拒绝零假设：次品率超过10%%\n');
else
    fprintf('不能拒绝零假设：次品率不超过10%%\n');
end
