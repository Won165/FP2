%% DownSampling
Data_465=[input('465nm data name=','s'),'.csv'];
Data_405=[input('405nm data name=','s'),'.csv'];
Ds_Data_465=Downsampling(Data_465);
Ds_Data_405=Downsampling(Data_405);
%% Show figure
plot(1:size(Ds_Data_465,1),Ds_Data_465(:,2));
xticks(0:100:size(Ds_Data_465,1));
%% Trimming
Trim_time=200;
TIME=Ds_Data_465(Trim_time:size(Ds_Data_465,1),1);
Tr_Ds_465=Ds_Data_465(Trim_time:size(Ds_Data_465,1),2);
Tr_Ds_405=Ds_Data_405(Trim_time:size(Ds_Data_405,1),2);
clf('reset')
%% Fitting 
%coef=polyfit(Sm_Tr_Ds_405(1:120*120),Tr_Ds_465(1:120*120),1);
coef=polyfit(Tr_Ds_405,Tr_Ds_465,1);
Ft_Tr_Ds_405= coef(1).* Tr_Ds_405 +coef(2);
Normalized_465= (Tr_Ds_465-Ft_Tr_Ds_405)./Ft_Tr_Ds_405;
%% Plotting
onset=input('onset =');
Tick=50;
subplot(3,1,1);
hold on;
plot(TIME,Tr_Ds_465,'b' );
plot(TIME,Tr_Ds_405,'m');
legend('465nm','405nm');
xlabel('Time (s)');
ylabel({'Fluorescence amplitude';'(mA)'});
xlim([TIME(1) TIME(size(TIME,1))])
xticks(0:Tick:TIME(size(TIME,1)))
grid on
hold off;
subplot(3,1,2);
hold on;
plot(TIME,Tr_Ds_465,'b');
plot(TIME,Ft_Tr_Ds_405,'m');
legend('465nm','Fitted smoothed 405nm');
ylabel({'Fluorescence amplitude';'(mA)'});
xlabel('Time (s)');
xlim([TIME(1) TIME(size(TIME,1))]);
xticks(0:Tick:TIME(size(TIME,1)));
grid on
hold off;
subplot(3,1,3);
hold on;
plot(TIME,Normalized_465,'color',[0 0.5 0]);
line(xlim(), [0,0], 'LineWidth', 1, 'Color', 'k');
legend('Normalized 465nm');
xlabel('Time (s)');
ylabel('dF/F');
xlim([TIME(1) TIME(size(TIME,1))]);
ylim([-0.2,0.5])
yticks(-0.2:0.1:0.5)
xticks(0:Tick:TIME(size(TIME,1)));
grid on
for n = 1:1:size(onset,2);
    line([onset(1,n),onset(1,n)],ylim(),'LineWidth', 0.1, 'Color', 'r');
end
legend('Normalized 465nm');
hold off;
