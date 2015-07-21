function findCommunityPara(A, para)
%FINDCOMMUNITYPARA Summary of this function goes here
%   Detailed explanation goes here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dtType = [datestr(datetime('now','Format','y_MMM_d_HH:mm:ss')) '_Para_' num2str(para)];
mkdir('Results',dtType);
mkdir(['Results/' dtType],'Communities');
graphDir = ['Results/' dtType];
communityDir = ['Results/' dtType '/Communities'];

RM = getResistanceMat(A); % RM is the resistance matrix
CS = getCommunities(RM,para); % CS is the set of the communities

% Plot orignal graph in file /Results/dt/originGraph.dot
getGraph(A,graphDir,'originGraph');
% Plot resistance graph in /Results/dt/resistanceGraph.dot
getGraph(RM,graphDir,'resistanceGraph');

fileName = 'communities.txt';
fileID = fopen(fileName,'wt');


% Plot communities in dir /Results/dt/Communities. The algorithm provides
% both results on orginal garph and resistance graph.
% file name should be 
% -- orginCom+community_index.dot &
% -- resCom+community_index.dot.
for i = 1:length(CS)
    
    fprintf(fileID,'%d\n',CS{i});
    
    
    getGraphWithCommunity(A,CS{i},communityDir,['originGraph',int2str(i)]);
    getGraphWithCommunity(RM,CS{i},communityDir,['resistanceGraph',int2str(i)]);
    
    fprintf(fileID, '%s\n', '#');
    
end

fclose(fileID);

copyfile('/Users/soombehera/Documents/MATLAB/communities.txt','/Users/soombehera/Documents/MATLAB/process/rsm_com/communities.txt','f');

