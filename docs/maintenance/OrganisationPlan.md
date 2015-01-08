# Zonemaster - Organization plan

## Internal organization 

A number of roles have been identified during the maintenance period : 
* Developers
* Code reviewer
* Tester for Quality Assurance
* Translators
* Release manager
* Package maintainer
* Roadmap owner
* Github manager
* Mailinglist moderator
* Mailinglist owner
* Support for questions on Github and mailinglists
* Operator of website and ASN lookup service
* Content editor, web site
* Service manager
* Technical manager
* Project manager

### Developers
The developers are responsible for the specifications that implements the
requirements and that the code follows the specifications.

The developer should run sufficient developer testing to ensure that the functionality is complete and the major use cases pass.
 
### Code reviewer
All code should be reviewed by a developer other than the developer himself. The person who is attributed the role of reviewing the code is the "Code reviewer". 

### Tester for Quality Assurance (QA)
The changes in each release are tested against the requirements and the
specification. 

Ideally a second developer or tester then does manual testing of the features to include success and failure cases and corner cases. Any issues found are recorded on the Github issue tracker for the development for the original
developer to fix before re-testing. For major developments a separate testing issue may be created.

Regression tests should then also be put in place to cover the functionality.

### Translators
The initial translations of the software, FAQs, web interfaces and so on, are for the English, French and Swedish languages. Any user can contribute new
languages for addition to the project, but any language added should be a
complete translation of the current set of strings.

Any new language added to the software requires a person to be responsible for that translation. Since strings may change between releases, it is important that the new strings will be translated for all the languages.

There might be a need to have somebody to be responsible for translations, and that this responsibility includes having personal contacts with the translators. This role also has the responsibility for the translation documentation and processes.

### Release Manager
The release managers are responsible for going through the Github issue tracker for any new issues and delegate the issue to a responsible developer for fixing the problem. The issue should also be prioritized and planned for a release. When possible, the full dialogue with the reporter of the issue should go into this Github issue.

The Release Manager is responsible for the Release Process and the Release
Management Process, and can veto the decision to execute the release.

The release manager could also someteimes play the role of code reviewer.

### Package Maintainer 
Package maintainers test the package before the release of any final version.

The RC versions are often tested by the package maintainers, and it is also a good way to see that the release are working on the platforms that the software is distributed with.

### Roadmap Owner
The roadmap is a public document in the Github source code tree or wiki.

The Roadmap owner has the responsibility for the roadmap, and decides on the
content and timing of each release in coordination with project management and the developer team.

### Github manager
ToDo

### Mailinglist moderator
The moderator of the mailinglists have the responsibility to add and
remove users on the lists (although the two public lists are open for
subscription), and to moderate the lists if needed (remove spam and so on).

### Mailinglist owner
The owner of the mailinglists have the responsibility to add and
remove users on the lists (although the two public lists are open for
subscription), and to moderate the lists if needed (remove spam and so on).

### Support for questions on Github and mailinglists

ToDo

### Operator of website and ASN lookup service

The operator of the website is intended to do the following
* Make sure that the service is up
* Monitor the service as well as the different modules required to run the
  service
* Collect user statistics and able to furnish them when necessary

The operator of the ASN look up service is intended to do the following:
* Make sure that the service is up
* Monitor the service as well as the different modules required to run the 
  service
* Collect user statistics and able to furnish them when necessary

### Content editor, web site 
The web site needs content, and it has to be regularly updated to reflect
changes in the project. Examples of content on the web site that has to be
maintained:

* About the project
* Current versions of the software
* Features of the software
* Roadmap
* How to get support
* Documentation for users
* Documentation for developers
* License text
* Download links
The Content editor has responsibility to update the content on the web site. 
### Service manager

Service managers activity includes for instance the promotion of Zonemaster in a collaborative way and through multiple channels (dedicated web site, meetings, workshops…) during the maintenance cycles;

### Technical manager

Responsibilities essentially include: 
•	Being responsible for the Zonemaster’s software published as open source in accordance with the requirements of Zonemaster’s Maintenance Plan.
•	Leading the development teams work.
•	Keep the Service Manager updated on the work of the development teams the status of the Zonemaster software.
•	Assist the Service Manager in hers/his work to produce Zonemaster’s Service Plan.


### Service manager

Responsibilities essentially include: 
•	Being responsible for Zonemaster’s day to day business with the Internet community and ensure that it is run and developed optimally in accordance with the approved Service Plan.
•	Being the document owner of Zonemaster’s Service Plan. 
•	Ongoing Status reporting to the steering committee including progress and financial monitoring of the service.
•	Participate in the steering committee’s meetings.
•	Delegate the technical issues conserving the Zonemaster’s software to the Technical Manager and keep a close cooperation with him/hear in common matters.
•	Prioritizing the work of the development team and provide the Technical Manager with work orders regarding larger functional changes (Major releases) of the Zonemaster software and approve the delivery of the results.
•	Cooperate with Afnic’s and .SE’s internal marketing and communication teams. 

### Steering Committee

Responsibilities essentially include: 
•	Evaluate the effectiveness and adherence to the MoU.
•	Appoint the roles within Zonemaster’s organization, including the Service manager, Technical Manager and Test specification document owner.
•	Responsible for the strategic direction of Zonemaster. 
•	Approve Zonemaster’s Service Plan including budget, goals, product roadmap, and a promotion and communication plan.
•	Meet on a monthly bases, evaluate status reports, and if needed handle escalated issues. 

