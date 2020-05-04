/* COVID Rapid Response Team Volunteer Log Analysis */ 

clear /*clears stata*/
set more off /*allows output over 1 screen length*/
capture log close /*closes any log files*/

/*this creates a log on a separate document of all the commands and outputs 
using this code, make sure to change file name each time you run to keep the new log file or else if will replace thre previous file*/
log using "/Users/christina/Desktop/COVID:Stata Files/Volunteer_Tracking_Responses_5.1.2020_version2.log", replace


/***** Bring in the data using the drop down menus (file, import, most recent downloaded excel sheet - choose the form responses master click option to make the first row the variable names) ******/


*puts the variables in alphabetical order 
*order _all, alphabetic


/* describes your current data set, including variable name, storage type
display format, value label and variable label */ 
desc 

********************************************************************************
****************************** GENERATING NEW VARIABLES ************************
********************************************************************************

/*gen command creates the new variable, and compare command compares the two variables to make sure they are the same */ 


**** 1 ******
/* Did you come into contact with other student volunteers during your volunteer activities on this date, yes or no */ 

gen volunteer_contact = Didyoucomeincontactwithoth

*checks if the new variable matches the old one 
compare volunteer_contact Didyoucomeincontactwithoth

tab volunteer_contact Didyoucomeincontactwithoth

*another way to check if the new variable matches the old one (output should be 0)
count if Didyoucomeincontactwithoth~=volunteer_contact




**** 2 ******
/* If you answered yes to the question above, please list the first and last name(s) of the student volunteer(s) you were in close contact with. (NOTE: If you're a volunteer with CRRT Screening & Support Field Team just put "Screening & Support Field Team" in the text box below). - OPEN TEXT */ 

gen list_volunteer_contact = Ifyouansweredyestothequest

compare list_volunteer_contact Ifyouansweredyestothequest

tab list_volunteer_contact 

tab Ifyouansweredyestothequest


**** 3 ******
/* Your full name (Please try and enter your name the same way each time) - OPEN TEXT */ 

gen full_name = YourfullnamePleasetryande

compare full_name YourfullnamePleasetryande

tab full_name

tab YourfullnamePleasetryande  


**** 4 ******
/* Date of volunteer activity */
/*
gen volunteer_date = Dateofvolunteeractivity

compare volunteer_date Dateofvolunteeractivity

this changes the variable to a different number that is indicative of time since 
January 1960 in Stata for some reason, need to figure out how to adjust this,
will keep this variable unchanged for now */ 


**** 5 ******
/* Category of volunteer service, please select all that apply - Blood drive participation, delivery or retrieval of supplies, provided clinical services, provided social services, remote activities */ 

gen volunteer_service_category = Categoryofvolunteerservicep

compare volunteer_service_category Categoryofvolunteerservicep

tab volunteer_service_category Categoryofvolunteerservicep


**** 6 ******
/* Your educational institution affiliation (Rosalind Franklin, UIC, Uchicago, Northwestern, etc.) */ 

gen institution_affiliation = Youreducationalinstitutionaff

compare institution_affiliation Youreducationalinstitutionaff

tab institution_affiliation Youreducationalinstitutionaff


**** 7 ******
/* Type in your Email Address */ 

gen email_address = EmailAddress

compare email_address EmailAddress

tab email_address

tab EmailAddress 


**** 8 ******
/* Number of hours volunteered on this date */ 

gen volunteer_hours = Numberofhoursvolunteeredont

compare volunteer_hours Numberofhoursvolunteeredont

tab volunteer_hours 

tab Numberofhoursvolunteeredont



**** 9 ******
/* Type of volunteer service: REMOTE (AT HOME) OR COMMUNITY ACTIVITIES */ 

gen remote_community = Typeofvolunteerservice

compare remote_community Typeofvolunteerservice

tab remote_community Typeofvolunteerservice


**** 10 ******
/* Which organization were you working with on this date? - SELECT ALL THAT APPLY */ 

