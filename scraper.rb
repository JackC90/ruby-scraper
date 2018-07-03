require 'nokogiri'
require 'mechanize'
require 'byebug'

agent = Mechanize.new

username = ARGV[0]
password = ARGV[1]

login_url = 'http://tripovo-admin-mt.goquo.vn/account/login'
url = 'http://tripovo-admin-mt.goquo.vn/admin/activities/11111111-1111-1111-1111-111111111111/4273955d-25bb-404c-ba00-6dca66a8bf76'
login = agent.get(url)
login_form = login.forms.first
username_field = login_form.field_with(:name => "UsernameOrEmail")
username_field.value = username
password_field = login_form.field_with(:name => "Password")
password_field.value = password
remember_me_field = login_form.field_with(:name => "RememberMe")
remember_me_field.value = true
page = login_form.submit
byebug

while page.code[/30[12]/]
  byebug
  # agent.redirect_ok = true
  page = agent.get(url)
end

# Below will print page showing information confirming that you have logged in.
pp page