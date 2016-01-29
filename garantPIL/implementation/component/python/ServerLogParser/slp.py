#!/usr/bin/python 
# -*- coding: cp1251 -*-
import sys
import os
import re
import datetime

class Item:
  def __init__ (self):
    self.time = None
    self.type = ''
    self.id   = 0
    self.user = 0


class Track:
  def __init__ (self):
    self.tag       = 'UNKNOWN' 
    self.tag_start = 'UNKNOWN_CREATED'
    self.tag_end   = 'UNKNOWN_ERASED'
    self.list      = []

  def is_meet (self, line):
    return line.find (self.tag_start) != -1 or line.find (self.tag_end) != -1

  def add_event (self, line):
    assert False

  def dump (self):
    file = open (self.tag + '.csv', 'w')

    size = 0
    for item in self.list:
      if item.type == self.tag_start: size += 1 
      else:                           size -= 1 
      file.write (item.time.isoformat (' ') + ', ' + size.__str__ () + '\n')

    file.close

# Tue May 19 2009 14:51:57.351000[1672, 5044] -LM_GARANT: DOCTREE_SERVANT_CREATED [2][102003]
# Tue May 19 2009 14:49:35.680000[1672, 5372] -LM_GARANT: DOCTREE_SERVANT_ERASED [2][102003]
class DocTreeServantTrack (Track):
  def __init__ (self):
    Track.__init__(self) 
    self.tag       = 'DOCTREE' 
    self.tag_start = 'DOCTREE_SERVANT_CREATED'
    self.tag_end   = 'DOCTREE_SERVANT_ERASED'
    self.regex     = re.compile ('(' + self.tag_start + '|' + self.tag_end + ") \[(\d+)\]\[(\d+)\]")

  def add_event (self, time, line):
    event = self.regex.search (line)
    if event == None:
      return

    item = Item ();
    item.time = time
    item.type = event.group (1)
    item.id   = event.group (3)
    item.user = event.group (2)

    self.list.append (item)


#Tue May 19 2009 14:52:04.164000[1672, 5048] -LM_GARANT: DOCTREEVIEW_CREATED [2][102003][153875808]
#Tue May 19 2009 14:49:35.676000[1672, 5048] -LM_GARANT: DOCTREEVIEW_ERASED [2][102003][151529336]
class View (Item):
  def __init__ (self):
    Item.__init__(self)   
    self.tree_id = 0

class DocTreeViewServantTrack (Track):
  def __init__ (self):
    Track.__init__(self)
    self.tag       = 'DOCTREEVIEW'
    self.tag_start = 'DOCTREEVIEW_SERVANT_CREATED'
    self.tag_end   = 'DOCTREEVIEW_SERVANT_ERASED'
    self.regex     = self.compile_regex ()

  def compile_regex (self):
    return re.compile ('(' + self.tag_start + '|' + self.tag_end + ") \[(\d+)\]\[(\d+)\]\[(\d+)\]")

  def add_event (self, time, line):
    event = self.regex.search (line)
    if event == None:
      return

    item = View ();
    item.time    = time
    item.type    = event.group (1)
    item.id      = event.group (4)
    item.tree_id = event.group (3)
    item.user    = event.group (2)

    self.list.append (item)


#Tue May 19 2009 14:52:04.164000[1672, 5048] -LM_GARANT: DOCLIST_SERVANT_CREATED [2][151385016][collection][53604]
#Tue May 19 2009 14:49:35.676000[1672, 5048] -LM_GARANT: DOCLIST_SERVANT_ERASED [2][151385016]
class DocListTree (Item):
  def __init__ (self):
    Item.__init__(self) 
    self.method = ''
    self.memory = 0

class DocListTreeServantTrack (Track):
  def __init__ (self):
    Track.__init__(self)
    self.tag         = 'DOCLIST'
    self.tag_start   = 'DOCLIST_SERVANT_CREATED'
    self.tag_end     = 'DOCLIST_SERVANT_ERASED'
    self.regex_start = re.compile ('(' + self.tag_start + ") \[(\d+)\]\[(\d+)\]\[(\w+)\]\[(\d+)\]")
    self.regex_end   = re.compile ('(' + self.tag_end   + ") \[(\d+)\]\[(\d+)\]")

  def add_event (self, time, line):
    item = DocListTree ();
    item.time = time

    event = self.regex_start.search (line)
    if event == None:
      event = self.regex_end.search (line)
      if event == None:
        return
      item.type    = event.group (1)
      item.user    = event.group (2)
      item.id      = event.group (3)
    else:
      item.type    = event.group (1)
      item.user    = event.group (2)
      item.id      = event.group (3)
      item.method  = event.group (4)
      item.memeory = event.group (5)

    self.list.append (item)

# Tue May 19 2009 12:54:58.813000[4352, 3420] -LM_GARANT: DOCLISTVIEW_CREATED [2][151385016][151392368]
# Tue May 19 2009 12:55:38.966000[4352, 5096] -LM_GARANT: DOCLISTVIEW_ERASED [2][151385016][151392368]
class DocListViewServantTrack (DocTreeViewServantTrack):
  def __init__ (self):
    DocTreeViewServantTrack.__init__(self)
    self.tag       = 'DOCLISTVIEW'
    self.tag_start = 'DOCLISTVIEW_SERVANT_CREATED'
    self.tag_end   = 'DOCLISTVIEW_SERVANT_ERASED'
    self.regex     = self.compile_regex ()


# -------------------------------------------------------------------------------------------------
class Scaner:
  def __init__ (self):
    self.track_list = []
    self.__garant_tag = 'LM_GARANT'
    self.__servant_tag_created = '_SERVANT_CREATED'
    self.__servant_tag_erased  = '_SERVANT_ERASED'

  def add_track (self, track):
    self.track_list.append (track)

  def scan (self, log_file_name):
    file = open (log_file_name)
    try:
      for line in file:
        self.__parse (line)
    finally:
      file.close ()

  def dump (self):
    for track in self.track_list:
      track.dump ()

  def __parse (self, line):
    if (line.find (self.__garant_tag) == -1):
      return

    if line.find (self.__servant_tag_created) == -1 and line.find (self.__servant_tag_erased) == -1:
      return

    for track in self.track_list:
      if track.is_meet (line):
        time = self.__get_time (line)
        track.add_event (time, line)

  def __get_time (self, line):
    return datetime.datetime.strptime(line[0:24], "%a %b %d %Y %H:%M:%S") 

def main ():
  if len (sys.argv) < 2:
    print ("usage: slp.py <garant.log>")
    sys.exit (2)

  scaner = Scaner ()
  scaner.add_track (DocTreeServantTrack ())
  scaner.add_track (DocTreeViewServantTrack ())
  scaner.add_track (DocListTreeServantTrack ())
  scaner.add_track (DocListViewServantTrack ())

  scaner.scan (sys.argv [1])
  scaner.dump ()

if __name__ == '__main__':
  main ()

# vi:set et ts=2 ff=dos:
