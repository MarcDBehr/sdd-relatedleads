Related Leads List
Author: Ryan Headley (via System dot Debug)

Hello debuggers! It is our pleasure to hand over to our community followers a rather simple
lightning component which was the brain child of our very own team member Tom Blamire!

Basically, we've added a custom field to the Account object called Email Domain (Email_Domain__c).
This field is meant to hold one or more domains that will be matched against email addresses for existing 
Leads in your system. Upon finding leads that match the domain(s) listed in the Email Domain field, they
will be displayed in the component like so:

Jane Doe
jane.doe@example.net
View

Click the View link to view the Lead record and form there, work with the Lead as you normally would.


To Install:
This project uses Salesforce DX, so clone this project and deploy to your orgs via salesforce dx. In addition, we have an unmanaged package you can install from as well here:  https://login.salesforce.com/packaging/installPackage.apexp?p0=04t1N000002Cyev

This code is free for you to install, use, and modify -- however you may NOT include this in any packages that will be sold or offered in the appexchange. It is handed over as-is and with no warantee, guarantee, or black tea with a twist of lemon.
