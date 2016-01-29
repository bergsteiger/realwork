#! /usr/bin/perl 

#########################################################################################
$confl_space = "EXTDOC";
#$confl_space = "TSTHTML";
#$confl_space = "TST1";

$confl_parent_page = "STL_base";
#$confl_parent_page = "BerkeleyDB_root_page";
#$confl_parent_page = "GarDoc_root_page";
#$confl_parent_page = "CodePageTest";

$page_prefix = "STL";
#$page_prefix = "BDB";
#$page_prefix = "GarDoc";
#$page_prefix = "CP";

$dir_path = "W:/WiKi/STL";
#$dir_path = "W:/WiKi/BerkeleyDB/documentation";
#$dir_path = "W:/WiKi/garant";
#$dir_path = "W:/WiKi/test";
#$dir_path = "W:/WiKi/BerkeleyDB/documentation";

$image_path = "W:/WiKi/confluence-2.3-dr2-std/confluence/ExtDocs/images/STL";
#$image_path = "W:/WiKi/confluence-2.3-dr2-std/confluence/ExtDocs/images/BerkeleyDB";
#$image_path = "W:/WiKi/confluence-2.3-dr2-std/confluence/GarDoc/image";
#$image_path = "C:/wiki/jira-3.6.5-std/atlassian-jira/ExtDocs/images/BerkeleyDB";

$image_http_path = "/ExtDocs/images/STL";
#$image_http_path = "/ExtDocs/images/BerkeleyDB";
#$image_http_path = "/GarDoc/image";
#########################################################################################

use File::Copy;
use File::Path;
use File::Spec;

$ipatern = qr/(IMG)(\s+)(SRC)(\s*)(=)(\s*)(\")/i;
$fpatern = qr/(href)(\s*)(=)(\s*)(\")/i;

$content_of_dir_page = "This page instead of a directory on the disk with the same name.";

sub add2confluence {
	if (@_ [0] ne "") {
		push @titles, @_ [0];
	}
	if (@_ [1] ne "") {
		push @files, @_ [1];
	}
	if (@_ [1] ne "") {
		push @parentes, @_ [2];
	}

	if (($#titles == 20) || (@_[0] eq "")) {
		my ($args) = "";
		for (my ($i) = 0; $i < $#titles + 1; ++$i) {
			$args = $args." --file ".$files[$i]." --title ".$titles[$i]." --parent ".$parentes[$i];
		}

		system ("confluence.bat --space $confl_space --action storePage".$args);

		my ($len) = $#titles + 1;
		for (my ($i) = 0; $i < $len; ++$i) {
			pop (@titles);
			pop (@parentes);
        		unlink (pop (@files));
		}
	}
}

sub straighten_path {
	my ($link_dir) = "";
	my ($link_file) = $_[1];
	
	my ($diroffset) = rindex $_[1], "/";
	if ($diroffset != -1) {
		$link_dir = substr $_[1], 0, $diroffset;
		$link_file = substr $_[1], $diroffset + 1;
	}

	return File::Spec->catfile ($_[0], $link_dir, $link_file);
}

sub image_links {
	my ($cur_dir) = File::Spec->catfile ($_[0]);
	my ($offset) = index $', "\"", 0;

	my ($ilink) = substr $', 0, $offset;

	my ($ipath) = straighten_path $cur_dir, $ilink;

	$ipath = substr $ipath, length $dir_path;
	
	$_[1] = $`.$&.$image_http_path.$ipath.substr $', $offset;

	($volume, $directories, $file) = File::Spec->splitpath ($image_path.$ipath);

	mkpath ($volume.$directories);

	copy ($cur_dir."/".$ilink, $image_path."/".$ipath) or print "Copy $cur_dir/$ilink to $image_path/$ipath ERROR.\n";
}

sub file_links {
	my ($cur_dir) = File::Spec->catfile ($_[0]);
	my ($offset) = index $', "\"", 0;

	my ($flink) = substr $', 0, $offset;

	if (substr ($flink, 0, 1) eq '#') {
		return;
	}
	if (index ($flink, "http://")) {
		my ($fpath) = straighten_path $cur_dir, $flink;

		my ($localpath) = substr $fpath, length ($dir_path);

               	$localpath =~ tr/\//_/;
        	$localpath =~ tr/\\/_/;
		$_[1] = $`.$&.$page_prefix.$localpath.substr $', $offset;
		if (index ($flink, "\.pdf") != -1) {
			my ($page_title) = substr $fpath, length ($dir_path) + 1;
			$page_title =~ tr/\//_/;
			$page_title =~ tr/\\/_/;
			$page_title = $page_prefix."_".$page_title;
			system ("confluence.bat --space $confl_space --parent $_[2] --action addAttachment --title $page_title --file $fpath --content \"The page has pdf file in attach.\"");
		}
	}
}

sub create_page_title {
	my ($file_path) = substr $_[0], length ($dir_path);
	$file_path =~ tr/\//_/;
	$file_path =~ tr/\\/_/;
	$file_path = $page_prefix.$file_path."_".$_[1];
	return $file_path;	
}

sub read_dir {
	local ($fdir, $cur_dir, $parent_page) = @_;

	my ($file) = "";
        while ($file = readdir ($fdir)) {
        	if (-d ($file)) {
        		next;
        	}

        	my ($file_path) = $cur_dir."/".$file;

        	if ($file =~ m/(\.png)|(\.gif)|(\.jpg)|(\.bmp)|(\.avi)/i) {
        		next;
        	}

		local *F;
        	if (!open (F, $file_path)) {
			local *CHILD_DIR;
			if (opendir (CHILD_DIR, $file_path)) {
				my ($new_parent_page) = $parent_page."_".$file;
				system ("confluence.bat --space $confl_space --parent $parent_page --action storePage --title $new_parent_page --content $content_of_dir_page");
				read_dir (*CHILD_DIR, $file_path, $new_parent_page);
			} else {
        			print "ERROR! '$file_path' is not a directory and can not be opened.\n";
			}
        		next;
        	}

		my ($is_html) = ($file =~ m/\.htm/i);
		if ($is_html == 0) {
			next;
		}

		local *CF;
        	my ($confl_file_path) = $file_path."\.confl";
        	if (!open (CF, "> ".$confl_file_path)) {
        		print "ERROR! Can not open file to write \'$confl_file_path\'\n";
        		close (F);
        		next;
        	}

        	print CF "{html:output=wiki|noPanel=true}\n <!-- ".time." -->\n";


		my ($line) = "";
        	while ($line = <F>) {
			while ($res = $line =~ m/$ipatern/ig) {
				my ($cur_pos) = pos ($line);
				image_links $cur_dir, $line;
				pos ($line) = $cur_pos;
			}
			while ($res = $line =~ m/$fpatern/ig) {
				my ($cur_pos) = pos ($line);
				file_links $cur_dir, $line, $parent_page;
				pos ($line) = $cur_pos;
			}
	        	print CF $line;
        	}
        	print CF "\n{html}";
        	close (F);
        	close (CF);

		my ($page_title) = create_page_title $cur_dir, $file;

		add2confluence $page_title, $confl_file_path, $parent_page;
        	
        } # while

        closedir FDIR;
}

sub main {
	local *ROOT_FDIR;
	if (opendir (ROOT_FDIR, $dir_path)) {
		read_dir (*ROOT_FDIR, $dir_path, $confl_parent_page);
	} else {
		print "Directory \'$dir_path\' can not be opened.\n";
	}
	add2confluence;
}

main;
