require 'test_helper'

class UserTest < ActiveSupport::TestCase

    test "Must fail to create user" do
        url = "https://github.com/ebmm02"
        user = User.new(name: "ELias", url: url).save

        assert_not user
    end

    test "Must correct scrap user" do
        url = "https://github.com/ebmm01"
        user = User.new.scrapper_user(url)

        scrapper_data = Services::Scrapper.new("https://github.com/ebmm01")

        assert_equal user.github_name, scrapper_data.get_user_name
        assert_equal user.github_username, scrapper_data.get_nick_name
        assert_equal user.followers, scrapper_data.get_followers
        assert_equal user.following, scrapper_data.get_following
        assert_equal user.stars, scrapper_data.get_stars
        assert_equal user.last_year_contributions, scrapper_data.get_last_year_contributions
        assert_equal user.profile_image, scrapper_data.get_profile_image
    end

    test "Must failt to scrap user data" do

        url = "https://github.com/ebmm02"
        user = User.new.scrapper_user(url)

        assert_equal user, :abort
    end

    test "Must shorten user URL" do
        url = "https://github.com/ebmm01"
        user = User.new(name: "ELias", url: url)

        user.shorten_url

        assert_equal user.url, Services::URLHandler.shorten(url)
    end

    test "Must obtain github user data from static method" do 
        url = "https://github.com/ebmm01"
        shorten_url = Services::URLHandler.shorten(url)
        
        github_data = User.get_github_user_data(shorten_url)

        scrapper_data = Services::Scrapper.new(url)


        assert_equal github_data['github_name'], scrapper_data.get_user_name
        assert_equal github_data['github_username'], scrapper_data.get_nick_name
        assert_equal github_data['followers'], scrapper_data.get_followers
        assert_equal github_data['following'], scrapper_data.get_following
        assert_equal github_data['stars'], scrapper_data.get_stars
        assert_equal github_data['last_year_contributions'], scrapper_data.get_last_year_contributions
        assert_equal github_data['profile_image'], scrapper_data.get_profile_image
    end
end
