$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'layout_configurator'

run LayoutConfigurator::Api.new