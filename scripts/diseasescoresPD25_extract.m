function [diseasescores] = diseasescoresPD25_extract
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

workingdirectory = pwd;
files = dir(workingdirectory);
dirFlags=[files.isdir];
subFolders=files(dirFlags);
subFolders(1:2)=[];

for s = 1:length(subFolders)
    currentSubj= subFolders(s,1).name;
    currentSubjDir = char([workingdirectory '/' currentSubj]);
    
    subjdismean=dlmread([currentSubjDir '/' currentSubj '' '_DBM_dis_mean_PD25gm.txt']); %Matrix file containing information of each subject
    dismean(s,1) = subjdismean; %Matlab field representing connectivity matrix

    subjdismed=dlmread([currentSubjDir '/' currentSubj '' '_DBM_dis_med_PD25gm.txt']); %Matrix file containing information of each subject
    dismed(s,1) = subjdismed; %Matlab field representing connectivity matrix
    
    subjdismean2mm=dlmread([currentSubjDir '/' currentSubj '' '_DBM_dis_mean_2mm_PD25gm.txt']); %Matrix file containing information of each subject
    dismean2mm(s,1) = subjdismean2mm; %Matlab field representing connectivity matrix

    subjdismean8mm=dlmread([currentSubjDir '/' currentSubj '' '_DBM_dis_mean_8mm_PD25gm.txt']); %Matrix file containing information of each subject
    dismean8mm(s,1) = subjdismean8mm; %Matlab field representing connectivity matrix

    subjdismed2mm=dlmread([currentSubjDir '/' currentSubj '' '_DBM_dis_med_2mm_PD25gm.txt']); %Matrix file containing information of each subject
    dismed2mm(s,1) = subjdismed2mm; %Matlab field representing connectivity matrix
    
    subjdismed8mm=dlmread([currentSubjDir '/' currentSubj '' '_DBM_dis_med_8mm_PD25gm.txt']); %Matrix file containing information of each subject
    dismed8mm(s,1) = subjdismed8mm; %Matlab field representing connectivity matrix
    
diseasescores=table(dismean, dismed, dismean2mm, dismean8mm, dismed2mm, dismed8mm);
%diseasescores.Properties.VariableNames{'subFolders.name'} = 'Patient';

end

