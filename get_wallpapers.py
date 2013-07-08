'''
Get wallpapers from given subreddit and save them to a given directory
'''

import praw
import urllib
import os
import Image
import ImageFile

directory = '/home/san/Pictures/nature_wallpapers/'
subreddit = 'earthporn'

def url_converter(url):
  """
  Converts imgur urls from 'http://imgur.com/xxxxxxx' to 
  'http://i.imgur.com/xxxxxxx.jpg'
  """
  if not '.jpg' in url:
    number = url[-7:]
    url = 'http://i.imgur.com/' + number + '.jpg'
  return url

def get_image_size(url):
  """Get the size of an image"""
  file = urllib.urlopen(url)
  size = file.headers.get("content-length")
  if size: size = int(size)
  p = ImageFile.Parser()
  while 1:
    data = file.read(1024)
    if not data:
      break
    p.feed(data)
    if p.image:
      return p.image.size
      break
  file.close()
  return (0,0)

def high_resolution_image(url):
  """Find out if the dimensions of the image are bigger than 1920x1080"""
  img_size = get_image_size(url)
  return all([img_size[i]>(1920,1080)[i] for i in range(2)])

def get_wallpapers(subreddit, directory):
  """Get latest wallpapers from subreddit and save them to directory"""
  # Get urls via reddit API
  r = praw.Reddit(user_agent="Wallpaper downloading bot for natureporn")
  submissions = r.get_subreddit(subreddit).get_hot(limit=20)
  urls = [x.url for x in submissions]
  # Filter out everything not from imgur
  urls = [url_converter(x) for x in urls if 'imgur' in x]
  # Download all the images
  for url in urls:
    # Check if it is a high-res image
    if high_resolution_image(url):
      img_path = directory+url[-11:]
      # Add the image if it is not yet present
      if not os.path.exists(img_path):
        print "Downloading " + url
        urllib.urlretrieve(url,img_path)

if __name__ == '__main__':
  get_wallpapers(subreddit, directory)
