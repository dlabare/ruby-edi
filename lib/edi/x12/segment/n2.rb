module EDI
  module X12
    module Segment

      #
      # N201 (Additional Name)
      # 
      # N202 (Additional Name)
      #
      class N2 < EDI::Segment

        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Additional Name', :description => 'Additional space for longer names.',
            :ref     => 'N201', :req  => 'O', :type => 'AN', :min  => 1, :max  => 60,
            :value   => @options[:n201] ||= @options[:additional_name]
          ))
          add_child(Element.new(
            :name    => 'Additional Name', :description => 'Additional space for longer names.',
            :ref     => 'N202', :req  => 'O', :type => 'AN', :min  => 1, :max  => 60,
            :value   => @options[:n202] ||= @options[:additional_name2]
          ))
        end
        
      end

    end
  end
end