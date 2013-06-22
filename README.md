# Craigslist::Data

A gem to scrape craiglist data , use at own risk.  

####Warning

This gem does not work if hosted on heroku or ec2 , it appears [craiglist blocks requests coming from them.](http://stackoverflow.com/questions/14328955/http-get-on-craigslist-blocked)

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
    craigslist.search_boulder_for "vegan flip flops"

#### returns

     [{
        data_id: "314159265359",
        decsription: "vegan flip flops made out of tofu",
        url: "http://denver.craigslist.org/42.html,
        price: 5
     }]      

### you can search most valid craigslist cities
#### example
    craigslist.search_dallas_for "a NoBama bumper sticker"

    craigslist.search_lasvegas_for "gold chains and workout jumpsuit"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
