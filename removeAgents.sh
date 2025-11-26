#! /bin/bash
asterisk -rx "queue show" | awk  '/^[0-9]/      { q = $1 }

/dynamic/    {


                        gsub ("[()]","",$2);
                        member = $2;
                        qremove =  "queue remove member " member " from " q;

                        command = "asterisk -rx \"" qremove "\"";

                        print command;

                        system(command);

             }' | sed 's/[()]//g'
