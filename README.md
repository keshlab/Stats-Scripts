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

## run_contrast_d

## permutations
