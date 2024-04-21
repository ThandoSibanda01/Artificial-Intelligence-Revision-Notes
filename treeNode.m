classdef treeNode

    properties

        X;
        Y;
        leftChild;
        rightChild;
        cutpoint;
        cutfeature;
        leafNode;



    end


    methods

        function obj = treeNode (X, Y)

            obj.X = X;
            obj.Y = Y;
            obj.leafNode = 1;


        end


        function [left, right] = createSplitbyIndex(obj,featIndex, valueIndex)

            trainExamples = [obj.X obj.Y];

            trainExamples = sortrows(obj.X,featIndex,"ascend");

            obj.leftChild = treeNode( trainExamples(1:valueIndex, 1:end-1 ) ,  trainExamples(1:valueIndex,end) );

            left = obj.leftChild;

            obj.rightChild = treeNode(trainExamples(valueIndex+1:end,1:end-1) , trainExamples(valueIndex+1:end,end));
            right = obj.rightChild;



        end




        function prediction = predict(obj)

            unique_classes = unique(obj.Y);

            prediction = unique_classes(1);

            count = 0;



            for i = unique_classes
                total = 0;

                for j = length(obj.Y,2)
                    if obj.Y(j,:) == i
                        total = total +1;
                    end

                end

                if total >= count

                    prediction = i;
                    count = total;

                end


            end


        end


    end


end




