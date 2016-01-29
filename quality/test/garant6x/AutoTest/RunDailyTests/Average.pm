package Average;

use Getopt::Std;
use strict; 

sub tag_compare {
	my ($s) = @_;

	$s =~ s/[^\_\d]//g;
	$s =~ s/^\_*//;
	my @arr = split /\_/, $s;		 
	my $res = 0;
	for (my $i = $#arr; $i >=0; $i--) {
		
			if ($i != $#arr) {
				$res += $arr[$i]*1000*100**($#arr-$i);
			} else {
				$res +=  $arr[$i];
			}
	}
	return $res;
}
	
# ���������� ������ �� ��� 
sub load_config 
{     
    my $fconfig = shift; 
    open(FH, "<$fconfig") || die "Can't open file $fconfig"; 
        flock(FH,2); 
        my @config = <FH>; 
    close(FH); 
 
    my $cfg_hash = {}; 
 
    my ($section, $tmpl_section); 
    my $tmpl_flag = 0; 
    foreach my $item (@config) 
    { 
           if ($item =~ /^TMPL\>\>/) # ��������� ��������� ������� 
           { 
                    $tmpl_flag = 0; 
                    next; 
           } 
           if ($tmpl_flag == 1) # ��������� ������ � �������� ���� ��� ������ 
           { 
                   $cfg_hash->{$section}->{$tmpl_section} .= $item; 
                   next; 
           } 
           next if $item =~ /^[\n|#]/; 
           $item =~ s/\n+//g; 
           if ($item =~ /^\[(.*)\]$/) 
           { 
                  $cfg_hash->{$1} = {}; 
                  $section = $1; 
           } 
           elsif ($item =~ /([^\=]+)\=\<\<TMPL/) # ��������� ������ ������� 
           { 
                  $tmpl_section = $1; 
                  $cfg_hash->{$section}->{$tmpl_section} = ""; 
                  $tmpl_flag = 1; 
           } 
           else 
           { 
                 my ($key,$value) = $item =~ /([^\=]+)\=([^\=]+)/; 
                 $cfg_hash->{$section}->{$key} = $value; 
           } 
    } 
    return $cfg_hash; 
} 

sub load_csv_file 
{
	my $file = shift;
	open(FH, "<$file") || die "Can't open file $file"; 
        flock(FH,2); 
        my @file_data = <FH>; 
    close(FH); 
    
    my %data_hash = (); 
    my $version;
     my $tmpl_flag = 0; 
     my $start_tag = 0;
     my $i = 0;
     foreach my $item (@file_data) 
    { 
           if ($item =~  /\*+Start/) #������� ���� � ������� 
           { 
		           	$tmpl_flag = 0;
		           	$start_tag = 1;
#       	           	$i = 0;
                    next; 
           }
                 
           if ($item =~  /(T_.*)/ && $start_tag == 1) #�������� ��� 
           { 
           			if (exists ($data_hash{$1})) {						
           			} else {
	           			#$data_hash{$1} = qw//;
			           	$version = $1;
			           	$tmpl_flag = 1;
			           	$i = 0;
           			}
                    next; 
           }
            if ($item =~  /\*+End/) #���������� ���� � ������� 
           { 
           			$tmpl_flag = 0;
           			$start_tag = 0;
           }
           
           if ($item =~  /([0-9]+)/ && $tmpl_flag == 1) # ���������� ������� � ������� � �������
           { 
           			if (exists ($data_hash{$version})) {						
           			} else {
	           			#$data_hash{$version} = qw//;
			           	$data_hash{$version}[$i++] = $item; 
           			}           			          			
           }            
    } 
    return %data_hash;
}

sub print_test_data {
	my %data = @_;
	my $key;
	my $value;
	
	my %average = ();
	
	my @list_key = sort {tag_compare ($a) <=> tag_compare ($b)} keys %data;
	foreach $key (@list_key) {
		my $idx = $#{$data{$key}};
		$average{$key} = qw//;
		print "$key\n";
		my $count;
		for (my $i = 0; $i <= $idx; $i++) {		
			print $data{$key}[$i];		
		}		
	}
}
sub calculate_average {
	my %data = @_;
	my $key;
	my $value;
	
	my %average = ();
	
	my @list_key = sort {tag_compare ($a) <=> tag_compare ($b)} keys %data;
	foreach $key (@list_key) {
		my $idx = $#{$data{$key}};
		$average{$key} = qw//;
		my $count;
		for (my $i = 0; $i <= $idx; $i++) {		
			my @data_array = split /;/, $data{$key}[$i];		
			$count =  $#data_array + 1;
			
			for (my $j = 0; $j < $count; $j++) {		
					$average{$key}[$j] += $data_array[$j]/($idx+1);
			}
		}
		
	}

	return %average;
}

sub add_line_to_file {
	my $file_name = shift;
	my $text = shift;
	open (FH, ">>$file_name") || die "Can't open file $file_name";
	print FH $text;	
	close (FH);
}

sub average_for_hole_file {
	my $file_in = shift;
	my $file_out = shift;
	my %cfg =  load_csv_file ($file_in);
	my %average = calculate_average (%cfg);
	my @list_key = sort {tag_compare ($a) <=> tag_compare ($b)} keys %average;
	
	my $key;
	foreach $key (@list_key) {
		my @result_array = @{$average{$key}};
		@result_array = @result_array[0..$#result_array-1]; #������� ��������� �������, �.� ��� ��-�� ��������� ����� � ������� ����� 0
		my $result_line = join (';', @result_array);
		#�������� ������ ����� �� �������, ����� Exel ������
		$result_line =~ s/\./,/g;
		my $text =  "\nThe average result for version " . $key . " is:\n" . $result_line . "\n";
		
		add_line_to_file ($file_out, $text);
	}
}

sub get_last_result {
	my $file = shift;
	open(FH, "<$file") || die "Can't open file $file"; 
        flock(FH,2); 
        my @file_data = <FH>; 
    close(FH);
    my %data_hash = ();
    my $tmpl_flag = 0; 
    my $start_tag = 0;
    my $last_tag;
    my @result;
    foreach my $item (@file_data) { 
    	if ($item =~  /\*+Start/) { #������� ���� � ������� 
			$tmpl_flag = 0;
	    	$start_tag = 1;
			next; 
        }
        if ($item =~  /^(T.*\d+)$/ && $start_tag == 1) { #�������� ���
			$last_tag = $1;
			if ($tmpl_flag == 1) {
				$start_tag = 0;
                next;
			}
			
			if ($start_tag == 1) {
        @result = ();
			}
			$tmpl_flag = 1;
            next; 
        }
        if ($item =~  /\*+End/) { #���������� ���� � �������            
            $tmpl_flag = 0;
            $start_tag = 0;
            next;
        }
        
        if ($item =~ /average/) {
            $tmpl_flag = 0;
            $start_tag = 0;
            next;
        }	
            
        
        if ($item =~  /([0-9]+)/ && $tmpl_flag == 1) { # ���������� ������� � ������� � �������
            $item =~ s/\n+//g;
	        push @result, $item;
		}
    }
    
    foreach my $item (@result) {
    	push @{$data_hash{$last_tag}}, $item;    
    }    
    return %data_hash;
}

sub average {

	my $file_name = shift;
	my %cfg =  get_last_result ($file_name);

	#print_test_data (%cfg);
	my %average = calculate_average (%cfg);

	my @list_key = sort {tag_compare ($a) <=> tag_compare ($b)} keys %average;
	my $last_key = $list_key[$#list_key];

	my @result_array = @{$average{$last_key}};
	#@result_array = @result_array[0..$#result_array-1]; #������� ��������� �������, �.� ��� ��-�� ��������� ����� � ������� ����� 0
	my $result_line = join (';', @result_array);

	#�������� ������ ����� �� �������, ����� Exel ������
	$result_line =~ s/\./,/g;
	my $text =  "\nThe average result for version " . $last_key . " is:\n" . $result_line . "\n";

	add_line_to_file ($file_name, $text);
}

#������� �������� ����� � ���������� � ����� ����
#� �������� ��������� ��������� ���� � ��� �����
sub MakeFinalReport {
    
    my $logFile = $_[0]; #�������� �� ��� ���� � ��� �����
    
    open (F_READ, "<$logFile") || die "Can't open file f_read.txt";
    my @fileStrings = <F_READ>;
    close (F_READ) || die "Can't close file f_read";
    
    my %map;
    foreach my $item (@fileStrings) {
      if ( $item =~ /�������: (\d+)/ ) { #�������� �������� ������� ���
        push @{$map{"�������� �������� ������� ���: "}}, $1;
      }
      if ( $item =~ /�����������: (\d+)/ ) { #���������� �������� ���� �����������
        push @{$map{"������� ���� �����������: "}}, $1;
      }
      if ( $item =~ /��: (\d+)/ ) { #�������� �������� ��
        push @{$map{"�������� �������� ��: "}}, $1;
      }
      if ( $item =~ /����� (\d+) / ) { #����� ��������� � ��
        push @{$map{"����� ��������� � ��: "}}, $1;
      }
      if ( $item =~ /������: (\d+) / ) { #���������� ����� ���
        push @{$map{"���������� ����� ���: "}}, $1;
      }
      if ( $item =~ /������: (\d+) / ) { #����������� ����� � ������
        push @{$map{"����������� ����� � ������: "}}, $1;
      }
    }
    # ���������� � ����� ���� �������� ������
    open (F_WRIGHT, ">>$logFile") || die "Can't open file log file";
    print F_WRIGHT "\n ######### ����� ######### \n";
    my %out_map = ();
    foreach my $key (sort keys %map) {
      my $sum = 0;
      my $idx = $#{$map{$key}};
      foreach my $item (@{$map{$key}}) {
        $sum += $item;
      }
      $out_map{$key} = $sum/($idx+1);
    }
    foreach my $key (sort keys %out_map) {
      print F_WRIGHT ("$key\n");
      print F_WRIGHT ("����������: ", join (' ', @{$map{$key}}), "\n");
      print F_WRIGHT ("������� �������� ", $out_map{$key},"\n");
    }
    
    close (F_WRIGHT) || die "Can't close file f_wright";    
}

1;
