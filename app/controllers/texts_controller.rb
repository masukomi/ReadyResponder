class TextsController < ApplicationController
#  skip_before_filter  :verify_authenticity_token
#  to your controller. This way all incoming requests to
#  the controller skips the :verify_authenticity_token filter.
# Alternatively
  protect_from_forgery with: :null_session,
    if: Proc.new { |c| c.request.format == 'application/json' }

  def receive_text
    # Message.create(params) or Something like that for inbound message
    sender = Person.find_by_phone(params[:From])
    render plain: "Error 421" and return if sender.blank?
    # TODO Save the incoming message
    # TODO Should the message have a link to the availability
    # that it created ? Or whatever it created...
    keyword = Message::ExtractKeyword.new(params[:Body]).call
    if keyword
      cmd_class = get_command_class(keyword)
      response = cmd_class.respond
      response_string
      if response.has_template?
        response_string = render_view(keyword)
        render partial: keyword, locals: cmd_class.template_locals
      else
        render plain: response.to_s
      end

    else
      response_string = "Hello, #{sender.fullname}"
      response_string += "Unknown Keyword"
      render plain: response_string
    end
    # Save outbound message here
  end

  def say_voice
    cell = Phone.where(content: params[:From][2..12]).first
    sender = cell.person if cell
    their_name=sender.firstname || ""
    response= <<-eos
      <?xml version="1.0" encoding="UTF-8"?>
      <Response>
        <Say voice="alice">   Check your messages now, #{their_name} !</Say>
        <Say voice="alice">#{Time.now.to_s}</Say>
      </Response>
      eos
  render plain: response
  end


  private
=begin
   Parameters: { "To"=>"+19786088448", "ToZip"=>"01862", "ToState"=>"MA",
               "ToCity"=>"BILLERICA", "ToCountry"=>"US",
               "From"=>"+19784088088", "FromCity"=>"BILLERICA",
               "FromState"=>"MA", "FromZip"=>"01862", "FromCountry"=>"US",
     "SmsMessageSid"=>"SMb6fed33f61d06c114be2ab5cd5702aa0",
     "MessageSid"=>   "SMb6fed33f61d06c114be2ab5cd5702aa0",
     "SmsSid"=>       "SMb6fed33f61d06c114be2ab5cd5702aa0",
     "MessagingServiceSid"=>"MG41b04937eadee26cb5fd10ae51d1ae86",
     "AccountSid"=>"AC38b0f9a487dcceaa9efb0cd181b1a4a9",
     "NumMedia"=>"0",   "SmsStatus"=>"received", "Body"=>"Available Navy",
      "NumSegments"=>"1",  "ApiVersion"=>"2010-04-01"}
=end
  def text_params
    params.require(:text).permit(:To, :From, :Body,
      :MessageSid, :MessagingServiceSid, :AccountSid )
  end

  def render_view(keyword)
    template = ActionView::Base.new(ActionController::Base.view_paths, {})
    template.render(file: 'confirmation/#{keyword}')
  end

  def get_command_class(keyword)
    cmd_klass_name = "Msg::#{keyword}"
    cmd_klass_name.constantize.new( {params: params,
                                                 person: sender})
  end
end
