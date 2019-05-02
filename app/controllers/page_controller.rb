class PageController < ApplicationController
  def main
    @sentinels = Sentinel.all
    @sentinel = Sentinel.new
  end
end
