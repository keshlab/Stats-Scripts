## requires cohensd.R and returnAdj.R

## calculates Anova contrast (type 3) between two groups and effect sizes (Cohen's D)
## requires data frame (data)
## list of measures c('Left_frontal_thickness','Right_frontal_thickness')
## name of group variable (eg 'group','PHENOTYPE')
## name of levels to compare within group variable ('SZ','HC') 
## Note can only handle two levels
## list of covariates ( covars=c('age','sex','race'))

get_anova<-function(data,group,group1, group2, measures,covars){
  result<-c()
  pval<-c()
  d<-c()
  for (meas in measures){
    result<-unlist(Anova(lm(as.formula(paste(meas,'~',group,'+',paste(covars, collapse='+'))),data = data),type='III',na.action=na.omit))
    pval<-append(pval, result['Pr(>F)2'])
    d<-append(d, effect_size(data, meas,group, group1, group2,covars))
  }
  adj_pval <- p.adjust(pval, method="BH")
  out<-data.frame(measures,pval=round(pval,3),adj_pval=round(adj_pval,3),d)
  names(out)<-c("Region","p_value","p_value_adj",'Cohens_D')
  return(out)
}