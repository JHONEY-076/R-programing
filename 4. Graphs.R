##############################################
########### 자료 처리 응용 실습 ##############
##############################################
# R을 이용한 데이터 처리 & 분석 실무(길벗)


##############################################
############### Graph ########################
##############################################

############### 1. Scatter Plot ##############

# 산점도는 주어진 데이터를 점으로 표시해 흩뿌리듯이 시각화한 그림
# R에서 산점도는 plot() 함수로 그리는데, plot()은 산점도 뿐만 아니라 일반적으로 객체를 시각화하는데 모두
# 사용될 수 있는일반 함수(Generic Function)

methods("plot")


install.packages("mlbench")
library ( mlbench )
data ( Ozone )
Ozone
plot ( Ozone $V8 , Ozone $V9)





# plot은 (x, y)의 순서로 입력을 받으며, x와 y가 숫자형 데이터의 경우 산점도를 그려줌

############### 2. 그래프 옵션 ##############

?par

# 2.1 축 이름 (xlab, ylab)

plot ( Ozone $V8 , Ozone $V9 , xlab =" Sandburg Temperature ", ylab ="El Monte Temperature ")


# 2.2 그래프 제목 (main)

plot ( Ozone $V8 , Ozone $V9 , xlab =" Sandburg Temperature ", ylab ="El Monte Temperature ", main =" Ozone ")


# 2.3 점의 종류 (pch)

plot ( Ozone $V8 , Ozone $V9 , xlab =" Sandburg Temperature ", ylab ="El Monte Temperature ", main =" Ozone ", pch =20) 

plot ( Ozone $V8 , Ozone $V9 , xlab =" Sandburg Temperature ", ylab ="El Monte Temperature ", main =" Ozone ", pch="+")

# google r pch symbol 로 확인



# 2.4 점의 크기 (cex)

plot ( Ozone $V8 , Ozone $V9 , xlab =" Sandburg Temperature ", ylab ="El Monte Temperature ", main =" Ozone ", cex=1)



# 2.4 색상 (col)

colors()
plot ( Ozone $V8 , Ozone $V9 , xlab =" Sandburg Temperature ", ylab ="El Monte Temperature ", main =" Ozone ", col="red ")


# 2.6 좌표측 값의 범위 (xlim, ylim)

plot ( Ozone $V8 , Ozone $V9 , xlab =" Sandburg Temperature ", ylab ="El Monte Temperature ", main =" Ozone ")

max(Ozone$V8)
max( Ozone $V8 , na.rm = TRUE )
max( Ozone $V9 , na.rm = TRUE )

plot ( Ozone $V8 , Ozone $V9 , xlab =" Sandburg Temperature ",
       ylab ="El Monte Temperature ", main =" Ozone ",
       xlim =c(0, 100) , ylim =c(0, 90))

# 2.7 type

# cars 데이터는 차량이 달리던 속도, 그리고 그 속도에서 브레이크를 잡았을때 제동거리를 측정한 데이터

data(cars)
str(cars)
head(cars)
plot(cars)

plot (cars , type ="l")
plot (cars , type ="o", cex =1)

# 주행속도에 대해 두개 이상의 제동거리가 있는 경우가 많아
# 어색해보임. 이 문제를 해결하기 위해 tapply를 사용

tapply ( cars $dist , cars $ speed , mean )
plot ( tapply ( cars $dist , cars $ speed , mean ), type ="o", cex =0.5 ,
        xlab =" speed ", ylab =" dist ")

############### 3. 그래프의 배열 (mfrow) ############

#mfrow를 지정하면 한 창에 여러개의 그래프를 나열

opar <- par( mfrow =c(1, 2))
plot ( Ozone $V8 , Ozone $V9 , xlab =" Sandburg Temperature ",
       ylab ="El Monte Temperature ", main =" Ozone ")
plot ( Ozone $V8 , Ozone $V9 , xlab =" Sandburg Temperature ",
       ylab ="El Monte Temperature ", main =" Ozone2 ")
par(opar)


## 자주 쓰는 그래프 분할 
par( mfrow =c(4, 4)) # 행렬

plot ( Ozone $V8 , Ozone $V9 , xlab =" Sandburg Temperature ",
       ylab ="El Monte Temperature ", main =" Ozone ")
plot ( Ozone $V8 , Ozone $V9 , xlab =" Sandburg Temperature ",
       ylab ="El Monte Temperature ", main =" Ozone2 ")
dev.off()


############### 4. 지터 (jitter) ##################

# Ozone데이터의 V6와 V7은 각각 LAX에서의 풍속과 습도를 담고 있다. 그런데 이 둘은 자연
# 수로 표시되므로 값이 같은 경우가 많다.

head(Ozone)


# (V6, V7)의 순서쌍을 좌표평면에 도시하면 여러 점들이 한 위치에 표시
# 되어 서로 구분이 잘 되지 않는다. Jitter는 데이터 값을 조금씩 움직여서 같은 점에 데이터가
# 여러번 겹쳐서 표시되는 현상을 막는다

plot ( Ozone $V6 , Ozone $V7 , xlab =" Windspeed ", ylab =" Humidity ",
       main =" Ozone ", pch =20 , cex=.5)
