# Repeated measures anova
# calculates a group by time interaction
# outputs F stats and p values for group, time and group by time

# Author Olivia Lutz 6/22/2018

# covars<-c('RACE','SES',"SEX", "agecnsnt", 'HANDED')
# inter<-c('CELL2','TIMEPT')
# sns<-c('AVNESCOGPER', 'AVNESREPMOT', 'AVNESTOT13')
# repeat_meas_anova(data=dflong, measures=sns, covars=covars, inter = inter, subjid = 'RECID')


repeat_meas_anova<-function(data,measures,covars,inter, subjid){
  out<-data.frame()
  for (meas in measures){
    result<-summary(aov(as.formula(paste(meas,'~',paste(covars, collapse='+'), '+', paste(inter[1],inter[2],sep='*'),
                                         '+', paste('Error(',subjid,')',sep=''))),data = data))
    # extract interaction term
    pval_inter<-unlist(result)[paste('Error: Within.Pr(>F)',length(c(covars,inter))+1,sep='')]
    fval_inter<-unlist(result)[paste('Error: Within.F value',length(c(covars,inter))+1,sep='')]
    
    # extract group term
    pval_group<-unlist(result)[paste('Error: Within.Pr(>F)',length(c(covars,inter))-1,sep='')]
    fval_group<-unlist(result)[paste('Error: Within.F value',length(c(covars,inter))-1,sep='')]
    
    # extract time term
    pval_time<-unlist(result)[paste('Error: Within.Pr(>F)',length(c(covars,inter)),sep='')]
    fval_time<-unlist(result)[paste('Error: Within.F value',length(c(covars,inter)),sep='')]
    
    out<-rbind(out, data.frame(measure=meas, fval_group, round(pval_group,3),fval_time, round(pval_time,3),
                               fval_inter, round(pval_inter,3)))
  }
  names(out)<-c('Measure',paste('Fval_',inter[1],sep=''),paste('pval_',inter[1],sep=''), paste('Fval_',inter[2],sep=''),
                paste('pval_',inter[2],sep=''), paste('Fval_',paste(inter[1],inter[2],sep='*'),sep=''),
                paste('pval_',paste(inter[1],inter[2],sep='*'),sep=''))
  row.names(out)<-NULL
  return(out)
}