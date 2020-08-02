class User
    include Mongoid::Document
    include Mongoid::FullTextSearch

    field :name, type: String
    field :url, type: String
    field :github_username, type: String
    field :followers, type: String
    field :following, type: String
    field :stars, type: String
    field :last_year_contributions, type: String
    field :profile_image, type: String
    field :organization, type: String
    field :location, type: String
    field :creation_date, type: DateTime, default: DateTime.current

    index({ github_username: 1 }, { unique: true, name: "github_username_index" })

    before_validation :scrapper_user, :on => [:create]
    before_validation :shorten_url, :on => [:create]

    fulltext_search_in :name, :github_username, :location, :organization, :last_year_contributions, :stars


    def self.get_github_user_data(url)
        expanded_url = Services::URLHandler.unshorten(url)
        User.new.scrapper_user(expanded_url).attributes.except("_id", "creation_date", "name", "url")
    end
    
    
    def scrapper_user(url = false)
        scrapper = Services::Scrapper.new(url||=self.url)

        if scrapper.check_user_existence

            get_user_data(scrapper)
            
            return self
        else
            self.errors.add('404', 'Not Found')
            :abort
        end
    end

    def get_user_data(scrapper)
        self.github_username = scrapper.get_nick_name
        self.followers = scrapper.get_followers
        self.following = scrapper.get_following
        self.stars = scrapper.get_stars
        self.last_year_contributions = scrapper.get_last_year_contributions
        self.profile_image = scrapper.get_profile_image
        self.organization = scrapper.get_organizations
        self.location = scrapper.get_location
    end

    def shorten_url
        self.url = Services::URLHandler.shorten(self.url)
    end
end
