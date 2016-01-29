#!/usr/bin/ruby

log_file = File.open("make.log", "w")

while((line = gets) != nil)
	log_file.puts line
	if((line [ /\bgcc\s+/ ]) && (line [ /\s+-c\s+/ ]) && (line [ /\s+-MM\s+/ ]))
		source = line[ /[\w\.\-\_]+\.cpp\s+/ ]
		puts "\tDEP\t" + source if(source != nil)
	end
	if((line [ /\bgcc\s+/ ]) && (line [ /\s+-c\s+/ ]) && !(line [ /\s+-MM\s+/ ]))
		source = line[ /[\w\.\-\_]+\.cpp\s+/ ]
		puts "\tCC\t" + source if(source != nil)
	end
	if((line [ /\bgcc\s+/ ]) && (line [ /\s+-c\s+/ ]) && (line [ /\s+-MM\s+/ ]))
		source = line[ /[\w\.\-\_]+\.c\s+/ ]
		puts "\tDEP\t" + source if(source != nil)
	end
	if((line [ /\bgcc\s+/ ]) && (line [ /\s+-c\s+/ ]) && !(line [ /\s+-MM\s+/ ]))
		source = line[ /[\w\.\-\_]+\.c\s+/ ]
		puts "\tCC\t" + source if(source != nil)
	end
	if(line [ /\bLibouting\s+/ ])
		target = line.split(" ")[1].split("/")[-1]
		puts "\tLIBOUT\t" + target if(target != nil)
	end
	if(line [ /\bInstalling\s+/ ])
		target = line.split(" ")[1].split("/")[-1]
		puts "\tINSTALL\t" + target if(target != nil)
	end
	if(line [ /[\w\.\-\_]\/tao_idl\s+/ ])
		idl = line[ /[\w\.\-\_]+\.idl\s+/ ]
		puts "\tIDL\t" + idl if(idl != nil)
	end
	if((line [ /\s+\W*warning\W*\s+/ ]) && !(line [ /\-fpermissive/ ]) && !(line [ /\s+newline\s+/ ]))
		puts line
	end
	if(line [ /\s+\W*error\W*\s+/ ])
		puts line
	end
	if(line [ /Ошибка/ ])
		puts "make ERROR\t" + "see log for details (usually make_partial.log, or make.log somewhere in CVS subtree)"
	end
end
