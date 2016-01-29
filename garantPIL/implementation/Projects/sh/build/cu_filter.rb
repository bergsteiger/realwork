#!/usr/bin/ruby

regsub = ARGV[0]
case regsub
when 'U'
	regex = /\bU\s\S+\b/
when 'P'
	regex = /\bP\s\S+\b/
when 'M'
	regex = /\bM\s\S+\b/
when 'C'
	regex = /\bC\s\S+\b/
when 'L'
	regex = /\bLocally\smodified\s\S+/
else
	regex = /\b\w{1,1}\s\S+\b/
end

while((line = STDIN.gets) != nil)
	found = line [ regex ]
	if(found)
		STDOUT.puts found	
	end
end
