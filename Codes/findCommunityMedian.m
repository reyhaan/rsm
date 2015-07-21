function findCommunityMedian(A)
%findCommunityMean Summary of this function goes here
%   Detailed explanation goes here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dtType = [datestr(datetime('now','Format','y_MMM_d_HH:mm:ss')) '_Median'];
mkdir('Results',dtType);
mkdir(['Results/' dtType],'Communities');
graphDir = ['Results/' dtType];
communityDir = ['Results/' dtType '/Communities'];

RM = getResistanceMat(A); % RM is the resistance matrix
CS = getCommunities(RM,median(RM(:))); % CS is the set of the communities

% Plot orignal graph in file /Results/dt/originGraph.dot
getGraph(A,graphDir,'originGraph');
% Plot resistance graph in /Results/dt/resistanceGraph.dot
getGraph(RM,graphDir,'resistanceGraph');

% Plot communities in dir /Results/dt/Communities. The algorithm provides
% both results on orginal garph and resistance graph.
% file name should be 
% -- orginCom+community_index.dot &
% -- resCom+community_index.dot.
for i = 1:length(CS)
    getGraphWithCommunity(A,CS{i},communityDir,['originGraph',int2str(i)]);
    getGraphWithCommunity(RM,CS{i},communityDir,['resistanceGraph',int2str(i)]);
end

