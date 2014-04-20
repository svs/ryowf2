require 'action_dispatch'

class Router

  def self.routes
    ActionDispatch::Routing::RouteSet.new.tap do |r|
      r.draw do
        resources :games, :only => [:index, :create, :show, :update]
      end
    end
  end


end

module GamesController
end
