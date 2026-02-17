# Alternative Plan

A practical guide to nowcasting with state, tribal, local, and territorial public
health surveillance data.

Audience(s): epidemiologists and public health practitioners interested in
implementing nowcasting; modelers who want to expand their understanding of
nowcasting in practice.

Proposed Outputs:

1. Interactive website with decision flow/tree/table
2. Manuscript for PH and academics in an epi journal

## Introduction

Context: inherent delays between disease occurrence and reporting to US public
health surveillance systems.

Common approaches to handling the data delays:

- Pruning recent data
- Utilising incomplete data with caveats
- Nowcasting

Defining nowcasting and scope of this guide: reporting delays that can be at
least partially informed/inferred by historic patterns.

Types of PH data challenges:

- Reporting delays: Right-truncation, lab confirmation requirements, electronic
  vs manual reporting differences, weekend and holiday effects
- Data revisions: downward corrections from duplicate removal, case
  reclassifications, date corrections, de-duplication
- Site-specific variations: system-to-system delays, hospital/facility
  intermittent reporting, urban vs. rural reporting capabilities, EHR
  integration disparities
- Data quality issues: Duplicate entries across systems, missing or incorrect
  dates or strata variables of interest (e.g., race/ethnicity), incompatible
  formats

Benefits of addressing these data delays and why nowcasting matters:

- Situational awareness, better insights into true trend
- Support for decision-making (e.g., decisions about mask requirements in
  healthcare settings based on true trend, identifying and addressing
  inequities when epidemic trends differ across groups)
- Improved forecasting

Example use cases for nowcasting:

- Hospitalisations: NSSP/syndromic surveillance
- Cases: case counts from surveillance systems
- Non-count: variant proportions

Publicly available examples of applied PH nowcasting:

- Massachusetts Department of Public Health's respiratory illness dashboard
- New York City's nowcasting during mpox and COVID-19 emergencies
- California's nowcast of COVID-19 effective reproduction number
- CDC's COVID-19 variant nowcast

Aims:

- Provide guidance for PH practitioners and modellers planning to implement
  nowcasting within STLT jurisdictions
- Connect PH practitioners and modellers with existing relevant nowcasting
  methods/tools
- Guide modellers on the challenges that practitioners have

## Steps to implementing nowcasting

### Assessing the data source and predictability of delay

- What historic data is most informative?
- Considerations for nowcasting during emergencies vs. chronic delays
- Determining variables needed, strata of interest
- Defining report and reference dates of interest
- Consider preferred event date hierarchy (NYC mpox example)
- Ability to assess data revision history

### Analysing delay and delay distributions

- Choosing a maximum delay and training window
- Volume of data available
- Representativeness

### Determining the best/appropriate method for nowcasting

Types of methods and determining best fit:

- Bayesian smoothing approaches (e.g., NobBS, epinowcast)
- Generalised additive models (nowcaster, UKHSA GAMs)
- Semi-mechanistic approaches (e.g., EpiNow2, epinowcast)
- Chain ladder methods (baselinenowcast, chainladder)

Decision tree for the nowcasting methods.

Considerations for when NOT to nowcast.

### Implementation considerations of the chosen nowcasting method

- Technical adjustments to capture data revision history
- Aggregating data by report/reference date
- Software/Infrastructure (e.g., Stan)
- Failure modes
- Considerations for stratified nowcasts

### Validating/evaluating a nowcast

Validations:

- Practical qualitative methods (e.g., flipbooking/assessing alignment with
  epidemic trends)
- Alignment with overall trend vs. inflection points
- Applied PH practical quantitative methods (e.g., coverage, correlation with
  point estimate, residuals). Note: overcovering is not good.
- More advanced/academic/research methods (WIS, MAE/MSE, etc.) for comparing
  against other methods
- Tension between domain expertise and theoretical scores

Evaluations:

- Evaluation for public health utility
- Against a baseline
- Against other common methods

### Visualising/communicating nowcasts

Best practices/standards for public-facing nowcasts:

- Data presentation
- Communicating uncertainty
- Placing nowcasts in context (e.g., against seasonal intensity thresholds)
- What prediction/confidence intervals to show or use for decisions

Advocating to public health leadership:

- Explaining nowcasts
- Justifying system modifications

## Common methods/tools summary

Table linking methods to considerations with examples of common PH data sources.

List of common nowcasting packages:

- Epinowcast, EpiNow2
- NobBS, diseasenowcasting
- Baselinenowcast
- ChainLadder
- Ad-hoc methods

Other nowcasting approaches:

- Generalised additive models
- P-Spline

## Outstanding challenges

To be developed.
