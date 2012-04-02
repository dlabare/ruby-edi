module EDI
  module X12
    module Segment


      # 
      # MSG01 (Free-Form Message Text)
      #
      class MSG < EDI::Segment
        
        def initialize(options = {}, parent = nil)
          super
          add_child(Element.new(
            :name    => 'Free-Form Message Text', :description => 'Free-form message text.',
            :ref     => 'MSG01', :req  => 'M', :type => 'AN', :min  => 1, :max  => 264,
            :value   => @options[:msg01] ||= @options[:message]
          ))
        end
        
      end

    end
  end
end
