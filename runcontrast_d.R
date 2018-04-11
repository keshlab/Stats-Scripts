## requires runcontrast.R, cohensd.R and returnAdj.R
# calculates Cohen's D effect Size (adjusted for covariates) for runcontrast output

# dat- main dataframe with all your subject info/data
# results- results from runcontrast
# name of group variable (eg. 'Group')
  # NOTE: Group identifiers CANNOT contain '-' (eg. 'BP-P' must be 'BPP','BP_P',etc)
  # NOTE: Group identifiers in 'contr' column of runcontrast output must match original data frame in Group column
# covars= list of covariates (c('age','sex','site'))

runcontrast_d<-function(dat, results,group,covars){
  for(x in 1:length(results[,'contr'])){
    tmp<-strsplit(as.character(results[,'contr'][x]),'-')
    group1<-gsub(" ","", unlist(tmp)[1])
    group2<-gsub(" ","", unlist(tmp)[2])
    results[,'d'][x]<-(effect_size(dat,as.character(results[,'region'][x]), group,group1,group2,covars))
  }
  return(results)
}