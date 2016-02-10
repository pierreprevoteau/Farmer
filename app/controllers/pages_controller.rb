class PagesController < ApplicationController
  def dev
  end

  def overview
    @media = Medium.all.order(id: :desc)
  end
end
