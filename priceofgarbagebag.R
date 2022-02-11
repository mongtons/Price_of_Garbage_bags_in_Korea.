library(tidyverse)
library(ggplot2)
library(data.table)
library(RColorBrewer)

getwd()
setwd("c:/Users/samsung/OneDrive/바탕 화면/Data_Practice")
trash_plasticbag=fread("전국종량제봉투가격표준데이터.csv", header=T)%>%as_tibble()
view(trash_plasticbag)
select_tpb=trash_plasticbag%>%
  select(-"종량제봉투처리방식", -"종량제봉투사용대상",-"관리부서명",-"관리부서전화번호",-"데이터기준일자",
         -"제공기관코드",-"제공기관명")
group_tpb=select_tpb%>%group_by(., `시도명`, `시군구명`)%>%summarize(`20ℓ가격_avg`=mean(`20ℓ가격`))
group_tpb=filter(group_tpb, `20ℓ가격_avg`>950)
view(group_tpb)
group_tpb%>%ggplot(aes(`시군구명`, `20ℓ가격_avg`, fill=`시군구명`))+geom_bar(stat="identity")+
  scale_fill_brewer(palette="Set3")+ggtitle("20ℓ Garbage Bag\nSold for over 950won in Korea")+
  xlab("Area")+ylab("Price")+theme(plot.title=element_text(face="bold", hjust=0.5, size=20))
