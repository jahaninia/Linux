```bash
  for i in $(ls 1011_*.tgz); do echo $i ; tar -xzvf $i --wildcards --no-anchored '*.sql';grep "^INSERT INTO \`recordings\`" 1011.sql > recordings_inserts_$i.sql ; done
```
## get name of file dump mysql and outpute name of sql first find "INSERT INTO `recordings`" and after replace by "REPLACE INTO `recordings`" and find charecter ';' and wite all find in outpute file

```python
  import argparse
  
  parser = argparse.ArgumentParser(description="Extract INSERT INTO `recordings` blocks from SQL dump and convert to REPLACE INTO.")
  parser.add_argument("input", help="Path to the input .sql file")
  parser.add_argument("output", help="Path to the output file to save modified inserts")
  args = parser.parse_args()
  
  inside_insert = False
  
  with open(args.input, "r", encoding="utf-8") as f_in, open(args.output, "w", encoding="utf-8") as f_out:
      for line in f_in:
          if line.startswith("INSERT INTO `recordings`"):
              line = line.replace("INSERT INTO `recordings`", "REPLACE INTO `recordings`")
              inside_insert = True
  
          if inside_insert:
              f_out.write(line)
              if line.strip().endswith(";"):  # end of SQL statement
                  inside_insert = False

```
```bash
   for i in $(ls 1011_*.tgz); do echo $i ; tar -xzvf $i --wildcards --no-anchored '*.sql';python3 extract_recordings.py 1011.sql recordings_inserts_$i.sql ; done
```

