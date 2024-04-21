classdef my_ClassificationEnsemble < handle
        
    properties
        
        X % training examples
        Y % training labels
        Models % list of modles to consider
        Verbose % are we printing out debug as we go?
        Canidates % The voting system for soft votes


    end

    methods
        
        % constructor: implementing the fitting phase
        
        function obj = my_ClassificationNaiveBayes(X, Y, mList)
            
            % set up our training data:
            obj.X = X;
            obj.Y = Y;
            obj.Modles = mList; % set up a list of models to get votes  
            obj.Canidates = [unique(obj.Y) ; zeros(size(obj.Y,1))]'; % stores a matrics of different classes and an aggeration of confidence
        end



        function predictions = predict(obj, test_examples)

           predictions = categorical;
            

           for m = obj.Models % cycles thorugh all saved models 



               [confidence, prediction] = m.predict(test_examples); % gets the models prediction and its confidence in that prediction

               %adds the confidence to the apporiate score   
               for i = size(obj.Canidates,1)
                   if prediction == obj.Canidates(i,1)
                        obj.Canidates(i,2) = ClassName(i,2) + confidence;
                   end

               end


                

           end

           % get the the highest weighted vote 
           mostVotesNo = 0;
           pred = "";

           for i = size(obj.Canidates,1)
               if obj.Canidates(i,2) > mostVotesNo
                   pred = obj.Canidates(i,1);
                end


           end

           %returns the overall prediction based on the weighted votes

           predictions = pred;
        end


    end


end