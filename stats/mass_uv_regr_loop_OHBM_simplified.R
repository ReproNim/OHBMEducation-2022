#more /ifs/loni/faculty/njahansh/ENIGMA/DTI/working_grp/DiseaseGroups/SCRIPTS/CorticalEffectSizes.R

datafile <- read.csv("metr_SubCortical_OHBM.csv"); #Read in the file
ROINames<-c("Lthal","Rthal","Lcaud","Rcaud","Lput","Rput","Lpal","Rpal","Lhippo","Rhippo","Lamyg","Ramyg","Laccumb","Raccumb")

# what is the column header for age?
ageColumnHeader="Age" 

# what is the column header for sex?
sexColumnHeader="Sex" 
# how are males coded (1,0,"M","males",-0.5)?
maleIndicator=1 # in this code those not coded as male are assumed to be female

# what is the column header for case/control or indicating diagnostic status?
caseColumnHeader="Dx"
# how are cases coded (1,0,"patients","cases")?
caseIndicator=1 # in this code those not coded as cases are assumed to be controls

# how many continuous covariates other than age should be used from your spreadsheet?
otherCovariatesN=1
# list out the covariates and separate them with a semi-colon
otherCovariates="ICV"

# how many categorical covariates are in your spreadsheet other than sex?
## (examples might include site / scanner / study / different diagnostic groups) 
otherCatCovariatesN=1
# list out the categorical covariates (coded as factors) and separate them with a semi-colon
otherCatCovariates="site"

outFolder="./"
eName="ENIGMA-PD"
cohortName="MyOHBMcohort"

####################################################################
##dir.create(outFolder, showWarnings = FALSE)
##zz <- file(paste(outFolder,"/","RUN_NOTES.txt",sep=""),"w")
####################################################################

## Sanity checks:

# Check for duplicated SubjIDs that may cause issues with merging data sets.
if(anyDuplicated(datafile[,1]) != 0) { stop('You have duplicate SubjIDs in your file or subject ID is not your first column.\nMake sure there are no repeat SubjIDs.') }
#Get number of structures to test
Nrois=length(ROINames)
columnnames = colnames(datafile);

# Check all ROIs are column headers in the input CSV
missingROIS="";
l_missing=0;

for (i in 1:Nrois) {
  if (length(datafile[,which(columnnames==ROINames[i])]) == 0) {
    missingROIS=paste(missingROIS,ROINames[i])
    l_missing=l_missing+1;
  }
}
if (l_missing != 0) { warning(paste("You are missing ROIs in your file.\nPlease check:",missingROIS,sep=""))}

## delete this 
#n.covs <- ncol(Covs) - 1; #Total number of covariates, -1 removes the SubjectID column
#n.sites <- n.covs - 3; #Find the number of site variables, subtract for Dx, Age, Sex from n.covs

####################################################################
####################################################################
###Functions used in the code for Cohens d
d.t.unpaired<-function(t.val,n1,n2){
  d<-t.val*sqrt((n1+n2)/(n1*n2))
  names(d)<-"effect size d"
  return(d)
}
partial.d<-function(t.val,df,n1,n2){
  d<-t.val*(n1+n2)/(sqrt(n1*n2)*sqrt(df))
  names(d)<-"effect size d"
  return(d)
}
CI1<-function(ES,se){
  ci<-c((ES-(1.96)*se),(ES+(1.96)*se))
  names(ci)<-c("95% CI lower","95% CI upper")
  return(ci)
}
se.d2<-function(d,n1,n2){
  se<-sqrt((n1+n2)/(n1*n2)+(d^2)/(2*(n1+n2-2)))
  names(se)<-"se for d"
  return(se)
}
####################################################################
####################################################################
## Group stats:

# Set empty matrix 
featureNames <- c("mean","sd","n","min","max")
stats.raw=matrix(NA,5,Nrois); 
colnames(stats.raw) <- ROINames; rownames(stats.raw) <- featureNames; 

#Get raw mean, sd and number of subjects included for each of the structures
stats.raw[1,]=colMeans(datafile[,ROINames], na.rm=T)
print(stats.raw[1,])
for (i in 1:Nrois) {
    z=which(columnnames==ROINames[i])
    stats.raw[2,i]=sd(datafile[,z], na.rm=T)
    stats.raw[3,i]=length(datafile[which(!is.na(datafile[,z])),z])
    stats.raw[4,i]=min(datafile[,z], na.rm=T)
    stats.raw[5,i]=max(datafile[,z], na.rm=T)
}
#Save raw values
write.csv(stats.raw,"RawGroupStats_all.csv")
save(stats.raw, file="RawGroupStats.Rdata")

