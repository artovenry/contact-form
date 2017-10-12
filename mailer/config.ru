root= File.expand_path "..", __FILE__

require "#{root}/application.rb"

map("/") {run Application}
