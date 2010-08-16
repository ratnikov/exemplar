require 'exemplar'

class Exemplar::Example
  # <tt>Exemplar::Example</tt> invoked <tt>rescue_error</tt> when it encounters an error during
  # execution of an example. While the default implementation is logging a simple error message,
  # it's possible to change that behavior by providing a handler of our own:
  def rescue_error(error)
    case error
    when ZeroDivisionError then log("Tried to divide by a zero. Bah!")
    when ArgumentError then log("Whoops, bad argument!")
    else
      log("Unknown error: %s" % error.inspect)
    end
  end
end

example "adding two numbers together" do
  puts "1 + 5 = %s" % (1 + 5)
end

example "subtracting a number" do
  puts "5 - 1 = %s" % (5 - 1 )
end

example "error catching" do
  # this should be caught by our custom error rescuer
  puts "5 / 0 = %s" % (5 / 0)
end
