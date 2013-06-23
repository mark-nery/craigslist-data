require 'nokogiri'
require 'open-uri'
require 'cgi'
require_relative 'cities'

class CraigsList
  include Cities
  
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
        cities << link["href"]
      end
    end
    cities
  end

  #search_CITYNAME_for
  def method_missing(method,*args)
    super unless Cities::CITIES.include? city ||= extract_city(method)
    
    params = { query: args.first , city: city}
    params.merge!(title_only: true) if /titles/ =~ method
      
    search(params)
  end

  private

  
  def extract_city(method_name)
    
    if /titles/ =~ method_name
      method_name.to_s.gsub("search_titles_in_","").gsub("_for","")
    else
      method_name.to_s.gsub("search_","").gsub("_for","")
    end
  end
  
  def extract_price(dollar_string)
    dollar_string[1..-1]
  end
  
  def to_query(hsh)
    hsh.select { |k,v| CraigsList::VALID_FIELDS.include? k }.map {|k, v| "#{k}=#{CGI::escape v}" }.join("&")
  end

end
