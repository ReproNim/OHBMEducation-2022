# The Publication Exercise for the course

# JuputerHub
JupyterHub provides the computational platform we will use. We can all use a common platform with all our needed software prerequisites 
and environment pre-set. This eliminates the hassle of making all this work on everyone's local computers. However, the downside is that you 
may not be able to replicate this example 'at home' unless/until you solve the software prerequisites on your own computational platform.
That's OK, ***ReproNim*** is here to help after the course with your own 'home' computational platform.

# The Steps
We will do our re-executable publication in a sequence of steps that are designed to accomplish all the necessary tasks in the timeframe allocated by our
course.

## Create a GitHub Repo for your Publication
In this case, our final publication will be in the form of a GitHub repository, where we can connect all the parts of our publication in a central, 
shared location. A GitHub repo is FAIR: Findable, Accessible, Interoperable and Reusable. Since this will be 'self published' and not peer-reviewed, 
we really should think of this as a pre-print of our 'publication'. Were this an actual publication, we would create a more formal document, complying
with the norms of traditional scientific publication, and submit to a peer-reviewed journal (after depositing the preprint as well).

## Pre-Registration
In this case, we do have a specific set of hypotheses we are testing. In general, we *should* pre-register this plan (or consider a [registered report]()) 
but those steps are considered to be outside the scope of what we can accomplish in our time together. We highly recommend you read more about this 
topic [here]()

## Collect Data
In this case we will use pre-collected data. Specifically, each of you will be assigned a subset of the 
[OpenNeuro ds001907](https://openneuro.org/datasets/ds001907/versions/3.0.2) collection. The description of this study can be found at the 
OpenNeuro website, and this data was published in the following [data paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7217223/). There are 
46 subjects in this overall dataset (25 healthy aging, 21 Parkinson's Disease).  

### Data Subset
Each student (or student group) will be assigned a subset of the above dataset for their analysis. This is both for practical purposes, as there is 
time to do only a limited amount of data analysis in this course, but also for didactic purposes, so that we can share (and aggregate) our individual 
results in support of both a *meta analysis* amongst our various subsets and a *mega analysis* by combining all of our individual results together. 
For our purposes here, each student/team will get 5 randomly assigned typically developing subjects and 5 subjects with Parkinson's Disease (PD). We know, 
'your study' will be under-powered, but, frankly, it's still underpowered even if you have 100's of subjects, we'll talk about *that* separately.

#### Let's Do It!
On the JupyterHub in your home directory, let's make a directory for your data:
```
mkdir my_data
cd my_data
```

Now we are going to 'fork' (make a copy) of our specially prepared reduced version of the ds001907 dataset. To do this, we will
1. Open a browser
2. Navigate to the dataset's repo: https://github.com/ReproNim/ds001907-EDU
3. 'Fork' this dataset to your own account.

![picture](../pics/GitHub_fork.png)

Now, on the JupyterHub in your my_data directory, let's clone your fork of this dataset, please replace "YOUR-GITHUB-LOGIN" with your GitHub username: 
```
git clone https://github.com/<YOUR-GITHUB-LOGIN>/ds001907-EDU.git my_ds001907-EDU
```
You now have the 'complete' dataset in the my_ds001907-EDU directory.

Let's create your own specific subset of this dataset. You will receive an assigned set of cases at the class. For this example, I will just take 
sub-RC4101 and sub-RC4227 as my assigned cases. Then 
1. Remove the sub-* directories that are **not** in your dataset
2. Remove the lines of the *participants.tsv* file that are not for your subjects

The dataset you cloned had some other files that are not necessary, or that we'll regenerate as part of your processing, so let's remove them:
```
rm participants.json nidm.ttl demographics.csv
```
Let's confirm that we still have a happy BIDS dataset. The dataset you cloned is actually a DataLad dataset, so let's clean up the DataLad aspect 
of this new data subset and run the BIDS validator (locally as a Docker application, in a way that deals with a DataLad dataset):
```
datalad save -m "My new dataset" .
docker run -ti --rm -v $PWD:/data:ro bids/validator /data --ignoreSymlinks --ignoreNiftiHeaders
```
This dataset will (hopefully) pass ("This dataset appears to be BIDS compatible.") the validator. Congratulations, you have a valid BIDS (and DataLad) dataset.

You can "publish" this dataset by pushing it back to your GitHub repo, where it can be citable, and accessible by others.
```
git push
Username for 'https://github.com': "Your_GitHub_username"
Password for 'https://dnkennedy@github.com': "Your_GitHub_token"
```

***Note:*** Git may or may not ask you for your username and token, depending on how you have your git account setup.

Now that we have our dataset, and have it 'published', we can prepare to use this dataset in our analysis. We will do this in two main steps: 1) setting up our analysis environment, and 2) running the analysis.


