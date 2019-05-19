# CallCenter
This is a simple application that demonstrates the ability for Call Center opertators to create and view reports of customer service they or other operators have provided to new or existing customers.

## Pages
Below is a list of pages within the application with a description of what they do.

#### Site.Master
This is the master page. It houses the sidebar, navbar, page contents, and importing of JavaScript and other libraries.

#### Login.aspx
This page is used login to the application. Logging in is done by using a C# salt and hash algorithm to match the password to the password stored in the database.

#### Default.aspx
This is the main page seen after logging in. This page varies depending on the role assigned after logging in. If the role is designated to be a Supervisor, then three tables will be populated with that user's own reports, all unresolved reports, and and all reports in the system. Operators will be able to only see own reports and unresolved reports.

#### Reporter.aspx
This page is meant for creating reports. Reports are created by filling in the required information indicated by a red asterisk. New customers are defined as not being in the database, at all, and if they are grabbed anyway. If a customer is known to be an existing customer, then the operator can simply uncheck the "New Customer" box and utilize the dropdown to search for the customer. Once all required information is in, the user can then submit the report and this report can then be seen on the home page.

#### AddOperator.aspx
This page allows supervisors to add operators to the system. Currently, supervisors set a temporary password themselves for simplicity sake. A username is automatically created based on the operator's name. The temporary password is hashed and is given a salt.

#### Contact.aspx
Very basic contact page that has fake emails for contacting.

## Libraries/Tools Used
- jQuery
- [jQuery DataTables](https://datatables.net/)
- BootStrap
- [BootStrap-Select](https://developer.snapappointments.com/bootstrap-select/)
- MySQL
- Visual Studio
