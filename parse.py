import csv, urllib, json
fp = open('filmfare.tsv', 'w')
a = csv.writer(fp, delimiter='\t')


def geturldata(name):
	url = 'https://api.cinemalytics.com/v1/movie/title/?value='+urllib.quote(name)
	token = '&auth_token=AF31CD40ADD140475BD8201CB9DAC8DB'
	furl = url+token
	response = urllib.urlopen(furl)
	data = None
	try:
		data = json.loads(response.read())[0]
		budget = data['Budget']
		genre = data['Genre']
		revenue = data['Revenue']
		print name, budget, genre, revenue
	except Exception, e:
		print name
		pass

from bs4 import BeautifulSoup
# http://www.imdb.com/list/ls009096811/
soup = BeautifulSoup(open("page.html"))
for link in soup.find_all('div', attrs={ "class" : "info"}):
	name = link.b.a.get_text()
	year = link.b.span.get_text().strip("()")
	idrating = link.find("div", class_="rating rating-list")['id']
	imdbid = idrating.split('|')[0]
	rating = idrating.split('|')[2]
	time = 'NA'
	if link.find("div", class_="item_description").span:
		time = link.find("div", class_="item_description").span.get_text().strip("()")
	director = link.find("div", class_="secondary").a.get_text()
	actors = link.findNext("div", class_="secondary").findNext("div", class_="secondary").get_text().split(' ',1)[1]
	towrite = [name, year, rating, time, director, actors]
	a.writerow(towrite)
	

