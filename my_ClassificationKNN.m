classdef my_ClassificationKNN < handle
        
    properties
        
        % Note: we stick with the Matlab naming conventions from fitcknn
        
        X % training examples
        Y % training labels
        NumNeighbors % number of nearest neighbours to consider
        
        Verbose % are we printing out debug as we go?
    end
    
    methods
        
        % constructor: implementing the fitting phase
        
        function obj = my_ClassificationKNN(X, Y, NumNeighbors, Verbose)
            
            % set up our training data:
            obj.X = X;
            obj.Y = Y;
            % store the number of nearest neighbours we're using:
            obj.NumNeighbors = NumNeighbors;
            
            % are we printing out debug as we go?:
            obj.Verbose = Verbose;
        end
        
        % the prediction phase:
        
        function [predictions] = predict(obj, test_examples)
            
            % get ready to store our predicted class labels:
            predictions = categorical;
            
            % over to you for the rest... 
            
            % add your code on the lines below...
        
              for i = 1:size(test_examples,1)

                
                test_example = test_examples(i,1:end); % save current example working on
                distances =[];


                %finds the eucliedean distance from testing point to each
                %training point 
                for j = 1:size(obj.X,1)

                    train_example = obj.X(j,1:end);
                    
                    distances(end+1) = sqrt(sum((test_example - train_example) .^2) ); 

                    

                end
                %sorts  distances in ascending order
                [~,ind] = sort(distances);

                predictions(end+1,1) = mode(obj.Y(ind(1:obj.NumNeighbors)));  % gets the nearest points from 1 - K 

                confidence = sum(obj.Y(ind(1:obj.NumNeighbors)) == mode(obj.Y(ind(1:obj.NumNeighbors)))) /obj.NumNeighbors ; %finds the percentage of K nearest neighbours that equal the predicition
                
             end
                


        end

 
    end

   
        
    
end
