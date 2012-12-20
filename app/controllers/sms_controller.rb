# This SMS contoller is used to address incoming 'subscribe' and 'unsubscribe'requests

class SmsController < ApplicationController
  def index
  	# Enter your TelAPI number below
  	telapi_number = "+15555555555"

  	# Assign the number from which the SMS is being received to a variable
    from_number = params["From"]

    # Assign the body of the SMS received to a variable    
    sms_body = params["Body"]

    # In the case that a User texts in 'subscribe' but has already subscribed,
    # then let them they're already subscribed.

    if sms_body.downcase.gsub(/\s+/, "") == "subscribe" and User.where(:number => from_number).exists?
      xml = Telapi::InboundXml.new do
        Sms(
          "Hi there - You're already subscribed to this service.",
          :action => "http://liveoutput.com/YBaBRd8k",
          :method => "POST",
          :from => telapi_number,
          :to => from_number
        )
      end

    # In the case that a User texts in 'subscribe' and hasn't already subscribed,
    # let them know that they are now subscribed.

    elsif sms_body.downcase.gsub(/\s+/, "") == "subscribe" 
      xml = Telapi::InboundXml.new do
        Sms(
          "Thanks for subscribing to this service!",
          :action => "http://liveoutput.com/YBaBRd8k",
          :method => "POST",
          :from => telapi_number,
          :to => from_number
        )
      end

      # Create an instance of user which can be saved to the database

      @user = User.new
	  @user.number = from_number
	  @user.save

	# In the case that a User texts in 'unsubscribe', let them know they
	# have unsubscribed and delete them from the database.

	elsif sms_body.downcase.gsub(/\s+/, "") == "unsubscribe"
      xml = Telapi::InboundXml.new do
        Sms(
          "You have now unsubscribed from this service. Hope to see you again soon.",
          :action => "http://liveoutput.com/YBaBRd8k",
          :method => "POST",
          :from => telapi_number,
          :to => from_number
        )
      end

      # Delete user from the database

      User.where(number: params["From"]).first.destroy

      # If a user texts in something other than 'subscribe' or 'unsubscribe'
      # let them know this is not recognized by the service.

    else
      xml = Telapi::InboundXml.new do
        Sms(
          "Did you mean to text 'Subscribe' to this number to use this service?",
          :action => "http://liveoutput.com/2R2MqQNn",
          :method => 'POST',
          :from => telapi_number,
          :to => from_number
        )
      end
    end

    # Respond in XML format per TelAPI InboundXML requirements

    respond_to do |format|
      format.xml { render :xml => xml.response }
    end
  end
end
