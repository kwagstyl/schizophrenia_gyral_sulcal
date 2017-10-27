clear all
cd /work/imagingC/kwMyelinCurv/oxfordcaf/
setenv SUBJECTS_DIR .
format short
h=0;
X=xlsread('LaminaThicknesses.xlsx', 'Complete');
[empty, BA]=xlsread('LaminaThicknesses.xlsx', 'Complete','K:K');
z=char(BA);
z(:,1:2)='';
B=str2num(z);
for he={'rh','lh'}
h=h+1;
d=h-1;
    sub='fsaverage';
    clear DiffSulc
%cell2mat is a command necessary to make hemi work in the line below
    hemi=cell2mat(he);
   Difs=MRIread(['fsaveragesurf/',hemi,'.GyralSulcalDifferences.mgh']);
   Layer=Difs;Layer.vol(:)=0;
[v, L, ct] = read_annotation(['',sub,'/label/',hemi,'.PALS_B12_Brodmann.annot']);
for i=1:length(B);
    Br=num2str(B(i));
ref=find(strcmp(ct.struct_names(:), ['Brodmann.',Br,'']));
Labels{i,1}=[find(L==ct.table(ref,5))];
end
d=0;
%Labels={BA17,   BA24, Aud,BA9,BA44, BA46};
for La=1:7;
for l=1:length(Labels);
    d=d+1;
    Vertices=cell2mat(Labels(l));
%Data(d,h)=mean(Difs.vol(Vertices));

Layer.vol(Vertices)=X(l,La);

end
Desc=num2str(La-1);
MRIwrite(Layer,['fsaveragesurf/',hemi,'.Economo',Desc,'.mgh']);
end
end
% X=inv(diag(X(:,1)))*X;
HemiRank=ones(length(Data)*2,1);
HemiRank(length(Data)+1:end)=2;
for i=1:7;
    i
    plot(Data(:,1),X(:,i), '.')
    hold on
        plot(Data(:,2),X(:,i), '.') 
        hold off
        %pause
       [r p]= partialcorr([Data(:)], [X(:,i); X(:,i)],HemiRank);
       pval(i)=p;
       rhoval(i)=r;
end

plot([1:6], pval(2:end), 'x')
hold on
plot([1 6], [0.05 0.05], '-r')
xlabel('Cortical layer')
ylabel('Correlation of thickness with sulcal thinning')
%Layer 2 thicknesses extracted from von Economo and Selemon. ( not all
%available in von Economo
% II=[0.07, 0, 0.2, 0.2, 0.14, 0.25];
% Data(:,3)=II;
% Combi=Data(:,1:2);
% Combi=Combi(:);
% Combi(:,2)=[II, II];
% 
% 
% 
