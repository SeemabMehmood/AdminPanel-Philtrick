class  CustomDeviseMailer < Devise::Mailer

  def confirmation_instructions(record, token, opts={})
    @password = record.password
    super
  end
end