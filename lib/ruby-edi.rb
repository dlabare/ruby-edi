require 'date'
require 'rubygems'
require 'active_support/inflector'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/object/blank'

require 'yaml'
require 'ruby-debug'

Dir["#{File.dirname(__FILE__)}/edi/**/**"].each do |path|
  require File.join(path) unless File.directory?(path)
end


module EDI
  class MalformedDocumentError < StandardError; end

  module X12

    module Loop;    end
    module Segment; end
    module Element; end

    YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../config/x12/segment_defaults.yml')).each_pair do |segment, elements|
      # setup the elements
      elements.each_pair do |element, defaults|
        self.const_get('Element').const_set(element, Class.new(EDI::Element)).class_eval(%Q(
          def initialize(options = {}, parent = nil)
            options = #{defaults}.merge(options)
            super
            @options['value'] ||= @options['#{element}']
            @options['value'] ||= @options[@options[:alternate]] if @options['alternate']
          end
        ))
      end unless elements.nil?
    
      # setup the segments
      self.const_get('Segment').const_set("#{segment}", Class.new(EDI::Segment)).class_eval(%Q(
        def initialize(options = {}, parent = nil)
          super
          #{elements.keys.collect{|element| "add_child(Element::#{element}.new(options))"}.join("\;") unless elements.nil?}
        end
      ))
    end

    YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../config/x12/loop_defaults.yml')).each_pair do |loop, segments|
      # setup loops
      self.const_get('Loop').const_set(loop, Class.new(EDI::Loop)).class_eval(%Q(
        def initialize(options = {}, parent = nil)
          super
          #{segments.collect{|segment| "add_child(Segment::#{segment}.new(options))"}.join("\;") unless segments.nil?}
        end
      ))
    end
      
  end

end

