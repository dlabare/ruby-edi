require 'date'
require 'rubygems'
require 'ruby-debug'

module EDI
  class MalformedDocumentError < StandardError; end
end

Dir["./edi/**/**"].each do |path|
  require File.join(path) unless File.directory?(path)
end
