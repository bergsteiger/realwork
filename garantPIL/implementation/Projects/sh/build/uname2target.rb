#!/usr/bin/ruby

def system_stdout(s, stderr = false)
	tmp_fname = '/tmp/' + ENV['USER'] + '_ruby_system_stdout_123456.tmp'
	redir = stderr ? ' 2>&1 ' : ''
	system(s + ' > ' + tmp_fname + redir)
	f = File.new(tmp_fname)
	f.readlines.to_s
end

def uname
	system_stdout('uname').downcase
end

def gcc_arch
	gcc_v = system_stdout('gcc -v', true)
	ix86 = gcc_v[ /i\d{1,1}86/ ]
	if(ix86)
		return 'i686'
	end
	ia64 = gcc_v[ /x86_64/ ]
	if(ia64)
		return ia64
	end
	''
end

def target
	un = uname
	ar = gcc_arch
	return '' if(ar == '')
	if(un [ /linux/ ])
		return ar + '_pc_' + 'linux' + '_gnu_gcc'
	elsif(un [ /freebsd/ ])
		return ar + '_pc_' + 'freebsd' + '_gcc'
	else
		return ''
	end
end


puts target

