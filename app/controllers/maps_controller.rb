class MapsController < ApplicationController
  def index
    @states = {}
    State.pluck(:id, :name).each{|m| @states[m[1]] = m[0]}
    @counts = Listing.joins(:state).group(:name).count
  end
end
