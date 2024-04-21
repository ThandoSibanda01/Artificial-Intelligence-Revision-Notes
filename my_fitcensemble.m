%wrapper function for implemntation of ensembles   
function m = my_fitcensemble(train_examples, train_labels,varargin)

    p = inputParser;
    addParameter(p, 'Verbose', false);
    addParameter(p, 'NumNeighbors', -99);
    addParameter(p, 'NaiveBayes', "false");
    addParameter(p, 'MinParentSize', -99);
    addParameter(p, 'MaxNumSplits', -99);
    p.parse(varargin{:});

    models = [];

    if p.Results.NumNeighbors ~= -99
        models(end+1 )= my_fitcknn(train_examples,train_labels,"NumNeighbors" , p.Results.NumNeighbors);

    end

    if p.Results.NaiveBayes == "true" 
        models(end+1) = myfitcnb(train_examples,train_labels);
    end

    if p.Results.MinParentSize ~= -99 & p.Results.MaxNumSplits ~= -99
         models(end+1) = my_fitctree(train_examples,train_labels , "MinParentSize",p.Results.MinParentSize,"MaxNumSplits",p.Results.MaxNumSplits);
    end

   m = my_ClassificationEnsemble(train_examples, train_labels, ...
        models, p.Results.Verbose);
end