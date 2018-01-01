function [allsubjfixels] = extractMRtrixfixels(fodtemplatebase)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%required packages = NIFTI

workingdirectory=pwd;

[fodbasemeta]=load_untouch_nii(fodtemplatebase);

fixelindexmeta=read_mrtrix('index.mif');
fixelindexdata=fixelindexmeta.data(:,:,:,2);

subjfixelfiles = dir('*.mif');
subjfixelfiles(1:2)=[];

dirfixelrow=find(strcmp({subjfixelfiles.name}, 'directions.mif')==1);
indfixelrow=find(strcmp({subjfixelfiles.name}, 'index.mif')==1);

catremrows=cat(1,dirfixelrow,indfixelrow);
subjfixelfiles(catremrows,:)=[];

for i = 1:length(subjfixelfiles(:,1))
    
    currentfixelfile=subjfixelfiles(i,1).name;
    [~, currentsubj, ~]=fileparts(currentfixelfile);
    
    subjfixelmeta=read_mrtrix(currentfixelfile);
    subjfixeldata_reshape=zeros(size(fixelindexdata));
    
    for j = 1:subjfixelmeta.dim(1,1);
        subjfixeldata_reshape(fixelindexdata==j)=subjfixelmeta.data(j,1);
    end
    
    allsubjfixels(:,:,:,i)=subjfixeldata_reshape;
    
    subjoutfixelnii=[];
    subjoutfixelnii=fodbasemeta;
    subjoutfixelnii.img=subjfixeldata_reshape;
    
    
    fixeltype=basename(workingdirectory);
    outfixelname=[currentsubj '_' fixeltype '.nii'];
    save_untouch_nii(subjoutfixelnii, outfixelname);
    
end

end

