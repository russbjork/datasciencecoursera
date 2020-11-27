##
## MySQL examples
##
ucscDb<-dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")
result<-dbGetQuery(ucscDb,"show databases;"); dbDisconnect(ucscDb)
##
hg19<-dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables<-dbListTables(hg19); dbDisconnect(hg19)
length(allTables)
##
hg19<-dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables<-dbListTables(hg19)
allTables
dbListFields(hg19,"acembly")
dbGetQuery(hg19,"select count(*) from acembly")
acemblyData<-dbReadTable(hg19,"acembly")
dbDisconnect(hg19)
##
hg19<-dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
query<-dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affMis<-fetch(query)
affMisSmall<-fetch(query,n=10)
dbClearResult(query)
##
