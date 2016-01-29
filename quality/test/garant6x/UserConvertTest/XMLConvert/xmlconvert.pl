use UTF8simple;
$UTF8ref = new Unicode::UTF8simple;

$settings_3_file = "00000003\\settings.xml";
$settings_main_file = "settings.xml";
$users_file = "users.xml";
$flag_file = "xmlconvert.done";

@result_block_to_pass = ();

die "script has worked already ($flag_file exists)\n" if -e $flag_file;

process_settings_3_file();
process_settings_main_file();
make_flag_file();
process_users_file();
##############################################################################
sub process_settings_3_file{
    print "$settings_3_file\n";
    open (IN, $settings_3_file) || die "can't open $settings_3_file\n";
	binmode IN;

    $into_right_PropertyValues = 0;
    @tag_value_text = ();

    while (<IN>){
        $save_str = $_;

        $into_right_PropertyValues = 1 if /\<Value +configuration\=\"1000\"/;
        $into_right_PropertyValues = 0 if /\<\/PropertyValues( |\>)/;
        next unless $into_right_PropertyValues;

		push (@tag_value_text, $save_str);
		end_of_tag_value_3() if $save_str =~ /\<\/Value\>/;
    }
    close IN;
}

sub end_of_tag_value_3{
	$into_default_tag_to_del = 0;
	$into_default_tag_here = 0;
	@default_block = ();

	foreach $str (@tag_value_text){
	    $_ = $str;

		$into_default_tag_to_del = 1 if /\<default\>/;
		if (/\<\/default\>/){
	        $into_default_tag_to_del = 0;
			next;
		}
		next if $into_default_tag_to_del;

		$str =~ s/\<actual\>/\<default\>/g;
		$str =~ s/\<\/actual\>/\<\/default\>/g;

		$str =~ s/\<Value configuration\=\"1000\"/\<Value configuration\=\"1\"/;
		$str =~ s/\<Value configuration\=\"1001\"/\<Value configuration\=\"2\"/;

		if (/\<Value .* property\=\"(.*)\"/){
			$property = $1;
		    $property = koi82Dos_here($UTF8ref->fromUTF8("koi8-r", $property));
		}
		
	    $_ = $str;

		$into_default_tag_here = 1 if /\<default\>/;
		if (/\<\/default\>/){
	        $into_default_tag_here = 0;
			push(@default_block, $str);
	        end_of_default_block();
			next;
		}
		if ($into_default_tag_here){
			push(@default_block, $str);
		    next;
		}
	    
	    push (@result_block_to_pass, $str);
	}

    @tag_value_text = ();
}

sub end_of_default_block{
	if(
	    ($property eq "Поиск контекста/Строки") ||
	    ($property eq "Внутренняя/Документ/Последний открытый по номеру/Номер документа") ||
	    ($property eq "Внутренняя/Документ/Последний открытый по номеру/История Номеров") ||
	    ($property eq "nsAttributeSearch/Consultations/AT_USER_NAME") ||
	    ($property eq "nsAttributeSearch/Consultations/AT_USER_PHONE/Code") ||
	    ($property eq "nsAttributeSearch/Consultations/AT_USER_PHONE/Number") ||
	    ($property eq "nsAttributeSearch/Consultations/AT_EMAIL")
	){
	    push (@result_block_to_pass, "      \<default\>\<\/default\>\n");
	}elsif($property eq "pi_ShowHelpCounter"){
	    push (@result_block_to_pass, "      \<default\>0\<\/default\>\n");
	}else{
	    push (@result_block_to_pass, @default_block);
	}

	@default_block = ();
}


sub process_settings_main_file{
    print "$settings_main_file\n";
    @root_settings_file = ();

    open (IN2, $settings_main_file) || die "can't open $settings_main_file\n";
	binmode IN2;
	while(<IN2>){
	    push(@root_settings_file, @result_block_to_pass) if /\<\/PropertyValues\>/;
	    push(@root_settings_file, $_);
	}
    close (IN2) || die "can't close $settings_main_file\n";
    
    
    open (OUT, ">$settings_main_file") || die "can't open $settings_main_file\n";
	binmode OUT;

	$into_root_value_tag = 0;
	@value_block = ();

	foreach $str (@root_settings_file){
	    $_ = $str;

		if (/\<Value .* property\=\"(.*)\"/){
			$property = $1;
		    $property = koi82Dos_here($UTF8ref->fromUTF8("koi8-r", $property));
			$into_root_value_tag = 1;
		}
		if (/\<\/Value\>/){
	        $into_root_value_tag = 0;
			push(@value_block, $str);
	        end_of_value_block_root();
			next;
		}
		if ($into_root_value_tag){
			push(@value_block, $str);
		    next;
		}

	 	print OUT $str;
	}

    close (OUT) || die "can't close $settings_main_file\n";
}

sub end_of_value_block_root{
	unless(
	    ($property =~ /Счетчик запусков/) ||
	    ($property =~ /Индекс контекстного примера/) ||
	    ($property =~ /pi_FirstLogin/) ||
	    ($property =~ /SERVER_PROPERTY_SPLASH_RECORD_LIST/) ||
	    ($property =~ /SERVER_PROPERTY_SPLASH_ORDER_VERSION/) ||
	    ($property =~ /SERVER_PROPERTY_SPLASH_SHOWN/) ||
	    ($property =~ /SERVER_PROPERTY_SPLASH_ALREADY_SHOWN/) ||
	    ($property =~ /SERVER_PROPERTY_SPLASH_TIMES_TO_SHOW/) ||
	    ($property =~ /CONSULTATION_USER_EMAIL_PROPERTY/)
	){
	 	print OUT @value_block;
	}

	@value_block = ();
}

sub process_users_file{
    print "$users_file\n";

    open (IN3, $users_file) || die "can't open $users_file\n";
	binmode IN3;
    @users_file_text = <IN3>;
    close IN3;


    open (OUT3, ">$users_file") || die "can't open $users_file\n";
	binmode OUT3;

	$just_missed_str = 0;
	foreach $str (@users_file_text){
	    $_ = $str;

		if ($just_missed_str){
	        $just_missed_str = 0;
		    next if /^[ \t\n\r]*$/;
		}

		if (/\<user .* login\=\"UI\"/){
	        $just_missed_str = 1;
	        next;
		}

	    print OUT3 $str;

	}
    close (OUT3) || die "can't close $users_file\n";
}

sub koi82Dos_here {
  local ( $name ) = @_;
  $name =~ s/ /\-/g;
  $name =~ s/ &/.../g;
  $name =~ tr/┴┬╫╟─┼г╓┌╔╩╦╠═╬╧╨╥╙╘╒╞╚├▐█▌▀┘╪▄└╤стўчфх│Ў·щъыьэюяЁЄєЇїцшу■√¤ ∙°№рёл╗Ъ/абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"" /;
  $name =~ s/!/№/g;
  $name =~ s//№/g;
  return $name;
}

sub make_flag_file{
    open (OUT, ">$flag_file") || die "can't open $flag_file\n";
    close (OUT) || die "can't close $flag_file\n";
}
