%% ʹ��Apriori�㷨�ھ��������
clear all;
clc;
% ������ʼ��
inputfile = '../Sample data/symbolDataRaw.txt'; % ������������������
minSup = 0.02; % ��С֧�ֶ�
minConf = 0.3;% ��С���Ŷ�
nRules = 1000;% �����������
sortFlag = 1;% ����֧�ֶ�����
rulefile = '../Sample data/Frepattern_Apriori.txt'; % ��������ļ�

%% ����ת������ ��������ת��Ϊ0,1�����Զ��庯��
[transactions,code] = trans2matrix(inputfile); 
%ÿһ�д���һ�����У���Ӧλ�õ�1���������г����˶�Ӧλ�ô���ĵ�
%% ����Apriori���������㷨���Զ��庯��
[Rules,FreqItemsets] = findRules(transactions, minSup, minConf, nRules, sortFlag, code, rulefile);

disp('Apriori�㷨�ھ��Ʒ��������������ɣ�');