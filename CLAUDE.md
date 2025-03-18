# CLAUDE.md - Scarth Johnson Series

## Project Overview
This is a creative writing project for a series of cyberpunk stories following the character Scarth Johnson, a netrunner and mercenary in a future version of Night City.

## Repository Structure
- `/book_1/` - Contains chapter files for the first book "Ghost in the Machine"
- `/world/` - Contains character sheets and world-building information
- `/epub_output/` - Generated EPUB files for each book

## Writing Style Guidelines
- Write in first-person perspective from Scarth's viewpoint
- Create colorful, sensory-rich descriptions of both physical and digital environments
- Balance technical jargon with accessible explanations
- Maintain an "audiobook-friendly" narrative style that flows well when read aloud
- Aim for approximately 40% dialogue and 60% description/narration
- Use markdown formatting for chapter structure and organization

## Formatting Conventions
- Chapter files use the format: `CHAPTER X - TITLE.md`
- Use consistent frontmatter with date created/modified
- Each chapter should be a self-contained markdown file
- Use `---` for section breaks within chapters

## Content Guidelines
- Focus on deep immersion rather than explaining every technological concept
- Balance action with character development and personal moments
- Include multiple perspectives from different social classes
- Develop primary characters thoroughly with clear motivations

## Build Commands
- Create EPUB files: `./create-epub.sh` - Generates EPUB files for all books
- Create EPUB for specific book: `./create-epub.sh 1` - Generates EPUB only for book_1
- Help: `./create-epub.sh --help` - Shows usage information and file structure