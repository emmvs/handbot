# frozen_string_literal: true

require 'httparty'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'yaml'

# Top-Level Documentation for ApplicationService
class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def call
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end
end
