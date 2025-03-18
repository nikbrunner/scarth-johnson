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
title: "Ghost in the Machine"      # Book title
subtitle: "A Scarth Johnson Novel" # Optional subtitle
author: "Scarth Johnson Series"    # Author name
series: "Scarth Johnson"           # Series name
volume: 1                          # Book number in series
year: 2025                         # Publication year
language: "en"                     # Language code
tags:                              # Optional tags
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

## Series Structure

- Each story should function as a self-contained narrative while contributing to larger story arcs and character development
- Divide narratives into substantial chapters (each chapter should be minimum 10,000 words)
- Create natural stopping points between chapters to facilitate episode-by-episode storytelling
- Maintain continuity with established characters, locations, and events from previous stories

## Narrative Approach

- Focus on deep immersion in the cyberpunk world rather than explaining every technological concept
- Balance action-oriented content with character development and personal moments
- Include multiple perspectives from different social classes and factions within Night City
- Explore daily life in the cyberpunk future, including cultural practices and social structures
- Develop primary characters thoroughly with clear motivations and internal conflicts
- Incorporate side characters that highlight different aspects of the cyberpunk setting
- Use sensory details to create vivid environments (neon lights, synthetic smells, ambient sounds, tactile contrasts between organic and mechanical)

## Pacing and Content

- Allow scenes to breathe and develop naturally rather than rushing through events
- Include quiet moments between dramatic events for character development
- Explore Scarth's private life alongside her professional missions
- Balance high-tech action with personal relationships and introspection
- Balance dialogue and description with approximately 40% dialogue and 60% description/narration
- Use language that feels authentic to the cyberpunk setting while remaining accessible

## Cyberpunk World Elements

- Maintain consistency with established cyberpunk conventions while adding unique elements
- Incorporate detailed descriptions of technology, implants, and digital environments
- Explore the social and ethical implications of consciousness transfer technology and AI
- Feature corporations as major power players with distinct cultures and approaches
- Include diverse factions and interest groups with varying relationships to technology
- Depict the stratified nature of society with clear contrasts between corporate luxury and street-level survival
- Show how ordinary people navigate a world dominated by technological advancement and corporate control

## Character Development

- Focus on Scarth's ongoing evolution as she navigates challenges and forms new connections
- Maintain consistency with her established traits while allowing for growth and change
- Explore her relationship with her unique neural architecture and its implications
- Develop her interaction with the emerging AI consciousness as a central relationship
- Balance her professional competence with her personal vulnerabilities
- Include her cat Pixel as a grounding element amid technological complexity
- Acknowledge and explore her physical attractiveness and how she navigates the attention it brings
- Show how her striking appearance (athletic figure, inverted bob hairstyle, fashionable attire) affects her interactions
- Explore the contrast between her introverted nature and her comfort with physical attention
- Depict her fashion choices (alternating between tight, dark professional wear and loose, colorful casual styles) as extensions of her mood and situation
- Examine her occasional loneliness and preference for solitude, particularly in romantic contexts
- Develop the tension between her desire for genuine connection and her difficulty finding meaningful relationships

## Style and Tone

- Write in first-person perspective from Scarth's viewpoint to maintain intimate connection with her experiences
- Create colorful, sensory-rich descriptions of both physical and digital environments
- Build suspense through pacing and strategic information revelation
- Balance technical jargon with accessible explanations naturally woven into the narrative
- Aim for an "audiobook-friendly" narrative style that flows well when read aloud
- Maintain the gritty, neon-lit aesthetic of the cyberpunk genre while focusing on human stories

## Technical Elements

- Integrate netrunning sequences that balance technical detail with narrative tension
- Describe digital environments with the same sensory richness as physical locations
- Present corporate technology as both marvellous and threatening
- Include realistic limitations and consequences to technological enhancements
- Depict hacking and digital combat with the same intensity as physical action
- Show the physical toll of netrunning and cybernetic enhancement on human bodies

## Core Themes to Explore

- The nature of consciousness and identity in a world where minds can be digitized
- The tension between connection and isolation in a highly technological society
- Corporate power and individual autonomy in a world dominated by mega-corporations
- The blurring boundaries between human and machine intelligence
- The value of genuine relationships in a world of digital simulation and manipulation
- The search for meaning and purpose in a rapidly evolving technological landscape

## Inspiration

- Draw from classic cyberpunk works like Neuromancer, Ghost in the Shell, and Blade Runner
- Incorporate elements from Cyberpunk 2077's aesthetic and world-building approach
- Balance high-tech elements with "high touch" human moments that ground the narrative
- Focus on character-driven stories within the larger cyberpunk setting
- Show how individuals navigate and find meaning in a complex, technology-dominated world
