#!/bin/bash

# Script to generate EPUB files from markdown files for each book

# Function to display help message
show_help() {
  echo "Usage: ./create-epub.sh [book_number]"
  echo ""
  echo "Options:"
  echo "  book_number    Optional. Specify a book number (e.g., 1 for book_1) to generate EPUB only for that book."
  echo "                 If omitted, generates EPUBs for all books."
  echo ""
  echo "Example:"
  echo "  ./create-epub.sh         # Generate EPUBs for all books"
  echo "  ./create-epub.sh 1       # Generate EPUB only for book_1"
  echo ""
  echo "File Structure:"
  echo "  Each book directory should contain:"
  echo "  - metadata.yml         - Book metadata file"
  echo "  - 00-intro.md          - Introduction file"
  echo "  - ##-chapter-name.md   - Chapter files (numbered sequentially)"
}

# Check if help is requested
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
  exit 0
fi

# Set script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOKS_DIR="$SCRIPT_DIR"
OUTPUT_DIR="$SCRIPT_DIR/epub_output"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Function to parse YAML frontmatter
parse_yaml() {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

# Function to read metadata from metadata.yml file
read_metadata() {
  local metadata_file="$1"
  
  if [ ! -f "$metadata_file" ]; then
    echo "Warning: Metadata file $metadata_file not found."
    return 1
  fi
  
  # Extract the YAML content between '---' markers
  local yaml_content=$(sed -n '/^---$/,/^---$/p' "$metadata_file" | sed '1d;$d')
  
  # Write to a temporary file to parse
  local temp_yaml="/tmp/temp_metadata_$$.yml"
  echo "$yaml_content" > "$temp_yaml"
  
  # Parse the YAML to shell variables
  eval $(parse_yaml "$temp_yaml" "meta_")
  
  # Clean up
  rm "$temp_yaml"
}

# Function to process a single book
process_book() {
  local book_number="$1"
  local book_dir="$BOOKS_DIR/book_$book_number"
  
  # Check if the book directory exists
  if [ ! -d "$book_dir" ]; then
    echo "Error: Book directory $book_dir does not exist."
    return 1
  fi
  
  echo "Processing book_$book_number..."
  
  # Read metadata
  local metadata_file="$book_dir/metadata.yml"
  read_metadata "$metadata_file"
  
  # Set default values if metadata wasn't found
  if [ -z "$meta_title" ]; then
    meta_title="Scarth Johnson - Book $book_number"
    meta_author="Scarth Johnson Series"
    meta_year=$(date +%Y)
  fi
  
  # Construct the full title with subtitle if available
  local full_title="$meta_title"
  if [ -n "$meta_subtitle" ]; then
    full_title="$meta_title: $meta_subtitle"
  fi
  
  echo "Book title: $full_title"
  
  # Temporary file to combine all chapter content
  local temp_file="$OUTPUT_DIR/temp_book_$book_number.md"
  
  # Clean the temporary file
  > "$temp_file"
  
  # First, add the intro if it exists
  local intro_file=""
  for intro_pattern in "$book_dir/00-intro.md" "$book_dir/INTRO.md" "$book_dir/intro.md"; do
    if [ -f "$intro_pattern" ]; then
      intro_file="$intro_pattern"
      break
    fi
  done
  
  if [ -n "$intro_file" ]; then
    echo "Adding intro: $(basename "$intro_file")..."
    # Strip frontmatter and add to temp file
    sed '/^---$/,/^---$/d' "$intro_file" >> "$temp_file"
    echo -e "\n\n" >> "$temp_file"
  fi
  
  # Find all chapter files using various possible naming patterns
  local chapter_files=$(find "$book_dir" -type f -name "[0-9][0-9]-*.md" -o -name "CHAPTER*.md" -o -name "chapter-*.md" | sort)
  
  if [ -z "$chapter_files" ]; then
    echo "Warning: No chapter files found in $book_dir"
  else
    # Process each chapter file
    echo "$chapter_files" | while read -r chapter_file; do
      echo "Adding chapter: $(basename "$chapter_file")..."
      
      # Strip frontmatter from chapter and add to temp file
      sed '/^---$/,/^---$/d' "$chapter_file" >> "$temp_file"
      
      # Add page break between chapters
      echo -e "\n\n<div style=\"page-break-after: always;\"></div>\n\n" >> "$temp_file"
    done
  fi
  
  # Output filename (sanitized)
  local sanitized_title=$(echo "$full_title" | tr -c '[:alnum:]' '_')
  local output_file="$OUTPUT_DIR/${sanitized_title}.epub"
  
  # Generate EPUB using pandoc
  echo "Generating EPUB: $output_file"
  pandoc "$temp_file" \
    --standalone \
    --toc \
    -o "$output_file" \
    --metadata title="$full_title" \
    --metadata author="${meta_author:-Scarth Johnson Series}" \
    --metadata date="${meta_year:-$(date +%Y)}" \
    --metadata lang="${meta_language:-en}" \
    --css="$SCRIPT_DIR/epub.css" 2>/dev/null
  
  # Check if the EPUB was successfully generated
  if [ -f "$output_file" ]; then
    echo "Success! EPUB created at: $output_file"
  else
    echo "Error: Failed to create EPUB for book $book_number."
  fi
  
  # Clean up temporary file
  rm "$temp_file"
}

# Function to create a basic CSS file for EPUB styling if it doesn't exist
create_css_file() {
  local css_file="$SCRIPT_DIR/epub.css"
  
  if [ ! -f "$css_file" ]; then
    echo "Creating default EPUB CSS file..."
    cat > "$css_file" << EOF
/* Basic EPUB styling for Scarth Johnson Series */
body {
  font-family: "Georgia", serif;
  line-height: 1.5;
  margin: 5%;
}

h1, h2, h3 {
  font-family: "Helvetica", "Arial", sans-serif;
  line-height: 1.2;
}

h1 {
  text-align: center;
  font-size: 2.2em;
  margin-top: 1em;
  margin-bottom: 1em;
}

h2 {
  font-size: 1.8em;
  margin-top: 1em;
  margin-bottom: 0.8em;
}

h3 {
  font-size: 1.4em;
  margin-top: 0.8em;
  margin-bottom: 0.6em;
}

p {
  margin-top: 0.5em;
  margin-bottom: 0.5em;
  text-align: justify;
}

hr {
  height: 1px;
  border: 0;
  background-color: #888;
  margin: 2em auto;
  width: 50%;
}
EOF
    echo "CSS file created at: $css_file"
  fi
}


# Create the CSS file
create_css_file

# Process specific book or all books
if [ -n "$1" ]; then
  # Process only the specified book
  process_book "$1"
else
  # Find all book directories and process each one
  for book_dir in "$BOOKS_DIR"/book_*; do
    if [ -d "$book_dir" ]; then
      book_number=$(basename "$book_dir" | sed 's/book_//')
      process_book "$book_number"
    fi
  done
fi

echo "EPUB generation complete."