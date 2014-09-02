#global setting of online ESM 

# read the pwd information file
username.pwd <- read.table("./commonData/pwd.txt", header=T);
rownames(username.pwd) <- username.pwd[,1];

#-----------------------------
#function: checkUser 
#parameters: user, pwd
#return: isValid 0: false 1: true
#-----------------------------

checkUser <- function(user, pwd)
{
    isValid <- 0;
    
    if (is.null(user) || is.null(pwd))
    {
        isValid <- 0;
        return(isValid);
    }
    
    if (is.na(username.pwd[user, 2]))
    {
        isValid <- 0;
    }else if (username.pwd[user, 2] != pwd)
    {
        isValid <- 0;
    }else
    {
        isValid <- 1;
    }
    return(isValid);
}

#----------------------------------
#function: convert2Rij
#parameters: data.frame contain raw stock price
#return: data.frame contains Rij
#----------------------------------
convert2Rij <- function(rawdata, xcol=2, ycol=3){
    rawdatadims <- dim(rawdata);
    convertdata <- data.frame();
    for (i in 2:rawdatadims[1])
    {
        convertdata[i-1,1] <- rawdata[i,1];
        convertdata[i-1,2] <- log(rawdata[i,xcol] / rawdata[i-1,xcol])*100;
        convertdata[i-1,3] <- log(rawdata[i,ycol] / rawdata[i-1,ycol])*100;
    }
    names(convertdata) <- c("Date", "Market", "Company");
    return(convertdata);
}
