T=readtable('Statistical Analysis.xlsx','Sheet','Sheet1');
Variables=T.Properties.VariableNames
NonDM=T.NonDiabetics;
DM=T.Diabetics;
figure(1);
h1=bar([NonDM DM]);
set(h1(1),'Facecolor',[ .0 .4470 .7410]);
set(h1(2),'Facecolor',[ .9290 .6940 .1250]);
ax1=gca;
ax1.XTick=1:length(T.Var);
ax1.XTickLabel=T.Var;
ax1.XTickLabelRotation=0;
legend(ax1, {'Non Diabetics','Diabetics'},'Location','northwest');
title('Comparison of Medians of Hematological Parameters in Non-diabetics and Diabetics');
% ploting qualitative attributes
T1=readtable('Statistical Analysis.xlsx','Sheet','Sheet2');
Variables1=T1.Properties.VariableNames;
NonDM1=T1.NonDiabetics;
DM1=T1.Diabetics;
figure(2);
h1=bar([NonDM1 DM1]);
set(h1(1),'Facecolor',[ .0 .4470 .7410]);
set(h1(2),'Facecolor',[ .9290 .6940 .1250]);
ax1=gca;
ax1.XTick=1:length(T1.attributes);
ax1.XTickLabel=T1.attributes;
ax1.XTickLabelRotation=0;
legend(ax1, {'Non Diabetics','Diabetics'});
title('Comparison of Proportions of Clinico-hematological attributes in Non-diabetics and Diabetics');
ylabel('Proportions');
% correlation matrix of coagulation indicators 
 
T2=readtable('Hemat_NONDM.csv');
T3=readtable('Hemat_DMonly.csv');
Var2=T2.Properties.VariableNames;
coag_NONDM=[T2.FDP T2.DDimer T2.APTT T2.PT T2.INR];
coag_DM=[T3.FDP T3.DDimer T3.APTT T3.PT T3.INR];
r_DM= corrcoef(coag_DM);
r_NONDM=corrcoef(coag_NONDM);
figure(3);
plot(1,2);
subplot(1,2,1);
imagesc(r_DM);colormap(bone);
title('(a) Diabetics with COVID-19');
ax3=gca;
ax3.XTick=1:5;
ax3.XTickLabel={'FDP','D-Dimer','APTT','PT','INR'};
ax3.YTick=1:5;
ax3.YTickLabel={'FDP','D-Dimer','APTT','PT','INR'};
subplot(1,2,2);
imagesc(r_NONDM);colormap(bone)
title('(b) Non-Diabetics with COVID-19')
ax4=gca;
ax4.XTick=1:5;
ax4.XTickLabel={'FDP','D-Dimer','APTT','PT','INR'};
ax4.YTick=1:5;
ax4.YTickLabel={'FDP','D-Dimer','APTT','PT','INR'};


figure(4);
[S4,AX4,BigAx4,H4,HAx4]=plotmatrix(coag_NONDM,'*r')
title(BigAx4,'Correlation matrix of Coagulation indicators in Non-Diabetics suffering from COVID-19')
AX4(1,1).YLabel.String='FDP';
AX4(2,1).YLabel.String='D-Dimer';
AX4(3,1).YLabel.String='APTT';
AX4(4,1).YLabel.String='PT';
AX4(5,1).YLabel.String='INR';
AX4(5,1).XLabel.String='FDP';
AX4(5,2).XLabel.String='D-Dimer';
AX4(5,3).XLabel.String='APTT';
AX4(5,4).XLabel.String='PT';
AX4(5,5).XLabel.String='INR';
figure(5);

[S5,AX5,BigAx5,H5,HAx5]=plotmatrix(coag_DM,'*b')
AX5(1,1).YLabel.String='FDP';
AX5(2,1).YLabel.String='D-Dimer';
AX5(3,1).YLabel.String='APTT';
AX5(4,1).YLabel.String='PT';
AX5(5,1).YLabel.String='INR';
AX5(5,1).XLabel.String='FDP';
AX5(5,2).XLabel.String='D-Dimer';
AX5(5,3).XLabel.String='APTT';
AX5(5,4).XLabel.String='PT';
AX5(5,5).XLabel.String='INR';
figure(6);
% correlation matrix of markers of inflammation 
moI= [T2.ESR T2.Ferritin  T2.PCT];
[S6,AX6,BigAx6,H6,HAx6]=plotmatrix(moI,'*r')
title(BigAx6,'Correlation matrix of Coagulation indicators in Non-Diabetics suffering from COVID-19')
AX6(1,1).YLabel.String='ESR';
AX6(2,1).YLabel.String='Ferritin';
AX6(3,1).YLabel.String='PCT';
AX6(3,1).XLabel.String='ESR';
AX6(3,2).XLabel.String='Ferritin';
AX6(3,3).XLabel.String='PCT';
% model aptt and pt 
figure (7);
Mdl_NONDM=fitlm(T2.PT, T2.APTT); % for non-diabetics
pred_APTT_NONDM=Mdl_NONDM.Coefficients.Estimate(1)+Mdl_NONDM.Coefficients.Estimate(2)*T2.PT;
plot(T2.PT,pred_APTT_NONDM,'m','LineWidth',1.5);

hold on;
Mdl_DM=fitlm(T3.PT, T3.APTT); % for diabetics
pred_APTT_DM=Mdl_DM.Coefficients.Estimate(1)+Mdl_DM.Coefficients.Estimate(2)*T3.PT;

plot(T3.PT,pred_APTT_DM, 'b','LineWidth',1.5);
ax7=gca;
xlabel('Prothrombin Time (PT)');
ylabel('activated Partial Thromboplastin Time (APPT)')
legend(ax7,{'Non-diabetics with COVID-19','Diabetics with COVID-19'});
hold on;
scatter(T2.PT, T2.APTT,'filled','m');
hold on;
scatter(T3.PT, T3.APTT,'filled','b');

