class VendorsController < ApplicationController
  def index
    @tweets = SocialTool.twitter_search
  end
end
