module EDI
  module X12
    module Segment

      #
      # PID01 (Item Description Type)
      # - F Free-form
      # PID05 (Description)
      #
      class PID < EDI::Segment
        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Item Description Type', :description => 'Code indicating the format of a description',
            :ref     => 'PID01', :req  => 'M', :type => 'ID', :min  => 1, :max  => 1,
            :value   => @options[:pid01] ||= @options[:item_description_code],
            :default => 'F'
          ))
          add_child(Element.new(
            :name    => 'Product/Process Characteristic Code', :description => '',
            :ref     => 'PID02', :req  => 'O', :type => 'ID', :min  => 2, :max  => 3,
            :value   => @options[:pid02]
          ))
          add_child(Element.new(
            :name    => 'Agency Qualifier Code', :description => '',
            :ref     => 'PID03', :req  => 'O', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:pid03]
          ))
          add_child(Element.new(
            :name    => 'Product Description Code', :description => '',
            :ref     => 'PID04', :req  => 'O', :type => 'AN', :min  => 1, :max  => 12,
            :value   => @options[:pid04]
          ))
          add_child(Element.new(
            :name    => 'Product Description', :description => 'Description of the product',
            :ref     => 'PID05', :req  => 'M', :type => 'AN', :min  => 1, :max  => 80,
            :value   => @options[:pid05] ||= options[:description]
          ))
          add_child(Element.new(
            :name    => 'Surface/Layer/Position Code ', :description => '',
            :ref     => 'PID06', :req  => 'O', :type => 'ID', :min  => 2, :max  => 2,
            :value   => @options[:pid06]
          ))
          add_child(Element.new(
            :name    => 'Source Subqualifier', :description => '',
            :ref     => 'PID07', :req  => 'O', :type => 'AN', :min  => 1, :max  => 15,
            :value   => @options[:pid07]
          ))
          add_child(Element.new(
            :name    => 'Yes/No Condition or Response Code', :description => '',
            :ref     => 'PID08', :req  => 'O', :type => 'ID', :min  => 1, :max  => 1,
            :value   => @options[:pid08]
          ))
          add_child(Element.new(
            :name    => 'Language Code ', :description => 'Code identifying the language',
            :ref     => 'PID09', :req  => 'O', :type => 'ID', :min  => 2, :max  => 3,
            :value   => @options[:pid09]
          ))
        end
      end

    end
  end
end