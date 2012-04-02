module EDI
  module X12
    module Segment

      class IEA < EDI::Segment
        
        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Number of Included Functional Groups', :description => 'A count of the number of functional groups included in an interchange',
            :ref     => 'IEA01', :req  => 'M', :type => 'N0', :min  => 1, :max  => 5,
            :value   => @options[:iea01] ||= @options[:child_count]
          ))
          add_child(Element.new(
            :name    => 'Interchange Control Number', :description => 'A control number assigned by the interchange sender.',
            :ref     => 'IEA02', :req  => 'O', :type => 'AN', :min  => 9, :max  => 9,
            :value   => @options[:iea02] ||= ("%09d" % @options[:control_number].to_i)
          ))
        end
        
      end

    end
  end
end