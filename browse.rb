
require 'watir-webdriver'

keywords = ['ruby on rails','lims programmer']

b = Watir::Browser.new :chrome
sleep(3)
b.goto 'https://www.linkedin.com/'
b.text_field(:id, "session_key-login").set(ARGV[0])
b.text_field(:id, "session_password-login").set(ARGV[1])
b.button(:value,"Sign In").click

keywords.each do |keyword|
   b.text_field(:id, "main-search-box").set(keyword)
   b.send_keys :enter
   sleep(1)
   b.link(:text, "People").click
   sleep(2)
   # pick 2nd connections
   b.checkbox(:id, "S-N-ffs").set if b.checkbox(:id, "S-N-ffs").exists?
   sleep(3)
   # pick DC
   b.checkbox(:id, 'us:97-G-ffs').set if b.checkbox(:id, 'us:97-G-ffs').exists?
   sleep(3)
   # pick 3rd connections
   b.checkbox(:id, "O-N-ffs").set if b.checkbox(:id, "O-N-ffs").exists?
   sleep(3)
   b.link(:xpath, '//*[@id="results"]/li[0]/div/h3/a').click
  while b.link(:text, "View next search result").exists? do
     b.link(:text, "View next search result").click
     st = rand(20..30)
     sleep(st)
  end
end

b.goto 'https://www.google.com/search?site=&source=hp&q=finished+searching'
