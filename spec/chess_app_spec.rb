require 'rspec'
require_relative '../chess_app.rb'
require 'json'

describe Router do

  describe "the routes" do
    specify { Router.routes.recognize_path('/games').should == {:action=>"index", :controller=>"games"} }
    specify { Router.routes.recognize_path('/games/1').should == {:action=>"show", :controller=>"games", :id => "1"} }
  end

  context "given a Rack env" do
    let(:index_env) { Rack::MockRequest.env_for('/games', {'REQUEST_METHOD' => 'get'}) }

    specify { Router.new(index_env).should route_to(GamesController::Index) }
    specify { Router.new(Rack::MockRequest.env_for('/games', {'REQUEST_METHOD' => 'post'})).should route_to(GamesController::Create) }
    specify { Router.new(Rack::MockRequest.env_for('/games/2/', {'REQUEST_METHOD' => 'PUT'})).should route_to(GamesController::Update).with("id" => "2") }
  end


end
