# original author Pranav Nanda
# updated by Olivia Lutz

#returns pairwise contrasts using general linear hypothesis test
# requires list of regions, matrix of group contrasts, data frame, group name, list of covariates
# can set group.adjust for multiple comparisons (adjusts all contrasts per region)

# example
#dx.mat<-rbind(c(1,0,0,-1),c(0,1,0,-1),c(0,0,1,-1))
# rownames(dx.mat)<-c('SZP-NC','SADP-NC','BPP-NC')
#covar<-c('Age_cal','sex','RACE','site','ICV')
# results<-RunMat(region = c('choroid_plexus'), contrast = dx.mat, data = dat, group = 'DXGROUP_2',covars = covars)


library(multcomp)

RunMat <- function(region,contrast,data,group,covars=1,group.adjust="none"){
  
  results.data <- data.frame()
  grouptable <- table(data[,group])
  mod.test.p <- 0
  for (meas in region){
      mod <- lm(as.formula(paste(meas, "~", paste(covars, collapse='+'), "+", group)), data = data)
      mycontrast = mcp(group=contrast)
     
      names(mycontrast) = group
      
      mod.test <- summary(glht(mod, linfct=mycontrast), test = adjusted(type = group.adjust))$test
      
      mod.test.p = mod.test$pvalues
      mod.test.stat = mod.test$tstat
      results.data <- rbind(results.data,data.frame(contr=names(mod.test.p),region=meas,tstat=mod.test.stat, p=mod.test.p, d = NA, CI_lower=NA, CI_upper=NA))

  }
  
  return(results.data)
}


