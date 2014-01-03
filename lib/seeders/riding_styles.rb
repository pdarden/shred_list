module Seeders
  module RidingStyles
    class << self
      def seed
        riding_styles.each do |name|
          RidingStyle.find_or_create_by(name: name) do |riding_style|
            riding_style.name = name
          end
        end
      end

      def riding_styles
        [
          "Cruising/Carving",
          "Distance",
          "Downhill",
          "Freeride",
          "Freestyle",
          "230lbs and Up"
        ]
      end
    end
  end
end
