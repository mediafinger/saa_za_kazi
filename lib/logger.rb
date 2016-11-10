class Logger
  def self.error(klass, action, options = {})
    puts "******** error in class #{klass} method #{action} ********"
    puts options.inspect unless options.empty?
    puts "**********************************************************"
  end
end
