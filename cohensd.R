### please source returnAdj.R

## calculates Cohen's D between two groups and adjusts for covariates
## requires data frame (data)
## measure ('Left_frontal_thickness')
## name of group variable (eg 'group','PHENOTYPE')
## name of levels to compare within group variable ('SZ','HC') 
  ## Note can only handle two levels
## list of covariates ( covars=c('age','sex','race'))

effect_size <- function(data, meas,group, group1, group2,covars){
  m_out<-tapply(returnAdj(data, meas,covars=covars), data[, group], mean,na.rm=TRUE)
  m1<-m_out[names(m_out) %in% group1]
  m2<-m_out[names(m_out) %in% group2]
  
  sd_out<-tapply(returnAdj(data, meas,covars=covars), data[, group], sd,na.rm=TRUE)
  s1<-sd_out[names(sd_out) %in% group1]
  s2<-sd_out[names(sd_out) %in% group2]
  
  #   n1<-sum(data$group == group1)
  #   n2<-sum(data$group == group2)
  n1<- length(data$group[data$group==group1 & !is.na(data[, meas])])
  n2<- length(data$group[data$group==group2 & !is.na(data[, meas])])
  SDp <- sqrt(((n1-1) * (s1 ** 2) + (n2 -1) * (s2 **2))/(n1 + n2 -2))
  #SDp <- sqrt(((s1 ** 2) + (s2 **2))/(2))0
  d <- (m1-m2)/SDp
  return (d)
}