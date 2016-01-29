$file_name = "users.xml";
$result_file = $file_name . ".new";
$result_file_bad = $file_name . ".bad";
$err_file = "dirsleft.err";

open_all_dirs();
copy1($file_name);
rest_of_dirs();
##################################################################
sub copy1{
	local ($file) = @_;

	print "$file\n";
	print ">$result_file\n";
	print ">$result_file_bad\n";

	open (IN, $file) || die "can't open $file\n";
	open (OUT, ">$result_file") || die "can't open $result_file\n";
	open (BAD, ">$result_file_bad") || die "can't open $result_file_bad\n";

	@user = ();
	$login = "";
	$in_user = 0;

	while(<IN>){
		if (/\<user +login\=\"([^\"]+)\"/){
			$login = $1 ;
			$in_user = 1;
			push(@user, $_);
		}elsif(/\<\/user\>/){
			push(@user, $_);
			end_of_user();
			$in_user = 0;
		}else{
			if ($in_user){
				push(@user, $_);
			}else{
				print OUT unless /^[ \t]*$/;
				print BAD unless /^[ \t]*$/;
			}
		}

	}

	close (BAD) || die "can't close $result_file_bad\n";
	close (OUT) || die "can't close $result_file\n";
	close IN;
}

sub end_of_user{
	if ($dirs{LoCase($login)}){
		print OUT @user;
		print OUT "\n";
		delete $dirs{LoCase($login)};
	}else{
		print BAD @user;
		print BAD "\n";
	}

	@user = ();
}


sub LoCase {
  local ( $name ) = @_;
  $name =~ tr/€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ/ ¡¢£¤¥¦§¨©ª«¬­®¯àáâãäåæçèéêëìíîï/;
  return lc ( $name );
}

sub open_all_dirs{
  print "reading dir\n";
  local $d;
  opendir( DIR,  ".") || die "can't open .\n";
  @dirs = readdir( DIR );
  foreach $d (@dirs){
	$dirs{LoCase($d)} = 1 if -d $d;
	#print "$d\n" if -d $d;
  }
}

sub rest_of_dirs{
	print ">$err_file\n";
	open(ERR, ">$err_file") || die "can't open $err_file\n";

	foreach $d (sort keys %dirs){
		print ERR "$d\n";
	}

	close(ERR) || die "can't close $err_file\n";
}