gen organization = Whichorganizationwereyouwork

compare organization Whichorganizationwereyouwork

tab organization Whichorganizationwereyouwork


**** 11 ******
/* Did you provided any services for a physician or resident (or other HCW who might be in a supervisory grading role if you are a health professions student) during your volunteer activities on this date? - YES OR NO */ 

gen services_HCW = Didyouprovidedanyservicesfo

compare services_HCW Didyouprovidedanyservicesfo

tab services_HCW Didyouprovidedanyservicesfo


**** 12 ******
/* During your volunteer activities on this date, please select any of the following PPEs that you were wearing or had access to, in order to protect yourself against SARS-CoV-2 exposure: - SELECT ALL ANSWERS THAT APPLY */ 

gen PPE_access = Duringyourvolunteeractivities

compare PPE_access Duringyourvolunteeractivities

tab PPE_access 

tab Duringyourvolunteeractivities

*possibly consider combining some of the answer options here?


**** 13 ******
/* Only for Drivers: During your delivery today, did you follow the Driver Safety Guidelines and Instructions that you were trained with? - YES OR NO */ 

gen driver_safety = OnlyforDriversDuringyourde

compare driver_safety OnlyforDriversDuringyourde

tab driver_safety OnlyforDriversDuringyourde


**** 14 ******
/* Optional: If you would like to write a brief description of your volunteer activities, for your own records and for possible future credit, please enter it here - OPEN TEXT */ 

gen volunteer_description = OptionalIfyouwouldliketow 

compare volunteer_description OptionalIfyouwouldliketow 

tab volunteer_description 

tab OptionalIfyouwouldliketow



**** 15 ******
/* If you answered yes to the question above, please list the physician and resident name, status, specialty, and hospital affiliation (if known). - OPEN TEXT */ 

gen list_services_HCW = P

compare list_services_HCW P

tab list_services_HCW P 


**** 16 ******
/* Please indicate the locations you visited (select all that apply): *
Please do not enter names, addresses, or phones of members of the community (this is not HIPAA compliant) - SELECT ALL THAT APPLY WITH OPEN TEXT OPTION */ 

gen community_locations = Pleaseindicatethelocationsyo

compare community_locations Pleaseindicatethelocationsyo

tab community_locations 

tab Pleaseindicatethelocationsyo




********************************************************************************
********************************* DATA CHARACTERISTICS *************************
********************************************************************************

/* now will start looking at what the variables are showing us */ 

/* For the epi tracking, it is important that the number of individuals that indicated they had contact with others during their community activity matches the number of those that then entered names for who they were in contact with */

/* table command instead of tab/tabulate does not cutoff the responses
but only gives frequency and not percent and cumulative percent */ 



*gives me what Ashley listed as people she came into contact with during her shift 
table volunteer_contact if full_name=="Ashley Cohen"
 
*gives me the dates that Ashley Cohen volunteered and listed people she was in contact with 
table list_volunteer_contact Dateofvolunteeractivity if full_name=="Ashley Cohen"

*gives me the total number of volunteer hours currently input for Christina 
table volunteer_hours if full_name=="Christina Khouri"

*gives me the number of hours volunteered on certain dates for Christina 
table volunteer_hours Dateofvolunteeractivity if full_name=="Christina Khouri"

* to get an average of hours volunteered afterall 
sum volunteer_hours /* sum command used for continuous variables*/

*to get an average of hour volunteered per volunteer 
sum volunteer_hours if full_name=="Christina Khouri" 



********************************************************************************
********************************* DATA CHECKS **********************************
********************************************************************************

*checks if someone accidentally put in their name wrong twice so we can fix it 
table full_name

*check to make sure the dates are all in 2020 otherwise maybe follow-up 
table Dateofvolunteeractivity

*check to make sure someone has not put in their email wrong 
table email_address

*things that should match up
* 1 - the number of people who indicate yes on contact with others and then the number of responses we have for list_volunteer_contact

tab volunteer_contact 
tab list_volunteer_contact


