# Scarth Johnson Series

This project aims to create deeply immersive, audiobook-style narratives that transport readers/listeners into the cyberpunk world of Scarth Johnson. Set in a future version of Night City inspired by the Cyberpunk 2077 universe, these stories follow netrunner and mercenary Scarth Johnson as she navigates corporate intrigue, technological dangers, and personal challenges in a dystopian future where the line between human and machine continues to blur.

The series employs vivid storytelling, sensory-rich descriptions, and well-developed characters to create an engaging narrative experience. Stories balance high-stakes action with quieter character moments, exploring both the external conflicts of corporate warfare and the internal struggles of identity and connection in a world where technology increasingly redefines what it means to be human.

## Project Structure & File Organization

The project is organized as follows:

```
scarth-johnson/
│
├── book_1/                  # First book - "Ghost in the Machine"
│   ├── metadata.yml         # Book metadata (title, subtitle, author, etc.)
│   ├── 00-intro.md          # Book introduction
│   ├── 01-chapter-one.md    # First chapter
│   ├── 02-chapter-two.md    # Second chapter
│   └── ...
│
├── book_2/                  # Second book (when created)
│   ├── metadata.yml
│   └── ...
│
├── world/                   # World-building materials
│   ├── character-sheets/    # Character information
│   └── ...
│
├── epub_output/             # Generated EPUB files
│
├── create-epub.sh           # Script to generate EPUB files
└── epub.css                 # Styling for EPUB files
```

### File Naming Conventions

1. **Directories**: Use lowercase with hyphens for multi-word names (`book-1`, `character-sheets`)
2. **Chapter Files**: Use the format `##-chapter-name.md` where `##` is a two-digit number for ordering (e.g., `01-signal-to-noise.md`)
3. **Introduction File**: Use `00-intro.md` for book introductions
4. **Metadata File**: Each book directory must contain a `metadata.yml` file with book information

### Metadata File Format

Each book directory should contain a `metadata.yml` file with the following structure:

```yaml
title: "Ghost in the Machine" # Book title
subtitle: "A Scarth Johnson Novel" # Optional subtitle
author: "Scarth Johnson Series" # Author name
series: "Scarth Johnson" # Series name
volume: 1 # Book number in series
year: 2025 # Publication year
language: "en" # Language code
tags: # Optional tags
  - cyberpunk
  - sci-fi
  - dystopian
```

## EPUB Generation

The repository includes a script to automatically generate EPUB files from the markdown chapters:

```bash
# Generate EPUBs for all books
./create-epub.sh

# Generate EPUB for a specific book
./create-epub.sh 1     # Generates EPUB for book_1

# Show help information
./create-epub.sh --help
```

The script:

- Reads the book metadata from `metadata.yml`
- Combines all chapter files in numerical order
- Adds a table of contents
- Applies consistent styling via `epub.css`
- Outputs the file to the `epub_output/` directory
