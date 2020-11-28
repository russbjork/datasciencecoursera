library(dplyr)
library(readr)   
ag<-read_csv("Data/getdata_data_ss06hid.csv",col_types=cols_only(RT="c",SERIALNO ="n",ACR="n",AGS="n"))
head(agLog)
str(agLog)
agLogic<-filter(ag,ACR==3 & AGS==6)
agLogic<-ag$ACR==3 & ag$AGS==6