% Description: generate a 2D visualisation of the abstraction produced by a
% classifier
%
% Inputs: 
% m: a classifier
% 
% Outputs:
% None
% 
% Notes: 
% You can just assume for now that the classifier has been trained on only
% two predictive features. We'll return to relax this assumption later on.
%
function visualise_abstraction(m)

    figure; % open a new figure window, ready for plotting
    
    % add your code on the lines below...
    
    % creates the X co-ordinates for the meshgrid 
    minX = min(m.X(:,1));
    maxX = max(m.X(:,1));
    spaceX = (maxX - minX)/100;

    % creates the Y co-ordinates for the meshgrid
    minY = min(m.X(:,2));
    maxY = max(m.X(:,2));
    spaceY = (maxY - minY)/100;

   plotPoint = zeros(100,2);
   i = 0;
    for x = minX:spaceX:maxX 
        for y = minY:spaceY:maxY
            i = i+1 ;
            plotPoint(i,1) = x;
            plotPoint(i,2) = y;
            
        end

    end

    %predicts the co-ordinates in the mesh grid 
    predictions = m.predict(plotPoint);

    %plots the  visual abstraction of the predictions
    figure; gscatter(plotPoint(:,1),plotPoint(:,2),predictions, 'rgb')

        
    
end