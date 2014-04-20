require 'action_dispatch'
require 'redis'
require './game.rb'

class ChessApp


  def call(env)
    env.update('POST_DATA' => Rack::Utils.parse_nested_query(env['rack.input'].read))
    env['rack.input'].rewind
    Router.new(env).call
  end

end



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

  def call
    handler = controller.module_eval(action)
    handler.new(self).send(method)
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

module Proof
  class ControllerAction
    def initialize(data)
      @data = data
    end
  end
end


module GamesController

  class Index < Proof::ControllerAction
    def get
      [200,{},Game.all.to_json]
    end
  end

  class Update < Proof::ControllerAction
  end

  class Create < Proof::ControllerAction
    def post
      id = Game.create
      if id
        [200,{}, id.to_s]
      else
        [422,{}, "oops!"]
      end
    end
  end

end
