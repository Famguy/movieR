library(ggvis)

df <- read.table("filmfare_mod.tsv", header = FALSE, sep="\t")
titles <- df$V1
year <- df$V2
ratings <- df$V3
mins <- df$V4
directors <- df$V5
actors <- df$V6

makexy <- function (inp) {
  dft <- cbind(inp,x=0,y=0)
  dft$x <- as.numeric(dft$x)
  dft$y <- as.numeric(dft$y)
  for (n in (1:nrow(dft))){
    quo <- (n-1)%/%5
    rem <- (n-1)%%5
    dft$x[n] <- rem
    dft$y[n] <- quo
  }
  dft$x <- as.factor(dft$x)
  dft$y <- as.factor(dft$y)
  return(dft)
}


# Creating data for distribution of mins
dfm <- df
dfm$names <- paste0(titles,";",year)
colnames(dfm)[4] <- "values"
dfm1 <- makexy(dfm[dfm$values<130,])
dfm2 <- dfm[dfm$values>=130,]
dfm2 <- makexy(dfm2[dfm2$values<160,])
dfm3 <- dfm[dfm$values<190,]
dfm3 <- makexy(dfm3[dfm3$values>=160,])
dfm4 <- makexy(dfm[dfm$values>=190,])

# Creating data for distribution of ratings
dfr <- df
dfr$names <- paste0(titles,";",year)
colnames(dfr)[3] <- "values"
dfr1 <- makexy(dfr[dfr$values<=7,])
dfr2 <- dfr[dfr$values>7,]
dfr2 <- makexy(dfr2[dfr2$values<=8,])
dfr3 <- dfr[dfr$values>8,]
dfr3 <- makexy(dfr3[dfr3$values<8.4,])
dfr4 <- makexy(dfr[dfr$value>=8.4,])

# Creating data for frequency distribution of directors
td <- table(directors)
dfd <- as.data.frame(td)
colnames(dfd)[1] <- "names"
dfd$movies <- c(" ")
for (i in 1:nrow(dfd)) {
   dname <- dfd[i, ]$names
#   print (dname)
   tpd <- paste0(df[df$V5 == dname,]$V1, " (",df[df$V5 == dname,]$V2, ")<br>" , collapse= '')
   dfd[i, ]['movies'] <- substr(tpd,1,nchar(tpd)-4)
#   print(df[i, ]['V1'])
}
dfd$names <- paste0(dfd$names,";",dfd$movies) 

# Various plots
dfd1 <- makexy(dfd[dfd$Freq==1,])
dfd2 <- makexy(dfd[dfd$Freq==2,])
dfd3 <- makexy(dfd[dfd$Freq>=3,])


# Creating data for frequency distribution of cast
names <- c()
for (i in 1:length(actors)){
  act <- toString(actors[i])
  temp <- as.vector(strsplit(act, ", ")[[1]])
  names <- c(names, temp)
}

tc <- table(names)
dft <- as.data.frame(tc)

dft$movies <- c(" ")
for (i in 1:nrow(dft)) {
  aname <- dft[i, ]$names
  tpd <- paste0(df[grepl(aname,df$V6),]$V1, " (",df[grepl(aname,df$V6),]$V2, ")<br>" , collapse= '')
  dft[i, ]['movies'] <- substr(tpd,1,nchar(tpd)-4)
  #   print(df[i, ]['V1'])
}
dft$names <- paste0(dft$names,";",dft$movies) 


# Various plots
dft1 <- makexy(dft[dft$Freq==1,])
dft2 <- makexy(dft[dft$Freq==2,])
dft3 <- makexy(dft[dft$Freq==3,])
dft4 <- makexy(dft[dft$Freq>=4,])

plotter <- function(inp,m,n){
  effvis <- (
    inp %>% 
    ggvis(~x, ~y, fill = ~Freq, key := ~names, fill.hover := "magenta") %>% 
    layer_rects(width = band(), height = band()) %>% 
    scale_nominal("x", padding = 0, points = FALSE) %>% 
    scale_nominal("y", padding = 0, points = FALSE) %>% 
    add_tooltip(function(data){
      paste0("Name: ",as.character(strsplit(data$names, ";")[[1]][1]),"<br> Movies: ", as.character(strsplit(data$names, ";")[[1]][2]), "<br> Times Won: ", as.character(data$Freq), "<br>")
    }, "hover") %>% 
    hide_axis("x") %>% hide_axis("y")) %>% hide_legend("fill") %>%
    set_options(height = 300*m, width = 300*n)
#     dft %>%
#     ggvis(~x, ~y, size := ~Freq*100, size.hover:= ~Freq*200, fill = ~Freq, key := ~names, fill.hover := "magenta") %>%
#     layer_points() %>%
#     add_tooltip(function(data){
#     paste0("Name: ", as.character(data$names), "<br> Freq: ", as.character(data$Freq), "<br>")
#     }, "hover") %>% 
#     hide_axis("x") %>% hide_axis("y")) %>% hide_legend("fill")  
    
  return (effvis)
}

altplotter <- function(inp,m,n){
  effvis <- (
    inp %>% 
      ggvis(~x, ~y, fill = ~values, key := ~names, fill.hover := "magenta") %>% 
      layer_rects(width = band(), height = band()) %>% 
      scale_nominal("x", padding = 0, points = FALSE) %>% 
      scale_nominal("y", padding = 0, points = FALSE) %>% 
      add_tooltip(function(data){
        paste0("Name: ",as.character(strsplit(data$names, ";")[[1]][1]),"<br> Year: ", as.character(strsplit(data$names, ";")[[1]][2]), "<br> Value: ", as.character(data$values), "<br>")
      }, "hover") %>% 
      hide_axis("x") %>% hide_axis("y")) %>% hide_legend("fill") %>%
    set_options(height = 300*m, width = 300*n)
  return (effvis)
}


nullplotter <- function(){
  dftnull <- data.frame(x= numeric(0), y= numeric(0))
  effvis <- (dftnull %>% 
    ggvis(~x, ~y) %>% hide_axis("x") %>% hide_axis("y") %>% 
    set_options(height = 1, width = 1))
  return (effvis)
}

# d <- density(mins)
# plot(d, type="n", main="mins")
# polygon(d, col="red", border="gray")
# 
# hist(mins, xlim=c(50, 250), breaks=seq(50, 250, 11), main="Minutes", probability=TRUE, col="gray", border="white")
# d <- density(mins)
# lines(d, col="red")

plotType <- function(type) {
  if (type == "Length"){
    hist(mins, xlim=c(50, 250), breaks=seq(50, 250, 11), main="Minutes", probability=TRUE, col="gray", border="white")
    d <- density(mins)
    lines(d, col="red")
    print(mean(mins))
  }
  else if (type == "Rating"){
    hist(ratings, xlim=c(6, 10), breaks=seq(6, 10, 0.25), main="Ratings", probability=TRUE, col="gray", border="white")
    d <- density(ratings)
    lines(d, col="red")
    print(mean(ratings))
  }
#   else if (type == "Director"){
#     barplot(table(directors))
#   }
  else {
    return (NULL)
  }
}

timeplot <- function(type){
  if (type == "Length"){
    plot(year, mins, type="o")
#    lines(year, mins)
  }
  else if (type == "Rating"){
    plot(year, ratings, type="o")
#    lines(year, ratings)
  }
  else {
    return (NULL)
  }
}  
