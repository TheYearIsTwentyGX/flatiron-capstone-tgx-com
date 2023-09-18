formatter = proc { |severity, datetime, _progname, msg|
  "\n\n==================== #{severity} START ====================\n" \
    "Output at: #{datetime.strftime("%m-%d %H:%M:%S")}\n\n" \
    "#{msg}\n" \
    "\n==================== #{severity} END ====================\n\n\n"
}

MultiLogger.add_logger("look_at_me_im_a_target", formatter: formatter, level: "error")
