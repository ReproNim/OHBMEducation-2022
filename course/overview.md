# course overview

As mentioned on the [Welcome page](https://repronim.github.io/OHBMEducation-2022/index.html), this course will be focus on `re-executable publications` and cover various important aspects from an introduction to the problem and motivation to adapt neuroimaging research workflows accordingly to the utilization of basic and advanced tools/resources. In general, the idea is to do a split between first, the basics of how to write a `re-executable publication` and second, providing first hands-on experience based on examples. Regarding the first, we will try to provide attendees with a brief overview of central aspects, as well as important issues and concerning the second, work through an example workflow from beginning to end together. Thus, we will go through and practice the use of respective software, tools and resources. We will further explain both aspects, as well as the `setup`, etc. below. For a precise outline of this course, please consult the respective [page](https://repronim.github.io/OHBMEducation-2022/outline.html). 


## The framework and setup

All course materials will be provided within the [Jupyter Book](https://jupyterbook.org/intro.html) format you're currently looking at, free for everyone to check and try out, as well as utilize further. The course itself will use a mixture of slides, code and other media within presentations, practical hands-on sessions and discussion rounds to enable a holistic introduction paired with firsthand experience. Depending on a given participant's computational resources and infrastructure, we provide multiple ways to participate in the course as outlined in the [Setup for the course](https://repronim.github.io/OHBMEducation-2022/setup.html) section.    

## Instructors

To provide a holistic introduction into the topic of `re-executable publications` and its subcomponents, we assembled a stellar team of instructors entailing highly experience experts of both the `ReproNim` team as well as colleagues & collaborators. You can find them below and get further information via clicking on the respective names. 

<table>
  <tr>
    <td align="center">
      <a href="https://profiles.umassmed.edu/display/11661391">
        <img src="" width="100px;" alt=""/>
        <br /><sub><b>Julie Bates</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/djarecka">
        <img src="https://www.abcd-repronim.org/assets/img/gallery-90-13-rev2.jpg" width="100px;" alt=""/>
        <br /><sub><b>Dorota Jarecka (she/her)</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/dnkennedy">
        <img src="https://www.abcd-repronim.org/assets/img/gallery-90-2-rev2.jpg" width="100px;" alt=""/>
        <br /><sub><b>David Kennedy (he/him)</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/jbpoline">
        <img src="https://www.abcd-repronim.org/assets/img/gallery-90-4-rev2.jpg" width="100px;" alt=""/>
        <br /><sub><b>Jean-Baptiste Poline (he/him)</b></sub>
      </a>
    </td>  
    <td align="center">
      <a href="https://keck.usc.edu/faculty-search/neda-jahanshad/">
        <img src="https://researcherprofiles.org/profile/Modules/CustomViewPersonGeneralInfo/PhotoHandler.ashx?NodeID=177544" width="100px;" alt=""/>
        <br /><sub><b>Neda Jahanshad</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://jsheunis.github.io/">
        <img src="https://scholar.googleusercontent.com/citations?view_op=view_photo&user=4smzqdQAAAAJ&citpid=1" width="100px;" alt=""/>
        <br /><sub><b>Stephan Heunis </b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/PeerHerholz">
        <img src="https://avatars.githubusercontent.com/u/20129524?s=96&v=4" width="100px;" alt=""/>
        <br /><sub><b>Peer Herholz (he/him)</b></sub>
      </a>
    </td>
  </tr>
</table>


```{admonition} How to address one another?
:class: dropdown
When contacting us, please refrain from using titles when addressing us and super formal language, using our first names is fine and it’s way more important that the content is respectful, fair and constructive (We aim for the same when we reply). However, please let us know if you have a preferred way of interacting with other folks, including how you would liked to be addressed, your pronouns and the level of formality.
```

### Gimme the details

Below you will find important details regarding the course summarized in a compact form. Please consult and familiarize yourself with the information presented there prior to the course. 

#### When and where

The course will take place via two distinct options: in-person, 19/06/2002, 1-5 PM BST & virtually. The respective links will be provided for registered participants shortly before the course.

#### Can I use my calculator? 🖥️

Short answer: no. The workflows, tools and resources we are going to explore in this course require a certain setup and thus computational infrastructure. In order to keep things simple, we will provide all attendees with access to [cloud computing resources]() that fulfill all requirements. However, you can also use your own machine but it should be able to run `bash`, `git`, `docker`/`singularity` and `python` among other things. Furthermore, it will need to be running a standard operating system like `Windows`, `Mac OS X`, or `Linux`. Unfortunately, tablets running mobile operating systems (`iOS`, `Android`) probably won't work for this purpose. If this is an issue for you, please get in touch with the instructors as soon as possible so that we can try to figure out a solution. Regarding `software` and `installation` thereof, please check the next section.

<iframe src="https://giphy.com/embed/DHqth0hVQoIzS" width="240" height="103" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/maths-DHqth0hVQoIzS">via GIPHY</a></p>

#### How do I get all the software locally and do I have to apply for a loan to get it? 🖥️

If you decide to use your own machine: Don't worry at all. First, in order to help you get all the software required for the course, a [comprehensive installation instruction](http://www.repronim.org/OHBMEducation-2022/setup.html) was compiled. In a step-by-step manner it guides you through the installation process, covering several `OS`: `windows`, `macos` and `linux`. Second, everything will be completely free of charge as we will only use publicly available [open-source software](https://en.wikipedia.org/wiki/Open-source_software). Why? Because teaching students via [proprietary software](https://en.wikipedia.org/wiki/Proprietary_software) is just not fair and won't help anyone: students have to obtain licenses or use those from the university (which usually doesn't have enough for everyone), leading to tremendous problems regarding inequity now and in the future. Additionally, [opens-source software](https://en.wikipedia.org/wiki/Open-source_software) can do everything, if not more, what [proprietary software](https://en.wikipedia.org/wiki/Proprietary_software) can and is furthermore usually better supported, tested and documented, creating a fantastic sense of community. 

<iframe src="https://giphy.com/embed/CTX0ivSQbI78A" width="240" height="177" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/internet-computer-technology-CTX0ivSQbI78A">via GIPHY</a></p>

#### Where is everything?

All course materials (lecture slides, recordings, lecture demo notebooks, etc.) will be available on the [course website](http://www.repronim.org/OHBMEducation-2022/index.html), i.e. the one you're looking at right now. Everything will be completely open and free to use, thus constituting an [open educational resource](https://en.wikipedia.org/wiki/Open_educational_resources) you are free to explore, enhance and share. Thus, this website and all materials will also remain up for the entire duration of the course and beyond, ideally to end of the internet. The usage of this resource and the materials therein will be explained at the beginning and throughout the course.  

<iframe src="https://giphy.com/embed/c20UV66B7zCWA" width="240" height="155" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/superman-phone-looking-c20UV66B7zCWA">via GIPHY</a></p>

#### Syllabus and Text

As noted above, this page serves as the syllabus for this course, with the precise outline indicated in the [respective section](http://www.repronim.org/OHBMEducation-2022/outline.html). As usual, the syllabus is subject to change.

#### Code of conduct

This course has a `Code of conduct`. Please inform yourself about the specifics by carefully reading through the [respective section](http://www.repronim.org/OHBMEducation-2022/CoC.html).

<iframe src="https://giphy.com/embed/l5s71uAp3CzKwxwkoZ" width="240" height="200" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/theoffice-nbc-the-office-tv-l5s71uAp3CzKwxwkoZ">via GIPHY</a></p>


### How to Get Your Question(s) answered and/or provide feedback 🙋🏼‍♀️ ⁉️

It’s great that we have so many ways to communicate, but it can get tricky to figure out who to contact or where your question belongs or when to expect a response. These guidelines are to help you get your question answered as quickly as possible and to ensure that we’re able to get to everyone’s questions.

That said, to ensure that we’re respecting everyone's time, we will mainly answer pre-/post-course questions between normal working hours (M-F 9AM-5PM). The instructors are also going to do their best to stick to these working hours when they want to share information. However, they know that’s not when you may be doing your work. So, please feel free to post messages whenever is best for you while knowing that if you post late at night or on a weekend, you may not get a response until the next weekday. As such, do your best not to wait until the last minute to ask a question.

If you have:

- questions about course content - these are awesome! We want everyone to see them and have their questions answered too, so either use the [hypothes.is](https://web.hypothes.is/) plugin, `e-mail` or the [GitHub repository](https://github.com/repronim/OHBMEducation-2022/issues).

- a technical assignment question - come to us. Be as specific as you can in the question you ask. And, for those answering, help your fellow participants as much as you can without just giving the answer. Help guide them, point them in a direction and provide pseudo code.

- been stuck on something for a while (>30min) and aren’t even really sure where to start - Computational work can be frustrating and it may not always be obvious what is going wrong or why something isn’t working. That’s OK - we’ve all been there! IF you are stuck, you can and should reach out for help, even if you aren’t exactly sure what your specific question is. To determine when to reach out, consider the 2-hour rule. This rule states that if you are stuck, work on that problem for an hour. Then, take a 30 minute break and do something else. When you come back after your break, try for another 30 minutes or so to solve your problem. If you are still completely stuck, stop and contact us (office hours). If you don’t have a specific question, include the information you have (what you’re stuck on, the code you’ve been trying that hasn’t been happening, and/or the error messages you’ve been getting).

- questions about course logistics - first, check the [overview](http://www.repronim.org/OHBMEducation-2022/overview.html) & [syllabus](http://www.repronim.org/OHBMEducation-2022/outline.html). If you can’t find the answer there, first ask a fellow participant or instructor. 

- something super cool to share related to the course or want to talk about a topic in further depth - feel free to share or contact the instructors. 

- some feedback about the course you want to share anonymously - If you’ve been offended by an example in the course, really liked or disliked a lesson, or wish there were something covered in the course that wasn’t but would rather not share this publicly, etc., please fill out the anonymous [Google Form]()*

*This form can be taken down at any time if it’s not being used for its intended purpose; however, you all will be notified should that happen.

### Acknowledgements

Several parts of this section are directly taken or adapted from [Alexander Huth's Neuro Data Analysis in Python syllabus](https://github.com/alexhuth/ndap-fa2020) licensed under a [BSD-3-Clause License](https://github.com/alexhuth/ndap-fa2020/blob/master/LICENSE) and [Shannon Ellis' COGS 18: Introduction to Python](https://cogs18.github.io/assets/intro/syllabus.html).