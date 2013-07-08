'''
Get wallpapers from National Geographic photo of the day and save them to a given directory
'''

import urllib
from bs4 import BeautifulSoup
import re
import os

directory = '/home/san/Pictures/NatGeo/'
base_url = 'http://photography.nationalgeographic.com/photography/photo-of-the-day/'
category = 'nature-weather/'

def find_filename(string):
  '''Find the jpg name in a url'''
  name = re.search('/([^/]*\.jpg)',string).group(1)
  return name

def get_wallpapers(directory):
  print 'Getting urls...'
  # Read the nature-weather photo of the day site
  site = urllib.urlopen(base_url + category)
  page = site.read()
  # Load it into BeautifulSoup
  soup = BeautifulSoup(page)
  # Get all the links
  links = soup.find_all('a')
  # Compile a regex pattern
  pattern = re.compile('href="/photography/photo-of-the-day/(.*)"')
  # Find every link that comes after /photography/photo-of-the-day/, these are
  # all the photographs
  matches = []
  for link in links:
    if 'href="/photography/photo-of-the-day' in str(link):
      result = pattern.search(str(link))
      if not base_url+result.group(1) in matches:
        matches.append(base_url+result.group(1))
  # For each match, check if there is a download button
  for match in matches:
    site = urllib.urlopen(match)
    page = site.read()
    soup = BeautifulSoup(page)
    links = soup.find_all('a')
    pattern = re.compile('a href="(.*)"')
    for link in links:
      if 'Download Wallpaper' in str(link):
        # If there is a download button, download the image
        result = pattern.search(str(link))
        url = result.group(1)
        filename = find_filename(url)
        if not os.path.exists(directory+filename):
          print 'Downloading ' + url
          urllib.urlretrieve(url, directory+filename)

if __name__ == '__main__':
  get_wallpapers(directory)
