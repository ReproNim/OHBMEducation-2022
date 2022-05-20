# OHBMEducation-2022
Repo for the [2022 OHBM Education](https://www.humanbrainmapping.org/i4a/pages/index.cfm?pageid=4055) 1/2 day course entitled: ["How to Write a Re-Executable Publication"](https://www.humanbrainmapping.org/files/2022/2022%20Annual%20Meeting/%231162_Education_Course_Half_Day_-_How_to_Write_a_Re-executable_Publication.pdf)

**When**: June 19th, 1pm-5pm local time

**Where**: Glasgow, Scotland

# Objective
The goal of this 1/2 day (4 hour) course is to have the students **DO** a re-executable publication.

# Instructors (for the credit)
* [Julie Bates](https://profiles.umassmed.edu/display/11661391) - University of assachusetts Chan Medical School
* [Dorota Jarecka](https://gablab.mit.edu/team/jarecka-dorota/) - MIT
* [Peer Herholtz](https://peerherholz.github.io/) - McGill and ???
* [Stephan Heunis](https://jsheunis.github.io/) - Institute of Neuroscience and Medicine, Forschungszentrum Jülich
* [Neda Jahanshad](https://keck.usc.edu/faculty-search/neda-jahanshad/) - Universty of Southern California
* [Stephen Strother](TODO)

# Orginizers (for the blame)
* [David Kennedy](https://profiles.umassmed.edu/display/130002) - University of assachusetts Chan Medical School
* [JB Poline](https://www.mcgill.ca/neuro/jean-baptiste-poline-phd) - McGill

# Prerequsites
* A computer with internet and browser
* A GitHub Account (Need one, go [here](https://github.com/signup?ref_cta=Sign+up&ref_loc=header+logged+out&ref_page=%2F&source=header-home)!)


# Tentative Schedule
1:00 - 1:05 (5 minutes)   Introduction to the course (DNK/JBP) - Link to slides - Link to video

1:05 - 1:20 (15 minutes) What is a ReproPub and why would we want one? (JFB) - Link to slides - Link to video

1:20 - 1:35 (15 Minutes) Introduction to the publication you are going to do (NJ) - Link to slides - Link to video
* ENIGMA has some Parkinson’s Disease (PD) results
* You have some ‘new’ PD data
* Do you see what ENIGMA did?

1:35 - 1:50  (15 minutes) What are containers, in general (DJ) - Link to slides - Link to video

1:50 - 2:05  (15 minutes) How to make a specific “simple container” (containing FSL) (PH) - Link to slides - Link to video

2:05 - 2:20  (15 minutes) Brief intro to DataLad (aka DataLad does it all...) (SH) - Link to slides - Link to video
* installing data 
* running containers 
* publishing results

2:20 - 4:30 “Just do it” - [Exercise](../Exercise/README.md)
* Here are your command lines
* Here is the JupyterHub
* Do it, lots of ReproStaff around to help answer questions or problems

2:30 - 2:45 Break

4:30 - 4:45 (15 minutes) Meta and mega analysis of your results (NJ+DNK) - Link to slides - Link to video

4:45 - 5:00  (15 minutes) Recap and Summary (SS) - Link to slides - Link to video


# Approach Overview
What do we mean by 'do a re-executable' publication?
* [DataLad](https://www.datalad.org/) install a particular dataset
* [DataLad containers-run](http://handbook.datalad.org/en/latest/basics/101-133-containersrun.html) a particular container (that generates some derived images and results in NIDM)
* [DataLad "Publish"](http://docs.datalad.org/projects/deprecated/en/latest/generated/man/datalad-publish.html) the resulting dataset
* [pynidm](https://github.com/incf-nidash/PyNIDM) query the results, and run a specific statistical test
* "Publish" the NIDM results to the [ReproLake](https://www.youtube.com/watch?v=VQ5t24mrvJI)
