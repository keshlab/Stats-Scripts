# Stats-Scripts
R scripts useful for statistics

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

## permutations
