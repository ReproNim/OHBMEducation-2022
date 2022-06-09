# The Publication Exercise for the course

## JuputerHub
JupyterHub provides the computational platform we will use. We can all use a common platform with all our needed software prerequeites 
and environment pre-set. This eliminates the hassle of making all this work on everyones local computers. However, the downside is that you 
may not be able to replicate this example 'at home' unless/until you solve the software prerequsites on your own computational platform.
That's OK, ***ReproNim*** is here to help after the course qith your own 'home' computational platform.

## The Steps
We will do our re-executable publication in a sequence of steps that are designed to accomplish all the necessary tasks in the timeframe allocated by our
course.

## Create a GitHub Repo for your Publication
In this case, our final publication will be in the form of a GitHub repository, where we can connect all the parts of our publication in a central, 
shared location. A GitHub repo is FAIR: Findable, Accessible, Interoperable and Reusable. Sine this will be 'self published' nd not peer-reviewed, 
we really should think of this as a pre-print of our 'publication'. Were this an actual publication, we would create a mote formal document, complying
with the norms of traditional scientific publication, and submit to a peer-reviewed journal (after depositing the preprint as well).

## Pre-Registration
In this case, we do have a specific set of hypotheses we are testing. In general, we *should* pre-register this plan (or consider a [registered report]()) 
but those steps are considered to be outside the scope of what we can accomplish in our time together. We highly recommend you read more about this 
topic [here]().

## Collect Data
In this case we will use pre-collected data. Specifically, each of you will be assigned a subset of the [OpenNeuro ds001907]() collection. 
[TODO: Add some more about this dataset]. 

### Commands
```
datalad create -c text2git ohbm2022-dnk
cd ohbm2022-dnk

# Install all desired "components"
datalad install -d . -s https://github.com/OpenNeuroDatasets/ds001907 sourcedata
datalad install -d . -s https://github.com/ReproNim/containers containers
mkdir code
datalad install -d . -s https://github.com/proj-nuisance/simple_workflow code/simple_workflow

mkdir workdir
echo workdir > .gitignore
datalad save -m "ignore workdir" .gitignore
```

### Data Subset
Each student (or student group) will be assigned a subset of the above dataset for their analysis. This is both for practical purposes, as there is 
time to do only a limited amount of data analysis in this course, but also for didactic purposes, so that we can share (and aggregate) our individual 
results in support of both a *meta analysis* amongst our various subsets and a *mega analyis* by combining all of our individual results together. For our
purposes here, each student/team will get 5 randonly assigned typically developing subjects and 5 subjects with Parkinson's Disease (PD).

## Data Analysis
We need to execute an analysis that supports the hypotheses we are considering. 

## The Hypotheses
Our hypotheses are drawn from the findings of the [ENIGMA Consortium](https://enigma.ini.usc.edu/). Specifically, the 
[ENIGMA Parkinson's Disease subgroup](https://enigma.ini.usc.edu/ongoing/enigma-parkinsons/) have identified a number of salient structural findings,
reported in [this paper](https://pubmed.ncbi.nlm.nih.gov/34288137/). From these findings, we have selected the following *a priori* hypotheses:
1. ICV is slightly larger in PD patients
3. larger thalamic volumes (esp in earlier stage PD) 
4. smaller putamen volumes

We can assess these questions using software that will perform a volumetric analysis of the T1 structural imaging. For an efficient volumetric 
analysis, we have selectted the [FSL software](), using the [Brain Extraction Tool]() we can determine total brain volume, using [FAST](), we can 
get tissue (gray, white, CSF) volumes, and [FIRST]() yields subcortical structural volumes. The run time for each subject should ba approximately 
10 minutes.

## The Container
It turns out we already have a container that runs the set of FSL tools we need (coloquially know of as the 'simple1' container), it was used in 
the paper [Ghosh, et al, "A very simple, re-executable neuroimaging publication"](https://f1000research.com/articles/6-124), and is accessible 
already through the DataLad and ReproNim/Containers infrastructure.

```
datalad containers-run \
  -n containers/repronim-simple-workflow \
  --input 'sourcedata/sub-RC410[19]/ses-1/anat/sub-*_ses-1_T1w.nii.gz' \
  code/simple_workflow/run_demo_workflow.py 
    -o . -w data/workdir --plugin_args 'dict(n_procs=10)' '{inputs}'
```

## Standardized Representation of the Results
The imaging results of the analysis are included in the BIDS/Derivities framework. The volumetric results for each structure measured are packaged in
in a .json representtion. This .json can be transfered into the NIDM semantically encoded results (.ttl). This conversion is performed by:
```
fslsegstats2nidm -f "simple1.json" -subjid "subject_ID" -o output_nidm.ttl -n nidm_file_to_merge_with.ttl
```

## Merging standard results
The OpenNeuro data set has a NIDM representation. Our newly derived volumetric results also have an associated NIDM representation. These two 
repreentation can be merged, creating a file that inclludes both the imaging information and the analysis results.

## Querying the results


## Publishing the results to the ReproLake

