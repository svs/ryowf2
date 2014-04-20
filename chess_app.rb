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

end

module GamesController

  class Index
  end

  class Update
  end

  class Create
  end

end
