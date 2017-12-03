# frozen_string_literal: true

# The Superclass of all Controllers in Rails
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  #  before_action :print_session_id
  #  def print_session_id
  #    puts session.id
  #  end
end
