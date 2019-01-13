require 'mail'
require 'date'
require 'dotenv/load'
require_relative 'wallpaper_email_presenter.rb'

class EmailSender
  OPTIONS = { :address              => "smtp.gmail.com",
              :port                 => 587,
              :user_name            => ENV['GMAIL_USERNAME'],
              :password             => ENV['GMAIL_PASSWORD'],
              :authentication       => 'plain',
              :enable_starttls_auto => true  }

  def initialize
    Mail.defaults do
      delivery_method :smtp, OPTIONS
    end
  end

  def send_email
    email_body = WallpaperEmailPresenter.new().full_view
    date = current_date
    sender = email_sender
    recipient = email_recipient

    Mail.deliver do
      from    sender
      to      recipient
      subject "Email Newsletter for #{date}"

      html_part do
        content_type 'text/html; charset=UTF-8'
        body email_body
      end
    end
  end

  def current_date
    day = DateTime.now.strftime("%d")
    month = Date::MONTHNAMES[Date.today.month]
    "#{month} #{day}"
  end

  private

  def email_sender
    ENV['GMAIL_USERNAME']
  end

  def email_recipient
    ENV['GMAIL_USERNAME']
  end
end
