 my $new         = substr($path,0,-3)."mp3";
                my $cmd         = "lame \"$path\" \"$new\"";
                system($cmd);
                if(-e $new) {
                        print "Compressed\n" if($debug > 1);
                        $filesize = -s $new;
                        if($filesize > 0) {
                                system("rm -f \"$path\"");
                                system("mv \"$new\" \"$path\"");
                        }
