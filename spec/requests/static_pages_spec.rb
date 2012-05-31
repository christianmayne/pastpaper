require 'spec_helper'

describe "StaticPages" do

  describe "GET /about" do
    it "should exist" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get '/about'
      response.status.should be(200)
    end
    
    it "should have the right title" do
      visit '/about'
      page.should have_selector('title', :text=> "The Past on Paper | About")
    end
    
  end

  describe "GET /terms" do
    it "should exist" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get '/terms'
      response.status.should be(200)
    end
  end

  describe "GET /privacy" do
    it "should exist" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get '/privacy'
      response.status.should be(200)
    end
  end
  
  describe "GET /contact" do
    it "should exist" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get '/contact'
      response.status.should be(200)
    end
  end

   
end
