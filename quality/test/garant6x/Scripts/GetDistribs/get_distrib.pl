use File::Copy;
use strict;

sub print_tags {
  my ($parent_dir, $pattern, $file_with_tags) = @_;
  chdir $parent_dir;
  opendir(DIR, '.') or die "Couldn't open directory, $!";
  while (my $file = readdir DIR) {
    if ($file =~ /$pattern/) {
      open (FH, $parent_dir. "\\" . $file . "\\" .$file_with_tags);
      my @tag = <FH>;
      close (FH);
      print join ('\n', @tag);     
    }    
  }
  closedir DIR;
}

sub copy_daily_builds {
  my ($source_dir, $pattern, $file_with_tags, $output_dir) = @_;
  chdir $source_dir;
  opendir(DIR, '.') or die "Couldn't open directory, $!";
  
  my %report = ();
  while (my $file = readdir DIR) {
    if ($file =~ /$pattern/) {
      if (open (FH, $source_dir. "\\" . $file . "\\" . $file_with_tags)) {     
        my @file_data = <FH>;
        my $tag = $file_data[0];
        chomp $tag;
        close (FH);
        if ($file =~ /english/) {
          $tag .= "-ENGLISH";
        }        
        my $dir = $output_dir . "\\" . $tag;
        if ($tag =~ /\w/) {          
          if (-e "$source_dir\\$file\\!success") {
	    qx (if not exist "$output_dir\\$tag" mkdir "$output_dir\\$tag");
            qx (if exist "$output_dir\\$tag\\$file" rmdir /q /s "$output_dir\\$tag\\$file");          
            qx (mkdir "$output_dir\\$tag\\$file");
            qx (xcopy "$source_dir\\$file" "$output_dir\\$tag\\$file" /y/e);
            $report{$tag} .= "build was taken\n";
          } else {
            $report{$tag} .= "build wasn't taken\n";
          }
        }
      }      
    }
    if ($file =~ /-installer/) {
      my $temp = $file;
      $temp =~ s/-installer//g;
      
      if (open (FH, $source_dir. "\\" . $temp . "\\" . $file_with_tags)) {     
        my @file_data = <FH>;
        my $tag = $file_data[0];
        chomp $tag;
        close (FH);
        if ($file =~ /english/) {
          $tag .= "-ENGLISH";
        }                
        if (-e "$source_dir\\$temp\\!success") {
	  qx (mkdir "$output_dir\\$tag\\$file");
          qx (xcopy "$source_dir\\$file" "$output_dir\\$tag\\$file" /y/e);
        } else {
        }
      }      
    }
  }
  closedir DIR;
  
  return %report;
}

sub sleep_while_build {
  my ($file_pattern, $source_dir) = @_;
  chdir $source_dir;
  my @my_files = <*${file_pattern}*>;
  while (@my_files) {
    print "Build started, sleep 100 sec\n";
    sleep 100;
    @my_files = <*${file_pattern}*>;
  }
}
my $source_dir = "\\\\developer\\garant-nemesis-ro\\deployment";
my $out_dir = "C:\\WORKS";
my $disk = "H:";
#qx (net use "$source_dir" "$disk");

sleep_while_build ("build-script-schedule", "$source_dir");

my $blat_dir = "c:";
my $mail_to = "newdev\@garant.ru,qc\@garant.ru";
my $reply_to = $mail_to;
my $mail_form = "qc_auto\@garant.ru";
my $smtp_server = "smtp.garant.ru";
qx ($blat_dir\\blat.exe - -body "Пожалуйста не запускайте пересборку, пока не заберется версия" -charset "windows-1251" -f "$mail_form" -priority "1" -replyto "$reply_to" -server "$smtp_server" -subject "Забираем сборку" -to "$mail_to");    
my %builds = copy_daily_builds ($source_dir, "!daily", "!cvs_tag", $out_dir);
foreach my $key (keys %builds) {  
  qx ($blat_dir\\blat.exe - -body "$key" -charset "windows-1251" -f "$mail_form" -priority "1" -replyto "$reply_to" -server "$smtp_server" -subject "$key - $builds{$key}" -to "$mail_to");
}