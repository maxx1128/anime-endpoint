require 'mail'
require_relative '../lib/email_sender.rb'

describe EmailSender do
  let(:mail_options) { EmailSender::OPTIONS }

  it "sends an email" do
    Mail.defaults do
      delivery_method :test
    end

    Mail::TestMailer.deliveries

    Mail.deliver do
      to 'mikel@me.com'
      from 'you@you.com'
      subject 'testing'
      body 'hello'
    end

    expect(Mail::TestMailer.deliveries.length).to eq(1)

    Mail::TestMailer.deliveries.clear
  end
end
