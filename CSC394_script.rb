require 'json'
require 'csv'

def parse_jsonfile (filepath)
   "Parses a given file in JSON format and returns the resulting hash."
   hash = nil
   File.open(filepath, "r") { |file|
     hash = JSON.parse(file.read)
   }

   return hash
end

def hash_to_json_file (hash, filepath)
   "Writes the given hash in JSON format to a given filepath."
   File.open(filepath, "w") { |file|
     file.puts(JSON.generate(hash))
   }
end

def main (csv_path, json_filepath)
  contents = nil
  File.open(csv_path,"r") { |f|
    contents = f.read
  }

  csv = CSV.new(contents, :headers => true)

  data = csv.to_a.collect { |row|
    row.to_hash
  }

  data.each { |elt|
    res = elt["DESCRLONG"][/PREREQUISITE(.)*/]
    puts res if res && res.length > 0
  }

  #hash_to_json_file(data, json_filepath)

  #print(data.class)
  puts "\nDone."
end

main("/Users/Captain/Desktop/Q_COURSES1.csv", "/Users/Captain/Desktop/q_courses1.json")
