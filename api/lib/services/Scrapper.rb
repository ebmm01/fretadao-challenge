require "nokogiri"
require 'httparty'

module Services
    
    class Scrapper
    
        attr_accessor :parse_page
    
        def initialize(url)
            @user_name = url.split("/")[-1]
            doc = HTTParty.get(url)
            @parse_page = Nokogiri::HTML(doc)
        end
    
        def check_user_existence
            if parse_page.css("title").text.downcase.include? "page not found"
                return false
                
            elsif !parse_page.at_css(".user-profile-bio.js-user-profile-bio")
                return false
            else
                return true
            end
        end
    
        def get_followers
            profile_info_number_data("followers")
        end 
    
        def get_following
            profile_info_number_data("following")
        end
    
        def get_stars
            profile_info_number_data("stars")
        end
        
        def get_user_name
            names("name")
        end
    
        def get_nick_name
            names("nickname")
        end
    
        def get_last_year_contributions
            parse_page.css(".js-yearly-contributions").css("h2").text.split(" ")[0]
        end
    
        def get_location
            profile_info.css(".vcard-detail[itemprop=homeLocation]").css("span").text
        end
    
        def get_organizations
            profile_info.css("[data-hovercard-type=organization]").map { |value| value['href'].split("/")[-1] }.join(", ")
        end
    
        def get_profile_image
            profile_info.css(".avatar.avatar-user").attribute('src').value
        end
    
        private 
            def profile_info
                parse_page.css("[itemtype='http://schema.org/Person']")
            end 
    
            def profile_info_number_data(data)
                profile_info.css("a[href='/#{@user_name}?tab=#{data}']").css("span").text
            end
    
            def names(type)
                parse_page.css(".vcard-names").css(".p-#{type}").text
            end

    end    
end
