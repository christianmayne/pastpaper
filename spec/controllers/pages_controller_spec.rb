require 'spec_helper'

describe PagesController do
    render_views

    describe "GET '/'" do
        it "should have the right title" do
            get '/'
            response.should have_selector("title",
                            :content => "The Past on Paper | Home")
        end
    end    

    describe "GET 'about'" do
        it "should be successful" do
            get 'about'
            response.should be_success
        end

        it "should have the right title" do
            get 'about'
            response.should have_selector("title",
                            :content => "The Past on Paper | About")
        end
    end   

    describe "GET 'contact'" do
        it "should be successful" do
            get 'contact'
            response.should be_success
        end

        it "should have the right title" do
            get 'about'
            response.should have_selector("title",
                            :content => "The Past on Paper | About")
        end
    end    

    describe "GET 'privacy'" do
        it "should be successful" do
            get 'privacy'
            response.should be_success
        end

        it "should have the right title" do
            get 'privacy'
            response.should have_selector("title",
                            :content => "The Past on Paper | Privacy Policy")
        end
    end    

    describe "GET 'terms'" do
        it "should be successful" do
            get 'terms'
            response.should be_success
        end
 
         it "should have the right title" do
            get 'terms'
            response.should have_selector("title",
                            :content => "The Past on Paper | Terms & Conditions")
        end
    end    

end
