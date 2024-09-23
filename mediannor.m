L1_m=[];

MED=[];
bef=input('baseline (s)=');
dur=input('duration (s)=');
dur=dur+bef;
lab={};
for n=-bef:5:dur-bef;
    lab=horzcat(lab,int2str(n));
end

%%

for n=1:1:size(onset,2);
    [~, tr1_st_unit(n)]= min(abs(TIME-(onset(n)-bef)));
    tr1_ed_unit(n)=tr1_st_unit(n)+120*dur;
    MED=median(Tr_Ds_465(tr1_st_unit(n):tr1_st_unit(n)+(120*bef))); %%input('median='); %% 
    eval(['L',num2str(n),'_m=[L',num2str(n),'_m;(transpose(Tr_Ds_465(tr1_st_unit(n):tr1_ed_unit(n))-MED))/MED];']);
end

clearvars -except Lb L1 L2 L3 L4 L5 L6 L7 L8 Lb_m L1_m L2_m L3_m L4_m L5_m L6_m L7_m L8_m lab bef dur MED

TIME=-bef:1/120:dur-bef;
%% 
clf('reset')
hold on
plot(L1_m)
xticks(0:600:120*dur);
xticklabels(lab);
xlim([0,dur*120]);
ylim([-0.1,0.6]);
line(xlim(),[0,0],'color','k')
line([bef*120,bef*120],ylim(),'color','r')
line([(bef+0)*120,(bef+0)*120],ylim(),'color','r')
xlabel('Time (s)')
ylabel('°‚F/F')
title('')
hold off
set(gca,'FontSize',20)
 