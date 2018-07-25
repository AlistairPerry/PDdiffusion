function [allsubjfixels, allsubjfixels_reshapelong] = extractMRtrixfixels(fodtemplatebase, outdir)
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

fodtempdim=size(); %tofinish

mkdir(outdir);

for i = 1:length(subjfixelfiles(:,1))
    
    currentfixelfile=subjfixelfiles(i,1).name;
    [~, currentsubj, ~]=fileparts(currentfixelfile);
    
    subjfixelmeta=read_mrtrix(currentfixelfile);
    subjfixeldata_reshape=zeros(size(fixelindexdata));
    
    for j = 1:subjfixelmeta.dim(1,1);
        subjfixeldata_reshape(fixelindexdata==j)=subjfixelmeta.data(j,1);
    end
    
    subjfixeldata_reshapelong=reshape(subjfixeldata_reshape,[1, fodtempdim(1,1)*fodtempdim(1,2)*fodtempdim(1,3));
    allsubjfixels(:,:,:,i)=subjfixeldata_reshape;
    allsubjfixels_reshapelong(i,:)=subjfixeldata_reshapelong;
    
    %remove empty columns
    maxcol=max(allsubjfixels_reshapelong);
    emptycol=find(maxcol==0);
    allsubjfixels_remzeros=allsubjfixels_reshapelong;
    allsubjfixels_remzeros(:,emptycol)=[];
    
    subjoutfixelnii=[];
    subjoutfixelnii=fodbasemeta;
    subjoutfixelnii.img=subjfixeldata_reshape;
    
    
    fixeltype=basename(workingdirectory);
    outfixelname=[currentsubj '_' fixeltype '.nii'];
    save_untouch_nii(subjoutfixelnii, [outdir '/' outfixelname]);
    
end

end

