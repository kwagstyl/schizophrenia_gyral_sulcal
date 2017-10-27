clear all
cd /path/to/subjects/dir/
setenv SUBJECTS_DIR .
format short

subs=dir('C0*');
tic
for i=1:length(subs)
    sub=subs(i).name
for he={'rh','lh'}
%cell2mat is a command necessary to make hemi work in the line below
    hemi=cell2mat(he);
    Thickness=read_curv(['',sub,'/surf/',hemi,'.thickness']);
    Curv=read_curv(['',sub,'/surf/',hemi,'.curv']);
    Area=read_curv(['',sub,'/surf/',hemi,'.area']);
    Inflated=read_surf(['',sub,'/surf/',hemi,'.inflated']);
    Cortex=read_label(['',sub,''],['',hemi,'.cortex']);
    Cortex=Cortex(:,1)+1;

    Gyri=find(Curv<=0);
    Sulci=find(Curv>0);
    DiffSulc=zeros(length(Curv),1);
    
    
for v=1:length(Cortex);
    V=Cortex(v);
    Centre=Inflated(V,:);
    Diff=sqrt((Inflated(:,1)-Centre(1,1)).^2+(Inflated(:,2)-Centre(1,2)).^2+(Inflated(:,3)-Centre(1,3)).^2);
    Disc=find(Diff(:)<25);
   %Only cortex
    Disc=intersect(Disc,Cortex);
    DGyri=intersect(Disc,Gyri);
    DSulci=intersect(Disc,Sulci);
    Area(v,1)=sum(Area(DGyri));
    Area(v,2)=sum(Area(DSulci));
    Gmean=mean(Thickness(DGyri));
    Smean=mean(Thickness(DSulci));
    DiffSulc(V,1)=(Gmean-Smean)/(Gmean+Smean);
end
lh=MRIread(['',sub,'/surf/',hemi,'.w-g.pct.mgh']);
lh.vol(:)=DiffSulc;
MRIwrite(lh, ['',sub,'/surf/',hemi,'.GyralSulcalDifferences25.mgh']);
end
end
toc