plot ( jitter(Ozone $V6) , jitter(Ozone $V7) , xlab =" Windspeed ", ylab =" Humidity ",
       main =" Ozone ", pch =20 , cex=.5)


############### 5. 점 (points) ####################

plot ( iris $ Sepal.Width , iris $ Sepal.Length , cex =1 , pch =20 ,
      xlab =" width ", ylab =" length ", main =" iris ")

## 한 그래프에 데이터를 겹쳐서 쓰고 싶은 경우
points ( iris $ Petal.Width , iris $ Petal.Length , cex =1 ,
           pch="+", col="red ")



############### 6. 선 (lines) ###################

x <- seq (0, 2*pi , 0.1)
y <- sin(x)
plot (x, y, cex=.5 , col ="red ")
lines (x, y)


# <생략> 
# LOWESS (locally estimated scatterplot smoothing)를 적용
# 데이터의 각점에서 inear model(y = ax + b) 또는 quadratic model(y = ax2 + bx + c)을 각각
# 적합하되, 각 점에서 가까운 데이터에 많은 weight를 주면서 regression을 수행

data(cars)
head(cars)
plot(cars)
lines(lowess(cars))

############### 7. 직선 (abline) ###################

# y= a + bx 형태의 직선, 또는 y = h 형태의 가로로 그은 직선, 또는 x = v 형태의
# 세로로 그은 직선을 그래프에 그린다

plot (cars , xlim =c(0, 25) )
abline (a=-5, b=3.5 , col ="red ") # dist = -5 + 3.5*speed


plot (cars , xlim =c(0, 25) )
abline (a=-5, b=3.5 , col ="red ")
abline (h= mean ( cars $ dist ), lty =2, col=" blue ")
abline (v= mean ( cars $ speed ), lty =2, col=" green ")
abline(h=100)
abline(v=5)
############### 8. 곡선 (curve) ###################

curve(sin, 0, 2*pi)


############### 9. 문자열 (text) ###################

# text()는 그래프에 문자를 그리는데 사용하며 형식은 text(x, y, labels)이다. labels는 각 좌표에
# 표시할 문자들이며, text()함수에는 보여질 텍스트의 위치를 조정하기위한 다양한 옵션이 있다.

plot (cars , cex=.5)
text ( cars $ speed , cars $dist , pos =3, cex =.5)


####### 10. 그래프상에 그려진 데이터 식별 ############

# identify()는 그래프상에서 특정 점을 클릭하면 클릭된 점과 가장 가까운 데이터를 그려줌

plot (cars , cex=.5)
identify ( cars $ speed , cars $ dist )

############### 11. 범례 (legend) ###################

plot ( iris $ Sepal.Width , iris $ Sepal.Length , cex =1 , pch =20 ,
       xlab =" width ", ylab =" length ")
points ( iris $ Petal.Width , iris $ Petal.Length , cex =1 ,
         pch="+", col="red ")

legend ("topright", legend =c(" Sepal ", " Petal "),
        pch=c(20 , 43) , cex=1 , col=c(" black ", "red"), bg=" gray ")



########## 12. matplot, matlines, matpoints #############

# 행렬 형태로 주어진 데이터를 그래프에 그림

x <- seq (-2*pi , 2*pi , 0.01 )

y <- matrix (c( cos (x), sin (x)), ncol =2)

plot (x, y, col=c(" red ", " black "), cex =.2)
matplot (x, y, col=c(" red ", " black "), cex =.2)
abline(h=0, v=0)


########### 13. Boxplot (상자그림) ##################
# Range(R)=max-min
#IQR= Q3-Q1
#UF= Q3+1.5*IQR
#LF=Q1-1.5*IQR



boxplot ( iris $ Sepal.Width )


boxstats <- boxplot ( iris $ Sepal.Width )
boxstats

boxstats <- boxplot ( iris $ Sepal.Width , horizontal = TRUE )
text ( boxstats $out , rep (1, NROW ( boxstats $ out )), labels = boxstats $out ,
       pos =1, cex=.5)

############ 14. Histogram ########################

hist ( iris $ Sepal.Width )

hist ( iris $ Sepal.Width , freq = FALSE )


############ 15. Density (밀도) ###################

plot ( density ( iris $ Sepal.Width ))


hist ( iris $ Sepal.Width , freq = FALSE )
lines ( density ( iris $ Sepal.Width ))


############ 16. barplot (막대) ###################

## 히스토그램과 barplot의 차이점: 히스토그램은 범주형 데이터 barplot은 비범주형 데이터 

barplot ( tapply ( iris $ Sepal.Width , iris $ Species , mean ))


############ 17. Mosaicplot (모자이크) ##########

# 범주형 다변량 데이터를 표현하는데 적합한 그래프

str( Titanic )
head(Titanic)

mosaicplot ( Titanic , color = TRUE )
mosaicplot (~ Class + Survived , data = Titanic , color = TRUE )

########### 18. 산점도 행렬(pairs) #################

#산점도 행렬(Scatter Plot Matrix)은 다변량 데이터에서 변수 쌍간의 산점도 행렬을 그린 그래프

pairs(~ Sepal.Width + Sepal.Length + Petal.Width + Petal.Length ,
      data =iris , col=c("red", " green ", " blue ")[ iris $ Species ])
