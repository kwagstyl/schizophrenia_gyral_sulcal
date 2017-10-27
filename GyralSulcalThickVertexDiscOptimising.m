clear all
cd /path/to/subjects/dir/
setenv SUBJECTS_DIR .
format short

subs=dir('C0*');
tic
for i=1
    sub=subs(i).name
for he={'rh'}%,'lh'}
%cell2mat is a command necessary to make hemi work in the line below
    hemi=cell2mat(he);
  %  Thickness=read_curv(['',sub,'/surf/',hemi,'.thickness']);
    Curv=read_curv(['',sub,'/surf/',hemi,'.curv']);
    Area=read_curv(['',sub,'/surf/',hemi,'.area']);
    Inflated=read_surf(['',sub,'/surf/',hemi,'.inflated']);
    Cortex=read_label(['',sub,''],['',hemi,'.cortex']);
    Cortex=Cortex(:,1)+1;

    Gyri=find(Curv<=0);
    Sulci=find(Curv>0);
    DiffSulc=zeros(length(Curv),1);
    
    AreaRatio=zeros(length(Cortex)/100,10);
    kv=0;
for v=1:100:length(Cortex);
    kv=kv+1
    V=Cortex(v);
    Centre=Inflated(V,:);
    Diff=sqrt((Inflated(:,1)-Centre(1,1)).^2+(Inflated(:,2)-Centre(1,2)).^2+(Inflated(:,3)-Centre(1,3)).^2);
    k=0;
    for r=5:5:50
        k=k+1;
    Disc=find(Diff(:)<r);
   %Only cortex
   
    Disc=intersect(Disc,Cortex);
    DGyri=intersect(Disc,Gyri);
    DSulci=intersect(Disc,Sulci);
    
    AreaRatio(kv,k)=sum(Area(DGyri))/sum(Area(DSulci));
    end
end
end
end
Remove=length(AreaRatio)/100;
AreaRatio(Remove:end,:)=[]

for k=1:10;
SD(k,1)=std(AreaRatio(:,k))
M(k,1)=mean(AreaRatio(:,k));
end


