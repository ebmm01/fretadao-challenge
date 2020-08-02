require 'shorturl'
require 'embiggen'

module Services
    class URLHandler
        def self.shorten(url)
            ShortURL.shorten(url)
        end

        def self.unshorten(url)
            Embiggen::URI(url).expand.to_s
        end
    end
end