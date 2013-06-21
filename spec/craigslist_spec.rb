require 'craigslist/craigslist'

describe CraigsList do

  describe ".search" do
    it "returns an array with all the items" do
      cl = CraigsList.new
      cl.stub(:open).and_return(File.read(File.dirname(__FILE__) + '/mock_craigslist_data.html'))

      cl.search.length.should == 100
      cl.search[0].keys.should == [:data_id, :description, :url, :price]
    end
  end

  it "has the right keys " do
    cl = CraigsList.new
    cl.stub(:open).and_return(File.read(File.dirname(__FILE__) + '/mock_craigslist_data.html'))

    cl.search[0].keys.should == [:data_id, :description, :url, :price]
  end

  it "addes '+' to white space in queries" do
    cl = CraigsList.new
    cl.stub(:open).and_return(File.read(File.dirname(__FILE__) + '/mock_craigslist_data.html'))

    cl.should_receive(:open).with("http://denver.craigslist.org/search/sss?query=iphone+5")

    cl.search(city: "denver" , query: "iphone 5")
  end

  it "adds title only filter to url" do
    cl = CraigsList.new
    cl.stub(:open).and_return(File.read(File.dirname(__FILE__) + '/mock_craigslist_data.html'))

    cl.should_receive(:open).with("http://denver.craigslist.org/search/sss?query=iphone+5&srchType=T")
    cl.search(city: "denver" , query: "iphone 5" , title_only: true)
  end
  
  it "doesn't filter when title only is false" do
    cl = CraigsList.new
    cl.stub(:open).and_return(File.read(File.dirname(__FILE__) + '/mock_craigslist_data.html'))

    cl.should_receive(:open).with("http://denver.craigslist.org/search/sss?query=iphone+5")
    cl.search(city: "denver" , query: "iphone 5" , title_only: false )
  end


  it "exracts the price" do
    cl = CraigsList.new
    cl.stub(:open).and_return(File.read(File.dirname(__FILE__) + '/mock_craigslist_data.html'))

    cl.search[0][:price].should == "70"
  end
 
  it "builds the correct reference url" do
    cl = CraigsList.new
    cl.stub(:open).and_return(File.read(File.dirname(__FILE__) + '/mock_craigslist_data.html'))

    city = "shanghai"
    cl.search(city: city)[0][:url].should == "http://#{city}.craigslist.org/mob/3849318365.html"
  end

end

