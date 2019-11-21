class StaticPagesController < ApplicationController

  def home
    @users=User.all
  end

  def contact
  end
end
