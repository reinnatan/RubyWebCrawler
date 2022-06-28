require 'nokogiri'
require 'open-uri'
require 'json'
#https://www.vocabulary.com/lists/52473 ==> sample url for retrived
#//*[@id="entry468"]/a
#//*[@id="entry468"]/a/text()
#//*[contains(@class, 'entry learnable')]

#//*[@id="entry0"]
#/html/body/div[1]/div[2]/div/div/div[2]/section[2]/ol/li[469]/a/text()
listWords = []
counter = 0
doc = Nokogiri::HTML(URI.open('https://www.vocabulary.com/lists/52473'))
doc.xpath("//*[contains(@class, 'entry learnable')]").each do |link|
  descXPath = "//*[@id=\"entry"+counter.to_s+"\"]/a/text()"
  detailXpath = "//*[@id=\"entry"+counter.to_s+"\"]/div[1]/text()"

  desc = link.element_children.xpath(descXPath)
  detail = link.element_children.xpath(detailXpath)
  word = {"description"=>desc.text.delete(' '), "detail"=>detail.text}

  listWords.append(word)
  counter +=1
end

begin
  file = File.open(Dir.pwd+"/output.json", "w")
  file.write(JSON.generate(listWords))
  file.close
rescue IOError => e
ensure
  file.close unless file.nil?
end

#File.open('output.json', 'w'){|file|file.write(listWords.to_json)}
