# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'hopify@noreply.com'
  layout 'mailer'
end
