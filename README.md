# Stats-Scripts
R scripts useful for statistics

## returnAdj
-required for effect_size, get_anova, get_anova_perm and runcontrast_d below
- returns a data.frame with values adjusted for designated covariates
- Requires:
  - data: The overarching data.frame
  - measure: A string for the name of the vector to be adjusted
  - covars: A vector holding the names of the covariates to be used (but not in an interaction term)
  - interacts: A vector holding the names of covariates to be used in an interaction term
  - display: A boolean indicating that the original-adjusted value correlations are to be printed. This defaults to true.
  - method: A string identifying the mean adjusting methods. This defaults to 'iadj'. The other options include 'smean' and 'null'.
  - This feature provides you with the option to fetch sample means adjusted based on: Intercept adjusted (iadj), sample mean (smean) or 'null' adjusted.
  - subset: A conditional expression that returns a vector of booleans the same length as the vector to be adjusted. This can be used to generate the model on only a subset of the data (e.g. Controls only)

## effect_size

- calculates Cohen's D between two groups and adjusts for covariates
- requires data frame (data)
- measure ('Left_frontal_thickness')
- name of group variable (eg 'group','PHENOTYPE')
- name of levels to compare within group variable ('SZ','HC') 
  - Note can only handle two levels
- list of covariates ( covars=c('age','sex','race'))

## get_anova

- calculates Anova contrast (type 3) between two groups and effect sizes (Cohen's D)
- outputs p value and adjusted p values

- requires data frame (data)
- list of measures c('Left_frontal_thickness','Right_frontal_thickness')
- name of group variable (eg 'group','PHENOTYPE')
- name of levels to compare within group variable ('SZ','HC')
    - Note can only handle two levels
- list of covariates ( covars=c('age','sex','race'))

## repeated_anova

- Repeated measures anova to calculate a group by time interaction
- outputs F stats and p values for group, time and group by time
- requires your original data frame, a list of measures, list of covariates, list of two interaction terms (eg. Group and Timept) and name of subject id.

## get_anova_perm
- run permutation testing for p values
- also run anova pairwise comparisons
- make sure effect_size and returnAdj functions are also sourced.

## run_contrast
- returns pairwise contrasts using general linear hypothesis test
- requires list of regions, matrix of group contrasts, data frame, group name, list of covariates
- can set group.adjust for multiple comparisons (adjusts all contrasts per region)

## run_contrast_d

- calculates Cohen's D effect Size (adjusted for covariates) for runcontrast output
- dat- main dataframe with all your subject info/data
- results- results from runcontrast
- name of group variable (eg. 'Group')
  - NOTE: Group identifiers CANNOT contain '-' (eg. 'BP-P' must be 'BPP','BP_P',etc)
  - NOTE: Group identifiers in 'contr' column of runcontrast output must match original data frame in Group column
- covars= list of covariates (c('age','sex','site'))


