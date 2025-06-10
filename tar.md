# TAR
## Exteract to Special path
```bash
  tar -xzvf file.name.tar -C /path/to/directory
```
Or
```bash
  tar -xzvf file.tar --directory /path/to/directory
```

## show content file tar
tar -tf <name of file>


-t, --list
List the contents of an archive. Arguments are optional. When given, they specify the names of the members to list.

-f, --file=ARCHIVE Use archive file or device ARCHIVE...

## extract only or same file from tar 

tar -xzvf \<tar file\> --wildcards --no-anchored '\<pattern or name file\>'

- -x: instructs tar to extract files.
- -f: specifies filename / tarball name.
- -v: Verbose (show progress while extracting files).
- -j : filter archive through bzip2, use to decompress .bz2 files.
- -z: filter archive through gzip, use to decompress .gz files.
- --wildcards: instructs tar to treat command line arguments as globbing patterns.
- --no-anchored: informs it that the patterns apply to member names after
