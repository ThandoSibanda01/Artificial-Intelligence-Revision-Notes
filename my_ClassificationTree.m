classdef my_ClassificationTree < handle

    properties

        % Note: we stick with the Matlab naming conventions from fitctree

        X % training examples
        Y % training labels
        MinParentSize % minimum parent node size
        MaxNumSplits % maximum number of splits

        Verbose % are we printing out debug as we go?

        % add any other properties you want on the lines below...

        root %root node
        depth %depth of the tree
        nodes % array of nodes 

    end

    methods

        % constructor: implementing the fitting phase

        function obj = my_ClassificationTree(X, Y, MinParentSize, MaxNumSplits, Verbose)

            % set up our training data:
            obj.X = X;
            obj.Y = Y;
            % store the minimum parent node size we're using:
            obj.MinParentSize = MinParentSize;
            % store the maximum number of splits we're using:
            obj.MaxNumSplits = MaxNumSplits;

            % are we printing out debug as we go?:
            obj.Verbose = Verbose;

            % over to you for the rest...

            % add your code on the lines below...

            % (note: a function has also been provided on Moodle to
            % calculate weighted impurity given any set of labels)


            obj.depth = 0;
            obj.root = treeNode(obj.X,obj.Y);
            obj.nodes = obj.root;
            obj.createTree;





        end

        % the prediction phase:

        function predictions = predict(obj, test_examples)

            % get ready to store our predicted class labels:
            predictions = categorical;

            % over to you for the rest...

            % add your code on the lines below...


            for ex = test_examples
                currentNode = obj.root ;
                while currentNode.leafNode == 0

                    if ex(currentNode.cutFeature,cutpoint) <= currentNode
                        currentNode = currentNode.leftChild;
                    else
                        currentNode = currentNode.rightChild;
                    end
                end

                predictions(end+1,1) = currentNode.predict();
            end





        end

        % add any other methods you want on the lines below...


        

        %FINDS THE ENTROPY 
        function entropy = calculateEntropy(obj,node)

            examplesInNode = size(node.X,1);
            totalTrainExamples = size(obj.X,1);
            entropy = examplesInNode/totalTrainExamples;


        end

           %finds the impurity of the node
        function impurity = infoGained(obj,node)

            impurity = entropy(node)* weightedGDI(node.Y,obj.Y);

        end


           %finds the best cut point and feature value 
        function [cutFeature,cutPoint] = bestSplit(node)

            impurity= infoGained(node);
            cutPoint = 0;
            cutFeature = 0;


            for feature = size(node.X,2)

                
                nodeX = sortrows(node.X,feature,"ascend");

                for value = size(nodeX,2)

                    node.createSplitByIndex(value);

                    if infoGained(node.leftChild) + inforGained(node.rightChild) < impurity

                        impurity = infoGained(node.leftChild) + inforGained(node.rightChild);
                        cutFeature = feature;
                        cutPoint = value;

                    end
                end

            end
        end



        function createChildren(node)


            if impurity == infoGained(node)

                node.leafNode = 1;
                node.leftChild = node([],[]);
                node.rightChild = node([],[]);

            else
                node.createSplitbyIndex(featureIndex);

            end
        end


        function maxNode = calculateMaxNode(obj)

            maxNode = 0;
            for i = 0:obj.MaxNumSplits - 1

                maxNode = maxNode + 2^i;

            end




        end

        function createTree(obj)

            
            while length(obj.nodes(1,:))< calculateMaxNode(obj)

                for currentNode = obj.nodes
                    [feat, ind] = bestSplit(currentNode);
                    children = currentNode.createSplitbyIndex(feat,ind);
                    obj.nodes = cat(1,obj.nodes,currentNode.predict(),children);
                end


            end




        end

















    end







end


