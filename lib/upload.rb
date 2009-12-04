class UploadLogger < Logger
  def format_message(severity, timestamp, progname, msg)
    "#{progname} #{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n" 
  end 
end 
