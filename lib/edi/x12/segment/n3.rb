module EDI
  module X12
    module Segment

      #
      # N301 (Address Information)
      # - example: address line 1 
      # N302 (Address Information)
      # - example: address line 2 (or apt number, etc)
      #
      class N3 < EDI::Segment

        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Address Information', :description => 'Address information line 1.',
            :ref     => 'N301', :req  => 'O', :type => 'AN', :min  => 1, :max  => 55,
            :value   => @options[:n301] ||= @options[:address1]
          ))
          add_child(Element.new(
            :name    => 'Address Information', :description => 'Address information line 2.',
            :ref     => 'N302', :req  => 'O', :type => 'AN', :min  => 1, :max  => 55,
            :value   => @options[:n302] ||= @options[:address2]
          ))
        end
        
      end

    end
  end
end