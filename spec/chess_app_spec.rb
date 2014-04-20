require 'rspec'
require_relative '../chess_app.rb'
require 'json'

describe Router do

  describe "the routes" do
    specify { Router.routes.recognize_path('/games').should == {:action=>"index", :controller=>"games"} }
    specify { Router.routes.recognize_path('/games/1').should == {:action=>"show", :controller=>"games", :id => "1"} }
  end

end