## Setting the Analysis Environment Commands
```
datalad create -c text2git my_analysis
cd my_analysis

# Install all desired "components"
datalad install -d . -s https://github.com/<YOUR-GITHUB-LOGIN>/ds001907-EDU.git rawdata
datalad install -d . -s https://github.com/ReproNim/containers containers
mkdir code
datalad install -d . -s https://github.com/proj-nuisance/simple_workflow code/simple_workflow

mkdir workdir
echo workdir > .gitignore
datalad save -m "ignore workdir" .gitignore
```


# Data Analysis
We need to execute an analysis that supports the hypotheses we are considering. 

## The Hypotheses
Our hypotheses are drawn from the findings of the [ENIGMA Consortium](https://enigma.ini.usc.edu/). Specifically, the 
[ENIGMA Parkinson's Disease subgroup](https://enigma.ini.usc.edu/ongoing/enigma-parkinsons/) have identified a number of salient structural findings,
reported in [this paper](https://pubmed.ncbi.nlm.nih.gov/34288137/). From these findings, we have selected the following *a priori* hypotheses:
1. ICV is slightly larger in PD patients
3. larger thalamic volumes (esp in earlier stage PD) 
4. smaller putamen volumes

We can assess these questions using software that will perform a volumetric analysis of the T1 structural imaging. For an efficient volumetric 
analysis, we have selected the [FSL software](), using the [Brain Extraction Tool]() we can determine total brain volume, using [FAST](), we can 
get tissue (gray, white, CSF) volumes, and [FIRST]() yields subcortical structural volumes. The run time for each subject should be approximately 
10 minutes.

## The Container
It turns out we already have a container that runs the set of FSL tools we need (coloquially know of as the 'simple1' container), it was used in 
the paper [Ghosh, et al, "A very simple, re-executable neuroimaging publication"](https://f1000research.com/articles/6-124), and is accessible 
already through the DataLad and ReproNim/Containers infrastructure.

```
datalad containers-run \
  -n containers/repronim-simple-workflow \
  --input 'rawdata/sub-RC4*/ses-1/anat/sub-*_ses-1_T1w.nii.gz' \
  code/simple_workflow/run_demo_workflow.py \
    -o . -w data/workdir --plugin_args 'dict(n_procs=10)' '{inputs}'
```

***Congratulations! You have now run a completly re-executable analysis to venerate volumetric results on your anatomic data!***
Now, let's do someting with these results.

First, let's get all of our *stuff* represented in a more completly standard representation.

# Standards
## Imaging Data
Our raw imaging data is in pretty good shape. It is in BIDS already (although we did have a warning about not having a participants.json 'dictionary).
An issue with BIDS, however, is that even compliant BIDS are not completely 'self described'. The "diagnosis" field, for example, could have been 
called anything (dx, DIAG, condition, etc.), and therefore 'someone' would still need to tell you what this field actually is, if they handed you 
this file. [NIDM](http://nidm.nidash.org/) was developed to provide a standardised way to represent what our various data fields 'mean'. For 'diagnosis', to continue the 
example, I could associate that field with a reference to a definition of what we mean for this field, like this [link](TODO). So, our next step is 
to represent our imaging data in the NIDM representation.

```
# In the my_analysis directory...
$ bidsmri2nidm -d $PWD/rawdata -o $PWD/rawdata/my_nidm.ttl
```

You will need to answer a number of questions about your data. Details of an example session are shown [here](bidsmri2nidm.txt). You may get some 'warnings' don't 
worry about these (including regarding a missing INTERLEX API key). This process generates, in your rawdata BIDS directory a 'participants.json' file and the 'my_nidm.ttl' file.


## Standardized Representation of the Results
The imaging results of the analysis are included in the BIDS/Derivities framework. The volumetric results for each structure measured are packaged in a .json representation. This .json can be transferred into the NIDM semantically encoded results (.ttl). This conversion is performed by:
```
fslsegstats2nidm -f "simple1.json" -subjid "subject_ID" -o output_nidm.ttl -n nidm_file_to_merge_with.ttl
```

# Merging standard results
The OpenNeuro data set has a NIDM representation. Our newly derived volumetric results also have an associated NIDM representation. These two 
representations can be merged, creating a file that includes both the imaging information and the analysis results.

# Querying the results
```
pynidm query -nl nidm.ttl -u /subjects
pynidm query -nl nidm.ttl -u /dataelements

pynidm query -nl nidm.ttl -u /subjects/sub-RC4101

foreach f (`cat cases.txt` )
echo $f
fslsegstats2nidm -f ~/Data/ohbm2022-dnk/${f}_ses-1_T1w/segstats.json -subjid $f -o $PWD/file.ttl -n $PWD/nidm.ttl
end

 1112  pynidm linear-regression -nl nidm.ttl -model "fsl_000030 = age*sex+sex+age+diagnosis" -contrast "diagnosis"
 1113  pynidm linear-regression -nl nidm.ttl -model "fsl_000030 = diagnosis" -contrast "diagnosis"
 ```

# Publishing the results to the ReproLake

