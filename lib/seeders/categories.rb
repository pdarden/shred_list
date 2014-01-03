module Seeders
  module Categories
    class << self
      def seed
        categories.each do |name|
          Category.find_or_create_by(name: name) do |category|
            category.name = name
          end
        end
      end

      def categories
        [
          "Completes",
          "Decks",
          "Trucks",
          "Wheels",
          "Bearings",
          "Bushings",
          "Helmets",
          "Pads",
          "Slide Gloves",
          "Slide Pucks",
          "Grip Tape",
          "Hardware",
          "Risers/Shock Pads",
          "Tools",
          "Nose Guards",
          "GoPro Cameras",
          "Big Sticks"
        ]
      end

    end
  end
end
