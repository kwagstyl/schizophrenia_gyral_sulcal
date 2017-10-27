clear all
cd /path/to/subjects/dir/
setenv SUBJECTS_DIR .
subs=dir('C0*');
% hierarchical level estimate for HE label regions. Taken from
% Grill-Spector and Malach 2004
 HE=[1 6 2 4 3 3 4 6 6 6 5 5];
          HElabel={'V1' 'MT' 'V2' 'V3a' 'V3b' 'V3d' 'V4v' 'V7' 'PITd' 'PITv' 'LO1' 'LO2'};
          
          
%Hierarchical level          
Le= [4 3 2 1 1 2 3 4 5 6 6 5];
%Visual regions left hemisphere
lV=[24 26 32 35 37 38 40 41 66 67 69 72];
%Visual regions right hemisphere
rV=[25 27 33 36 38 39 41 42 66 67 103 117];

Hemis={'lh', 'rh'};
LeftValues=zeros(length(subs),length(lV));
RightValues=zeros(length(subs),length(rV));
for h=1:2;
     hemi=cell2mat(Hemis(h));
  for s=1:length(subs);
    sub=subs(s).name;   
       
    [v, L, ct] = read_annotation(['',sub,'/label/',hemi,'.PALS_B12_Visuotopic.annot']);
    Thickness=read_curv(['',sub,'/surf/',hemi,'.thickness']);
    Cortex=read_label(['',sub,''], ['',hemi,'.cortex']);
    Cortex=Cortex(1:end,1)+1;
    ControlMean(s,1)=mean(Thickness(Cortex));
    
    for l=1:length(lV);
      if hemi=='lh';      
          lab_arrID=find(L==ct.table(lV(l),5));
          
          length(lab_arrID)
          LeftValues(s,l)=mean(Thickness(lab_arrID(1:end,1),:));
      elseif hemi=='rh';
          lab_arrID=find(L==ct.table(rV(l),5));
          RightValues(s,l)=mean(Thickness(lab_arrID(1:end,1),:));
      end
    end
  end
end


