install.packages("rms")
install.packages("pROC")
install.packages("rmda")
install.packages("riskRegression")
library(rms)
library(pROC)
library(rmda)
library(readr)
library(riskRegression)
library(glue)
library(foreign)
library(survival)
mydata1<- BPD5_31_25
mydata$chorioamnionitis<- factor(mydata$chorioamnionitis)
mydata$NEC<- factor(mydata$NEC)
mydata$sepsis<-factor(mydata$sepsis)
dd=datadist(mydata)
option<-options(datadist="dd")
colnames(mydata)
formula<-as.formula(sepsis ~Invasive_ventilator_duration+CRIBII+chorioamnionitis+NEC)
model<-lrm(formula,
           data=mydata1,
           x= T,
           y=T)
model

save(model,file = '/Users/hmoye/Desktop/sepis/model_data.Rdata')
OR <-exp(model$coefficients)
OR
library(nomogramFormula)
Nomogram_1<-nomogram(model,
                     fun = function(x)1/(1+exp(-x)),
                     lp=F,
                     fun.at = c(0.1,0.3,0.5,0.7,0.9),
                     funlabel = "Risk")
plot(Nomogram_1)
model_ROC<-glm(formula,data = mydata1,family = binomial())
mydata1$predvalues<-predict(model_ROC,type = "response")
ROC<-roc(mydata1$sepsis,mydata1$predvalues)
auc(ROC)
ci(auc(ROC))
#校准曲线
cal1<-calibrate(model,method = "boot",B=1000)
plot(cal1,xlim=c(0,1.0),ylim=c(0,1.0))
library(ggDCA)
library(ggplot2)
mydata2<-BPD5_31
DCA_training<-decision_curve(sepsis ~Invasive_ventilator_duration+CRIBII+chorioamnionitis+NEC,
                             data=mydata2,
                             #,policy = "opt-in"
                             study.design='cohort',
                             thresholds=seq(0,1, by=0.05), bootstraps=1000)
# DCA绘图
plot_decision_curve(DCA_training,
                    curve.names=c('Nomogram model'),
                    cost.benefit.axis=FALSE,
                    col=c("red","#E69F00","#009E73","#D55E33","#CC79A7"),
                    confidence.intervals=FALSE,
                    standardize=FALSE,
                    legend.position=c("topright"))
# CIC绘图
plot_clinical_impact(DCA_training,population.size=1000,
                     cost.benefit.axis=T,
                     n.cost.benefits=8,
                     col=c('red','blue'),
                     confidence.intervals=F)
remotes::install_github("yikeshu0611/ggDCA")
??plot_decision_curve

library(rms) 
#加载R语言中的rms包。rms包是一个用于回归模型策略和其他统计学方法的包
mydata4<- mydata2[100-240,]
f1 <- glm(sepsis ~Invasive_ventilator_duration+CRIBII+chorioamnionitis+NEC, 
          data = mydata4, family = binomial(link = "logit")) 
#这个模型预测变量l（通常代表二元结果，比如是/否）作为因变量，a1、h123、L097、M_V、wc111和p1495作为自变量。这里使用的是binomial分布（二项分布），链接函数为logit，代表是一个逻辑回归模型。这个模型是用Train数据集来拟合的。
P1 <- predict(f1, type = "response")
val.prob(P1, mydata4$sepsis)