####

#Get raw means for each of the structures for the cases
cases=which(datafile[,caseColumnHeader]==caseIndicator)
stats.raw=matrix(NA,5,Nrois); 
colnames(stats.raw) <- ROINames; rownames(stats.raw) <- featureNames; 

#Get raw mean, sd and number of subjects included for each of the structures
stats.raw[1,]=colMeans(datafile[cases,ROINames], na.rm=T)
print(stats.raw[1,])
for (i in 1:Nrois) {
  z=which(columnnames==ROINames[i])
  stats.raw[2,i]=sd(datafile[cases,z], na.rm=T)
  stats.raw[3,i]=length(datafile[which(!is.na(datafile[cases,z])),z])
  stats.raw[4,i]=min(datafile[cases,z], na.rm=T)
  stats.raw[5,i]=max(datafile[cases,z], na.rm=T)
}
#Save raw values
write.csv(stats.raw,"RawGroupStats_cases.csv")
save(stats.raw, file="RawGroupStats_cases.Rdata")

#Get raw means for each of the structures for the controls
controls=which(datafile[,caseColumnHeader]!=caseIndicator)
#Get raw mean, sd and number of subjects included for each of the structures
stats.raw[1,]=colMeans(datafile[controls,ROINames], na.rm=T)
for (i in 1:Nrois) {
  z=which(columnnames==ROINames[i])
  stats.raw[2,i]=sd(datafile[controls,z], na.rm=T)
  stats.raw[3,i]=length(datafile[which(!is.na(datafile[controls,z])),z])
  stats.raw[4,i]=min(datafile[controls,z], na.rm=T)
  stats.raw[5,i]=max(datafile[controls,z], na.rm=T)
}
#Save raw values
write.csv(stats.raw,"RawGroupStats_controls.csv")
save(stats.raw, file="RawGroupStats_controls.Rdata")

#Get demographics
age.mu=mean(datafile[,ageColumnHeader]) #raw age mean
age.sd=sd(datafile[,ageColumnHeader]) #raw age sd
age.range=range(datafile[,ageColumnHeader]) #raw age range
age.mu.dx0=mean(datafile[controls,ageColumnHeader]) #age mean for ctls
age.sd.dx0=sd(datafile[controls,ageColumnHeader]) #age sd for ctls
age.range.dx0=range(datafile[controls,ageColumnHeader]) #age range for ctls
age.mu.dx1=mean(datafile[cases,ageColumnHeader]) #age mean for patients
age.sd.dx1=sd(datafile[cases,ageColumnHeader]) #age sd for patients
age.range.dx1=range(datafile[cases,ageColumnHeader]) #age range for patients

females=subset(datafile, datafile[,sexColumnHeader]!=maleIndicator)
males=subset(datafile, datafile[,sexColumnHeader]==maleIndicator)

Fcases=which(females[,caseColumnHeader]==caseIndicator)
Fcontrols=which(females[,caseColumnHeader]!=caseIndicator)
Mcases=which(males[,caseColumnHeader]==caseIndicator)
Mcontrols=which(males[,caseColumnHeader]!=caseIndicator)

n.fem=dim(females)[1] # N Females
n.mal=dim(males)[1] # N Males

n.fem.dx0=length(Fcontrols) # F ctls
n.mal.dx0=length(Mcontrols)  # M ctls
n.fem.dx1=length(Fcases) # F cases
n.mal.dx1=length(Mcases) # M cases

n.dx0=length(controls) # Total number of ctls
n.dx1=length(cases) # Total number of patients

#Save demographic info
save(age.mu, age.sd, age.range, age.mu.dx0, age.sd.dx0, age.range.dx0, age.mu.dx1, age.sd.dx1, age.range.dx1,
     n.fem, n.mal, n.fem.dx0, n.mal.dx0, n.fem.dx1, n.mal.dx1, n.dx0, n.dx1, file="Demographics.Rdata")

####################################################################

#Store models for troubleshooting
models.cort=NULL; # This will become a list where we store all of the models made by lm

#allocate empty vectors to store adjust effect sizes, se, ci 
d.cort=matrix(NA,1,Nrois); colnames(d.cort) <- ROINames
se.cort=matrix(NA,1,Nrois); colnames(se.cort) <- ROINames
low.ci.cort=matrix(NA,1,Nrois); colnames(low.ci.cort) <- ROINames
up.ci.cort=matrix(NA,1,Nrois); colnames(up.ci.cort) <- ROINames
n.controls=matrix(NA,1,Nrois); colnames(n.controls) <- ROINames
n.patients=matrix(NA,1,Nrois); colnames(n.patients) <- ROINames



