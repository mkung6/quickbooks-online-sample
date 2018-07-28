# quickbooks-online-sample
Sample QBO partial implementation in Angular and Rails

Run ngrok and paste the URI in `QBOconfig.yml` and your Intuit Developer account. Paste your client_id and secret that you receive from Intuit. 

In the `sub-header-management` I created a a link to connect to QBO. It makes a call to `Invoice.oauth()` in the sub-header directive, which returns a JSON object. The object is constructed in `invoices_controller.rb`, which reads the details from the YAML file. We then read the object on the front end to create a URL to start the flow, detailed by [OAuth2.0 docs](https://developer.intuit.com/docs/00_quickbooks_online/2_build/10_authentication_and_authorization/10_oauth_2.0).
