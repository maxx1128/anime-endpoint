require 'mail'
require 'date'
require 'dotenv/load'
require_relative 'wallpaper_email_presenter.rb'

class EmailSender

  def initialize
    options = { :address              => "smtp.gmail.com",
                :port                 => 587,
                :user_name            => ENV['GMAIL_USERNAME'],
                :password             => ENV['GMAIL_PASSWORD'],
                :authentication       => 'plain',
                :enable_starttls_auto => true  }

    Mail.defaults do
      delivery_method :smtp, options
    end
  end

  def send_email
    email_body = WallpaperEmailPresenter.new().full_view
    date = current_date

    Mail.deliver do
      from    ENV['GMAIL_USERNAME']
      to      ENV['GMAIL_USERNAME']
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
end
