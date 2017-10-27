clear all
format long g
cd /path/to/subjects/dir/
setenv SUBJECTS_DIR .

subs=dir('C0*');
CGyrThick=zeros(length(subs),1);
CSulcThick=zeros(length(subs),1);
CArea=zeros(length(subs),1);
Hemi={'lh','rh'};

for i=1:length(subs)
    k=0;
    for h=1:2;
        hemi=cell2mat(Hemi(h));
        sub=subs(i).name;
    
    %Import surface measures
Thickness=read_curv(['',sub,'/surf/',hemi,'.thickness']);
Curv=read_curv(['',sub,'/surf/',hemi,'.curv']);
Area=read_curv(['',sub,'/surf/',hemi,'.area']);
Pial=read_curv(['',sub,'/surf/',hemi,'.pial.K.crv']);
Pial=abs(Pial);
Pial(Pial>2)=0;
White=read_curv(['',sub,'/surf/',hemi,'.white.K.crv']);
White=abs(White);
White(White>2)=0;

Cortex=read_label(['',sub,''],['',hemi,'.cortex']);
Cortex=Cortex(:,1)+1;

%Define gyral and sulcal vertices
Gyri=intersect(Cortex, find(Curv<=0));
Sulci=intersect(Cortex, find(Curv>0));

%create data table
Data(i+k,1)=sum(Area(Cortex));
Data(i+k,2)=mean(Thickness(Gyri));
Data(i+k,3)=mean(Thickness(Sulci));
Data(i+k,4)=mean(White(Gyri));
Data(i+k,5)=mean(White(Sulci));
Data(i+k,6)=mean(Pial(Gyri));
Data(i+k,7)=mean(Pial(Sulci));
Data(i+k,8)=sum(Area(Gyri));
Data(i+k,9)=sum(Area(Sulci));
Subname{i+k,1}=sub;
k=length(subs);
    end
end

%save('GyralSulcalData.mat','Data','subs')
