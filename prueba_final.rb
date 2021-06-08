require "uri"
require "net/http"
require "json"

def request(url, api_key)
url = URI(url+ "&api_key="+api_key)
https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true


request = Net::HTTP::Get.new(url)
response = https.request(request)
JSON.parse response.read_body
end
body = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10", "o3Jplhz9nOP57Scrh7ytPNZxoEli1eCB3LceHnxJ")


def buid_web_page(data)
    imagen = data['photos'].map{|x| x['img_src']}
    doc_html = "<html>\n<head>\n</head>\n<body>\n\t<ul>\n"
        imagen.each do |photo|
        doc_html += "\t\t<li>\n\t\t\t<img src='#{photo}'>\n\t\t</li>\n"
        end
        doc_html += "\t</ul>\n</body>\n</html>"
    
        File.write('photos.html', doc_html)
    end
    
    buid_web_page(body)


