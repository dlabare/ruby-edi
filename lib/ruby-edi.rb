require 'date'
require 'rubygems'
require 'active_support/inflector'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/object/blank'

require 'yaml'

Dir["#{File.dirname(__FILE__)}/edi/**/**"].sort.each do |path|
  require File.join(path) unless File.directory?(path)
end


module EDI
  class InvalidDefaultsError   < StandardError; end
  class MalformedDocumentError < StandardError; end

  module X12

    module Loop;    end
    module Segment; end
    module Element; end

    mattr_accessor :segment_defaults, :loop_defaults

    @@segment_defaults = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../config/x12/segment_defaults.yml'))
    @@loop_defaults    = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../config/x12/loop_defaults.yml'))
    

    @@segment_defaults.each_pair do |segment, elements|
      # setup the elements
      elements.each_pair do |element, defaults|
        raise InvalidDefaultsError.new("Element #{element} - the alternate accessor cannot be in the following set: #{EDI::Element::MINIMAL_ATTRIBUTES.join(',')}") if EDI::Element::MINIMAL_ATTRIBUTES.include?(defaults['alternate'])
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

    @@loop_defaults.each_pair do |loop, segments|
      # setup loops
      self.const_get('Loop').const_set(loop, Class.new(EDI::Loop)).class_eval(%Q(
        def initialize(options = {}, parent = nil)
          super
          #{segments.collect {|segment| "s = Segment::#{segment}.new(options); add_child(s) unless s.blank?" }.join("\;") unless segments.nil?}
        end
      ))
    end
      
  end

end

