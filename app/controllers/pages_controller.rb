# frozen_string_literal: true

# The PagesController is set up to manage a static homepage
# featuring buttons that enable users to test sending private or group messages via HandBot
class PagesController < ApplicationController
  include ActionController::Rendering
  include ActionView::Layouts

  def home
    render 'pages/home', formats: :html
  end
end
