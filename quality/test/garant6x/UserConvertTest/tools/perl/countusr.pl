if ($ARGV[0]){
	$file_name = $ARGV[0];
}else{
	$file_name = "users.xml";
}

copy1($file_name);
print "$num_of_users\n";
##################################################################
sub copy1{
	local ($file) = @_;
	print "$file\n";
	open (IN, $file) || die "can't open $file\n";

	$in_user = 0;

	$num_of_users = 0;

	while(<IN>){
		if (/\<user +login\=\"([^\"]+)\"/){
			$in_user = 1;
		}elsif(/\<\/user\>/){
			end_of_user();
			$in_user = 0;
		}

	}

	close IN;
}

sub end_of_user{
	$num_of_users++;
}
