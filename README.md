# Craigslist::Data

A gem to scrape craiglist data , use at own risk.  

####Warning

This gem does not work if hosted on heroku or ec2 , it appears craiglist blocks requests coming from them.
[http://stackoverflow.com/questions/14328955/http-get-on-craigslist-blocked]

## Installation

Add this line to your application's Gemfile:

    gem 'craigslist-data'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install craigslist-data

## Usage

### search example
    
    craigslist = CraigsList.new
    craigslist.search(city: "denver" , query: "pics of your mom" , titles_only: true)

#### returns

     [{
        data_id: "314159265359",
        decsription: "pics of your mom at country buffet",
        url: "http://denver.craigslist.org/42.html,
        price: 5
     }]      

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
