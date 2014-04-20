require 'action_dispatch'

class Router

  def self.routes
    ActionDispatch::Routing::RouteSet.new.tap do |r|
      r.draw do
        resources :games, :only => [:index, :create, :show, :update]
      end
    end
  end

  def initialize(env)
    @env = env
  end

  def params
    ActiveSupport::HashWithIndifferentAccess.new(path_info.except(:action, :controller).merge(post_data))
  end


private

  attr_reader :env

  def controller
    "#{path_info[:controller].camelize}Controller".constantize
  end

  def path_info
    routes.recognize_path(env['PATH_INFO'], {:method => method.upcase})
  end

  def routes
    Router.routes
  end

  def method
    env['REQUEST_METHOD'].downcase
  end

  def action
    path_info[:action].camelize
  end

  def post_data
    env['POST_DATA'] || {}
  end



end

module GamesController

  class Index
  end

  class Update
  end

  class Create
  end

end
