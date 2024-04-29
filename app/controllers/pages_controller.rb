# frozen_string_literal: true

# Handels Static pages like '/home'
class PagesController < ApplicationController
  include ActionController::Rendering
  include ActionView::Layouts

  def home
    render 'pages/home', formats: :html
  end
end
