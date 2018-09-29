%% 使用Apriori算法挖掘关联规则
clear all;
clc;
% 参数初始化
inputfile = '../Sample data/symbolDataRaw.txt'; % 销量及其他属性数据
minSup = 0.02; % 最小支持度
minConf = 0.3;% 最小置信度
nRules = 1000;% 输出最大规则数
sortFlag = 1;% 按照支持度排序
rulefile = '../Sample data/Frepattern_Apriori.txt'; % 规则输出文件

%% 调用转换程序 ，把数据转换为0,1矩阵，自定义函数
[transactions,code] = trans2matrix(inputfile); 
%每一行代表一个序列，对应位置的1代表序列中出现了对应位置代表的点
%% 调用Apriori关联规则算法，自定义函数
[Rules,FreqItemsets] = findRules(transactions, minSup, minConf, nRules, sortFlag, code, rulefile);

disp('Apriori算法挖掘菜品订单关联规则完成！');