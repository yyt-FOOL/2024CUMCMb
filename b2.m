#include <stdio.h>
#include <math.h> // 用于floor函数

// 全局计数器
int count = 0;

// max_money函数
double max_money(int n1, int n2, double p1, double p2, double p_product) {
    // 内置参数
    double C1 = 2; // 检测零件1的成本
    double C2 = 3; // 检测零件2的成本
    double C_market = 56; // 单件成品的市场售价
    double C_assemble = 6; // 装配单件成品的费用
    double C_test_product = 3; // 检测单件成品所需的费用
    double C_lose = 6; // 调换一件产品引起的损失
    double C_disassemble = 5; // 拆解一件产品所需的费用

    // 初始化最大利润
    double best_profit = -1e9;

    // 遍历所有可能的策略组合
    for (int x1 = 0; x1 <= 1; x1++) {
        for (int x2 = 0; x2 <= 1; x2++) {
            for (int y = 0; y <= 1; y++) {
                for (int z = 0; z <= 1; z++) {
                    // 更新次品率
                    double p1_updated = (1 - x1) * p1;
                    double p2_updated = (1 - x2) * p2;

                    // 计算成品的总次品率
                    double P = (1 - p1_updated) * (1 - p2_updated) * p_product + p1_updated + p2_updated - p1_updated * p2_updated;

                    // 计算可以装配的成品数量
                    int n = floor(fmin((1 - p1_updated) * n1, (1 - p2_updated) * n2));

                    // 计算利润
                    double profit = C_market * (1 - P) * n 
                                  - x1 * C1 * n1 
                                  - x2 * C2 * n2 
                                  - C_assemble * n 
                                  - y * C_test_product * n 
                                  - y * C_lose * n 
                                  - z * C_disassemble * n * P;

                    // 如果选择了拆解，递归调用计算新的利润
                    if (z == 1) {
                        int new_n1 = n * P;
                        int new_n2 = n * P;
                        profit += max_money(new_n1, new_n2, p1_updated, p2_updated, p_product);
                        count++;
                    }

                    // 更新最大利润
                    if (profit > best_profit) {
                        best_profit = profit;
                    }

                    // 输出调试信息
                    printf("x1=%d, x2=%d, y=%d, z=%d, best_profit=%.2f\n", x1, x2, y, z, best_profit);
                }
            }
        }
    }

    return best_profit;
}

int main() {
    int n1 = 100; // 零件1数量
    int n2 = 100; // 零件2数量
    double p1 = 0.05; // 零件1次品率
    double p2 = 0.04; // 零件2次品率
    double p_product = 0.02; // 成品的次品率

    // 调用max_money函数
    double result = max_money(n1, n2, p1, p2, p_product);

    printf("最大利润为: %.2f\n", result);
    printf("递归次数: %d\n", count);

    return 0;