# number of total covariates used:

# check number indicated is the same as parsed text
covariates=parse(text=otherCovariates);
Ncov_parsed=length(covariates)
covariatesF=parse(text=otherCatCovariates)
Ncatcov_parsed=length(covariatesF)

if (otherCovariatesN > 0) {
  if (Ncov_parsed != otherCovariatesN) { 
    stop(paste("You have indicated a different number of covariates than you have listed.\nPlease check listed variables are separated by a semicolon (;)",sep=""))}
}

if (otherCatCovariatesN > 0) {
  if (Ncatcov_parsed != otherCatCovariatesN) { 
    stop(paste("You have indicated a different number of categorical covariates than you have listed.\nPlease check listed variables are separated by a semicolon (;)",sep=""))}
}

# subtract 1 from number of factors for each categorical covariate 
Nfactors=0
if (otherCatCovariatesN > 0) {
  for (i in 1:otherCatCovariatesN ) {
    Nf=length(levels(factor(datafile[,levels(covariatesF[i])])))-1 
    Nfactors=Nfactors+Nf
  }
}
#total number of covariates as calculated above + age and sex
Ncov=otherCovariatesN+Nfactors+2

#Loop through and perform each regression
for (i in 1:Nrois) {
  print(ROINames[i])
  z=which(columnnames==ROINames[i])
  rows2use=!is.na(datafile[,z])
  trait=datafile[rows2use,z]
  if(length(trait)==0){
    next; # Skip the whole structure if there are no observations
  }
  caseControl_covariatesforRFX = data.frame(NA,nrow=length(trait),ncol=otherCovariatesN+otherCatCovariatesN+3);
  caseControl_covariatesforRFX = datafile[rows2use,c(caseColumnHeader,ageColumnHeader,sexColumnHeader)]
  origcolnames=colnames(caseControl_covariatesforRFX)
  string2run=paste(caseColumnHeader,"+",ageColumnHeader,"+",sexColumnHeader,sep=" ")

  if (otherCovariatesN > 0) {
  for (covariate in 1:otherCovariatesN) {
    covName=as.character(covariates[covariate])
    caseControl_covariatesforRFX[,length(caseControl_covariatesforRFX)+1] = datafile[rows2use,covName];
    colnames(caseControl_covariatesforRFX) = c(origcolnames,covName);
    origcolnames=colnames(caseControl_covariatesforRFX)
    string2run=paste(string2run,"+",covName,sep=" ")
    }
  }
  if (otherCatCovariatesN > 0) {
    for (covariate in 1:otherCatCovariatesN) {
      covName=as.character(covariatesF[covariate])
      caseControl_covariatesforRFX[,length(caseControl_covariatesforRFX)+1] = datafile[rows2use,covName];
      colnames(caseControl_covariatesforRFX) = c(origcolnames,covName);
      origcolnames=colnames(caseControl_covariatesforRFX)
      string2run=paste(string2run," + factor(",covName,") ",sep="")
    }
  }

  #Run the model
  #attach main file
  attach(caseControl_covariatesforRFX,warn.conflicts = FALSE)
  #print(string2run)
  eval(parse(text=paste("tmp=lm(trait ~ ", string2run, ")", sep='')))
 # tmp=lm(trait ~ eval(string2run))
  models.cort[[i]]=tmp #Store the model fit for future reference
  
  #subjects can be dropped if they are missing so we can get the precise number of controls/patients for each region tested
  n.controls[i] = length(which(tmp$model[,2] == 0))
  n.patients[i] = length(which(tmp$model[,2] == 1))
  
  #Convert the lm model to a summary format so we can extract statistics
  tmp=summary(tmp)
  tstat=tmp$coefficients[2,3] # Get t-statistic from regression to convert to Cohens d
  tstat.df=tmp$df[2]
  
  #collect effect size data
  d.cort[i]=partial.d(tstat,tstat.df,n.controls[i],n.patients[i])
  se.cort[i]=se.d2(d.cort[i],n.controls[i],n.patients[i])
  bound.cort=CI1(d.cort[i],se.cort[i])
  low.ci.cort[i]=bound.cort[1]
  up.ci.cort[i]=bound.cort[2]
  
  rm(caseControl_covariatesforRFX)
}
save(d.cort,se.cort,low.ci.cort,up.ci.cort,n.controls,n.patients, file="EffectSizes.Rdata")
save(models.cort, file="models.rda")