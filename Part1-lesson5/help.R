#导入相关的模块
library("maps");
library("mapdata");
library("maptools");

#一些有用的函数
getColor=function(mapdata,provname,provcol,othercol)
{
  f=function(x,y) ifelse(x %in% y,which(y==x),0);
  colIndex=sapply(mapdata$NAME,f,provname);
  fg=c(othercol,provcol)[colIndex+1];
  return(fg);
}

#读取中国地图的外形数据
chinamap <- readShapePoly(fn="./data/bou2_4p.shp");

#读取用户自定义人口数据
chinapop <- read.csv(file="./data/pop.csv", header=T);

#对个别省市设置颜色并在地图上进行显示

#--------------------------------------------------------------

#绘制中国各省市人口分布热图
provname=chinapop$provname;
provpop=chinapop$population;

#构建人口数量对应的颜色条，越红人口越多，越绿人口越少
provcol=rgb(red=1-provpop/max(provpop)/2,green=1-provpop/max(provpop)/2,blue=0);
