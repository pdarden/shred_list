class Map < ActiveRecord::Base

  def listing_count(state)
    Listing.where(state_id: State.where(name: state)).count
  end

  def states
    [
      ["AK"],
      ["AL"],
      ["AR"],
      ["AS"],
      ["AZ"],
      ["CA"],
      ["CO"],
      ["CT"],
      ["DC"],
      ["DE"],
      ["FL"],
      ["GA"],
      ["GU"],
      ["HI"],
      ["IA"],
      ["ID"],
      ["IL"],
      ["IN"],
      ["KS"],
      ["KY"],
      ["LA"],
      ["MA"],
      ["MD"],
      ["ME"],
      ["MI"],
      ["MN"],
      ["MO"],
      ["MS"],
      ["MT"],
      ["NC"],
      ["ND"],
      ["NE"],
      ["NH"],
      ["NJ"],
      ["NM"],
      ["NV"],
      ["NY"],
      ["OH"],
      ["OK"],
      ["OR"],
      ["PA"],
      ["PR"],
      ["RI"],
      ["SC"],
      ["SD"],
      ["TN"],
      ["TX"],
      ["UT"],
      ["VA"],
      ["VI"],
      ["VT"],
      ["WA"],
      ["WI"],
      ["WV"],
      ["WY"]
    ]
  end

end
