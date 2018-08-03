function [diseasescores] = diseasescores_extract
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
    
    subjdismean2mm=dlmread([currentSubjDir '/' currentSubj '' '_DBM_dis_mean_2mm.txt']); %Matrix file containing information of each subject
    dismean2mm(s,1) = subjdismean2mm; %Matlab field representing connectivity matrix

    subjdismean8mm=dlmread([currentSubjDir '/' currentSubj '' '_DBM_dis_mean_8mm.txt']); %Matrix file containing information of each subject
    dismean8mm(s,1) = subjdismean8mm; %Matlab field representing connectivity matrix

    subjdismed2mm=dlmread([currentSubjDir '/' currentSubj '' '_DBM_dis_med_2mm.txt']); %Matrix file containing information of each subject
    dismed2mm(s,1) = subjdismed2mm; %Matlab field representing connectivity matrix
    
    subjdismed8mm=dlmread([currentSubjDir '/' currentSubj '' '_DBM_dis_med_8mm.txt']); %Matrix file containing information of each subject
    dismed8mm(s,1) = subjdismed8mm; %Matlab field representing connectivity matrix
    
    subjdismean2mmgm=dlmread([currentSubjDir '/' currentSubj '' '_DBM_dis_mean_2mm_gm.txt']); %Matrix file containing information of each subject
    dismean2mmgm(s,1) = subjdismean2mmgm; %Matlab field representing connectivity matrix

    subjdismed2mmgm=dlmread([currentSubjDir '/' currentSubj '' '_DBM_dis_med_2mm_gm.txt']); %Matrix file containing information of each subject
    dismed2mmgm(s,1) = subjdismed2mmgm; %Matlab field representing connectivity matrix

end

diseasescores=table(dismean2mm, dismean8mm, dismed2mm, dismed8mm, dismean2mmgm, dismed2mmgm);
%diseasescores.Properties.VariableNames{'subFolders.name'} = 'Patient';

end

