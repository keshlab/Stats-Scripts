# authors: Suraj Sarvode Mothi and Olivia Lutz 6/22/18

## run permutation testing for p values
# also run anova pairwise comparisons
# make sure effect_size and returnAdj functions are also sourced.

# requires subset of data with only 2 groups (won't work with more than 2 groups since data is shuffled) dat[dat$group %in% c('SZ','HC'),]
# group variable name: 'group;
# group 1 and group 2 identifiers: 'SZ', 'HC'
# list of measures: c('left_hippocampus','right_hippocampus')
# covariate list: c('age','sex','site')
# run using get_anova_perm

library(mosaic)
library(car)
permutations <- function(data, meas, group, covars)
{
  ### Perprocessing:  Perform a return adj
  adj_val <- as.data.frame(returnAdj(data=data,measure=meas,covars=covars))
  names(adj_val) <- c(meas)
  #print(adj_val)
  diagnosis <-as.data.frame((data[,group]))
  names(diagnosis) <- c("group")
  # print(diagnosis)
  ds <- cbind(diagnosis,adj_val)
  ds$group<-factor(ds$group)
  ### Step 1. Fetch the observed difference in means ###
  obs <- mean(ds[,2] ~ ds[,1],data=ds, na.rm=TRUE) %>% diff()
  print(meas)
  ### Step 2. Do 1000 Iterations ####
  null_meas <- do(10000) * mean(ds[,2] ~ shuffle(ds[,1]), data=ds,na.rm=TRUE) %>% diff()
  
  ### Step 3. Calculate the permutation p values
  if(obs < 0){
    perm_p<- prop(~null_meas[,names(null_meas)] <= obs, data=null_meas)[[1]]
  }
  if(obs > 0){
    perm_p<- prop(~null_meas[,names(null_meas)] >= obs, data=null_meas)[[1]]
  }
  return(perm_p)
  
}

get_anova_perm<-function(data,group,group1, group2, measures,covars){
  result<-c()
  pval<-c()
  d<-c()
  perm_p <- c()
  for (meas in measures){
    result<-unlist(Anova(lm(as.formula(paste(meas,'~',group,'+',paste(covars, collapse = '+'))),data = data),type='III',na.action=na.omit))
    pval<-append(pval, result['Pr(>F)2'])
    d<-append(d, effect_size(data, meas,group, group1, group2,covars))
    perm_p <- append(perm_p, permutations(data,meas,group, covars)) #######
  }
  adj_pval <- p.adjust(pval, method="BH")
  out<-data.frame(measures,pval=round(pval,3),adj_pval=round(adj_pval,3),d, perm_p)
  names(out)<-c("Region","p_value","Adjusted_p_value","Cohens_D","perm_p")
  return(out)
}