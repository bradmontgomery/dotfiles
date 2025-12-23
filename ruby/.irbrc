require 'rubygems'
require 'ori'
require 'looksee'
# Wirble config: http://pablotron.org/software/wirble/
begin
  # load wirble
  require 'wirble'
  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end
