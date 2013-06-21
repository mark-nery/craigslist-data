require 'nokogiri'
require 'open-uri'
require 'cgi'

class CraigsList

  VALID_FIELDS = [:query, :srchType]

  def search(options ={})
    if options[:title_only]
      options.merge!(srchType: "T")
      options.delete(:title_only)
    end
    uri = "http://#{options[:city]}.craigslist.org/search/sss?#{to_query(options)}"
    
    doc = Nokogiri::HTML(open(uri))
    items = []
    doc.css('p.row').each do |link|
      items << {
        data_id: link["data-pid"] ,
        description:  link.css("a").text,
        url: "http://#{options[:city]}.craigslist.org#{link.css("a")[0]["href"]}",
        price: extract_price(link.css("span.price").text)
      }
    end
    items
  end
  
  def us_cities
    doc = Nokogiri::HTML(open("http://www.craigslist.org/about/sites"))
    
    cities = []
    doc.css('a').each do |link|
      if /http:\/\/([a-z]*).craigslist.org/ =~ link["href"]
        puts link["href"]
      end
    end
  end


  private
  
  def extract_price(dollar_string)
    dollar_string[1..-1]
  end
  
  def to_query(hsh)
    hsh.select { |k,v| CraigsList::VALID_FIELDS.include? k }.map {|k, v| "#{k}=#{CGI::escape v}" }.join("&")
  end

end
