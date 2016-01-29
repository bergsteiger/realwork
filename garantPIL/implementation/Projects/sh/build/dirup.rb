#!/usr/bin/ruby

cur_dir = Dir.pwd
Dir.chdir("../..")
up_dir = Dir.pwd
Dir.chdir(cur_dir)

cur_dir.gsub!(up_dir + "/", "")

print "../../", cur_dir, "/", "\n"

