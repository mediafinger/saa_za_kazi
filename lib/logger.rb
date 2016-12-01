class Logger
  def self.error(klass, action, options = {})
    STDERR.puts "******** error in class #{klass} method #{action} ********"
    STDERR.puts options.inspect unless options.empty?
    STDERR.puts "**********************************************************"
  end
end
