<h2>== TelAPI SMS Subscription Starter Kit == <h2>

<h3>What is it?</h3>
The TelAPI SMS Subscription Starter Kit is a Ruby on Rails application that expedites the process of creating an SMS subscription service. A developer simply needs to clone this repo and follow the directions below. You'll have a working SMS subscription service up and running in no time :)
<p>
<h3>How It Works</h3>
1) Head over to TelAPI and signup for a TelAPI account: http://www.telapi.com
<p>
2) Purchase a TelAPI phone number through the TelAPI dashboard
<p>
3) Configure your TelAPI number's SMS Request URL to point to the following:
<p>
http://yourserversdomain.com/sms/index
<p>
3) Clone this repo
<pre><code>$ git clone git@github.com:dougiebuckets/TelAPI-SMS-Subscription-Starter-Kit.git
</code></pre>
<p>
4) Open the SMS controller in app/controllers
<p>
5) Replace the 'telapi_number' variable with your recently purchased TelAPI number
<pre><code>telapi_number = "+15555555555"</code></pre>
<p>
6) Push this code to your server
<p>
7) Perform a migration to create the user's table on your server. The user's table has a 'numbers' column where your subscriber's phone numbers will be stored. Additional migrations can be used to add new columns for other user attributes.
<pre><code>$ rake db:migrate
</code></pre>
<p>
8) Have a beer and celebrate
