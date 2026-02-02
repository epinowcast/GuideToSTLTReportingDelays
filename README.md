# A guide to accounting for reporting delays in state, local, and territorial public health surveillance data

State, local, and territorial surveillance systems are essential for public
health decision making, but inherent delays between disease occurrence and
reporting create challenges for real-time analysis.
Other issues such as data revisions, site drop-in and drop-out, and data
quality problems can also manifest as apparent delays in aggregate data.
This guide provides practical guidance for epidemiologists, public health
practitioners, and modellers working with reporting delays and related
challenges in surveillance data.
We describe challenges in real-time use of surveillance data, opportunities from
modelling approaches, guidance on choosing appropriate methods, considerations
for communicating results, and practical case studies with implementation
resources.
We also highlight gaps where new modelling methods could address unmet needs in
public health practice.

## Links

📖 **[Read the paper](TBD)** (PDF)

🌐 **[Read the paper](TBD)** (HTML)

🌐 **[Guidance website](TBD)** (interactive decision tree and guidance)

💻 **[User-submitted snippets](TBD)** (community code examples)

💻 **[Source Code](https://github.com/epinowcast/GuideToSTLTReportingDelays)**
(GitHub)

## Output plan

### Primary output

- Manuscript (preprint, then journal submission)

### Secondary outputs

- Website version of content (coordination centre to support)
- Code repository/wiki for implementation snippets

### Dissemination

Session at next Insight Net meeting:

1. Introduction to challenges (talk)
2. Challenges discussion with group
3. Introduction to modelling opportunities (talk)
4. Modelling opportunities discussion
5. Decision tree and method selection (presentation + discussion)

## Repository structure

- `manuscript/` - Content plan and drafts
- `user-submitted-snippets/` - Code snippets and notebooks from users (future)
- `guidance-website/` - Guidance website content (future)
- `meeting/` - Meeting planning and feedback
- `resources/` - Reference materials and archived plans

## Running the analysis

### Prerequisites

1. **Quarto**: Follow the instructions at
   [quarto.org](https://quarto.org/docs/get-started/) to install Quarto.

2. **Task** (optional): Install [Task](https://taskfile.dev/installation/) for
   automated workflow management.

### Using Task (recommended)

```bash
task
```

Available tasks:

- `task` - Render all documents (default)
- `task render-paper` - Render the manuscript
- `task preview` - Preview manuscript with live reload
- `task install-extensions` - Install Quarto extensions
- `task --list` - Show all available tasks

### Manual execution

1. Install Quarto extensions:
   ```bash
   quarto add kapsner/authors-block --no-prompt
   ```

2. Render the manuscript:
   ```bash
   quarto render manuscript/paper.qmd
   ```

## Citation

*Citation information will be added upon publication.*
