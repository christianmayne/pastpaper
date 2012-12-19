require 'open-uri'

xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.url do
    #xml.loc "http://www.pastonpaper.com"
    xml.loc @url
    xml.priority 1.0
  end

  @documents.each do |document|
    xml.url do
      xml.loc document_url(document)
      xml.priority 0.9
    end
  end

  @surnames.each do |surname|
    sn=surname.last_name.force_encoding('ASCII-8BIT')
    #sn=surname.last_name
    xml.url do
      xml.loc @url+'/surnames/'+URI::encode(sn)
      #xml.loc @url+'/surnames/'+sn
      xml.priority 0.8
    end
  end


  xml.url do
    xml.loc @url+'/user/registration'
    xml.priority 0.3
  end  
  xml.url do
    xml.loc @url+'/help'
    xml.priority 0.4
  end  
  xml.url do
    xml.loc @url+'/about'
    xml.priority 0.5
  end  

  xml.url do
    xml.loc @url+'/terms'
    xml.priority 0.2
  end  
  xml.url do
    xml.loc @url+'/privacy'
    xml.priority 0.2
  end  

end
