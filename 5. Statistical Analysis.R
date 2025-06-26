##############################################
########### 자료 처리 응용 실습 ##############
##############################################
# R을 이용한 데이터 처리 & 분석 실무(길벗)


##############################################
############### 5. Statistical Analysis  ##
##############################################

############### 1. 난수 생성 및 분포 함수  ##############

# https://www.stat.umn.edu/geyer/old/5101/rlook.html#dist

# random number (난수)를 만드려면 앞에 r을 붙인다.

rnorm (100 , 0, 10)

plot(density(rnorm(1000000, 0, 10)))

# 누적분포(cdf)는 앞에 p를 붙인다

# 분위수 (quartile)는 q를 붙인다

# 확률 밀도 (probability density)는 d를 붙인다

# 포아송 분포 

# f(n; \lambda)= lambda^n * exp(- lambda)/ (n!)

dpois(3, 1)

(1^3 * exp ( -1)) / ( factorial (3) )


# N(0, 1^2)에서 누적분포 F(0)

pnorm(0)


############### 2. Basic Statistics  ##############

# 2.1 mean, variance, standard deviation

mean(1:5)
var(1:5)
sum((1:5 - mean(1:5))^2)/(5-1)

# 2.2 five number summary

fivenum(1:11)
summary(1:11)


fivenum(1:4)
summary(1:4)

# 1st Q - 1 + (4-1)*(1/4)
# 3rd Q - 1 + (4-1)*(3/4)

# 2.3 Mode (최빈값)

x <- factor (c("a", "b", "c", "c", "c", "d", "d"))
x

table(x)

which.max(table(x))

names(table(x))[3]


############### 3. Sampling  ##############

# 3.1 단순임의 추출 (random sampling)

sample(1:10, 5)

sample(1:10, replace = TRUE)

#각각에 가중치 (weight)를 줄경우
sample (1:10 , 5, replace =TRUE , prob =1:10) 

# sample()은 주어진 데이터의 순서를 보존 X. shuffle로 사용 가능

sample(1:10)


# Stratified Random Sampling(층화 임의 추출)

# 데이터가 중첩 없이 분할 될 수 있는 경우(즉 disjoint 한 부분으로 나뉠 수 있는 경우) 그리고
# 각 분할의 성격이 명확히 다른 경우 층화 임의 추출을 수행하여 더 정확한 결과를 얻을 수 있다.
# 예를들어 남성 20%, 여성 80%로 구성된 집단이 있을 때 이 집단의 평균 키를 측정한다고
# 가정해보자. 성별에 따라 키의 차이가 명확히 존재할 것이므로 표본을 잘 추출하는 것이 무엇
# 보다 중요할 것이다. 그런데 단순 임의 추출을 적용하게되면 남성이 우연히 20%보다 더 많이
# 추출되거나 또는 20%보다 더 적게 추출될 수 있다. 다시 말해 단순 임의 추출은 평균에 대한
# 추정의 정확도가 떨어지는 위험이 있다.
# 이런 경우 층화 추출을 사용해 데이터로부터 남성과 여성의 표본의 갯수를 2:8로 유지하여
# 뽑는다면 더 정확한 결과를 얻을 수 있게된다. 또한 층화 추츨을 하게 되면 뽑힌 남성의 표본에
# 대해서도 평균 키를 측정할 수 있고, 여성의 표본에 대해서도 평균 키를 측정할 수 있게 된다.


# 층화 임의 추출은 sampling::strata() 함수를 사용한다.
# 다음 예는 iris데이터로부터 srswor(Simple Random Sampling Without Replacement. 비복원
# 단순 임의 추출)을 사용해 각 Species별로 3개씩 샘플을 추출한다. 


install.packages("sampling")
library(sampling)
x <- strata(c("Species"), size =c(3, 3, 3), method ="srswor",
            data = iris)

getdata(iris , x)

strata(c("Species"), size =c(3, 1, 1) , method ="srswr", data = iris )



# 3.3 계통 추출 (Systematic Sampling)

# 아침부터 밤까지 특정한 지역을 지나간 차량의 번호를 모두 조사하였고, 이들로부터 조사 대
# 상을 뽑는 경우를 가정해보자. 가장 간단한 단순 임의 추출을 적용하여 차량 번호를 뽑는다면
# 우연히 아침시간에 지나간 차량을 더 많이 뽑거나 저녁시간에 지나간 차량을 더 많이 뽑는
# 편향이 발생할 수 있다. 계통추출은 이런 상황에서 해답이 될 수 있다.
# 계통 추출은 모집단의 임의 위치에서 시작해 매 k 번째 항목을 표본으로 추출하는 방법이
# 다. 예를들어 1, 2, 3, ..., 10까지의 수에서 3개의 샘플을 뽑는다고 가정해보자. 10/3 = 3.333...
# 이므로 k = 3이다. 표본 추출 시작위치를 잡기위해 1 ∼ k 사이의 수 하나를 뽑는다. 이 수가
# 2라하자. 나머지 두 수를 뽑기위해 2 + k 에 해당하는 5를 뽑는다. 다음, 5 + k에 해당하는 8을
# 뽑는다. 그러면 최종적으로 표본 ‘2, 5, 8’를 얻는다.

install.packages("doBy")
library(doBy)
x <- data.frame(x = 1:10)

x

doBy::sampleBy( ~1, frac =.3 , data =x, systematic = TRUE)


############### 4. 적합도 검정 (Goodness of Fit)  ##############

# 통계 분석에서는 종종 데이터가 특정 분포를 따름을 가정. 특히 데이터의 크기가 일정 수
# 이상이라면 데이터가 정규성을 따름을 가정하기도 하지만 실제 검정을 해 볼 수도 있음

# 5.1 Chi-Square test

# survey 데이터를 사용해 글씨를을 왼손으로 쓰는 사람과 오른손으로 쓰는 사람의 비율이
# 30% : 70%인지의 여부를 분석해보자. 
# 귀무가설(H0)은 분할표에 주어진 관측 데이터가 주어진 분포를 따른다는 것이다.

library(MASS)
data(survey)
table(survey$W.Hnd)

chisq.test(table(survey$W.Hnd), p=c(.3 , .7))


# 5.2 Shapiro-Wilk Test

# 표본이 정규분포로 부터 추출된 것인지 테스트하기 위한 방법

shapiro.test(rnorm(1000))

# 5.3 Kolmogorov-Smirnov Test

# 비모수 검정(Nonparameteric Test)으로 경험적 분포함수(Empirical Distribution Function)와 비교대상이 되는 분포의 누적분포함수(Cumulative
# Distribution Function)간의 최대 거리를 통계량으로 사용

# 귀무가설로 ‘주어진 두 데이터가 동일한 분포로부터 추출된 표본이다’를 놓고 검정하는 예이다

ks.test(rnorm(100), rnorm(100))


ks.test(rnorm(100), runif(100))


ks.test(rnorm(1000), "pnorm", 0, 1)


# Q-Q plot

# 자료가 특정 분포를 따르는지를 시각적으로 검토하기위해 Q-Q Plot을 사용

x <- rnorm (1000 , mean =10 , sd =1)
qqnorm(x)
qqline(x, lty = 1)

x <- rcauchy (1000)
qqnorm(x)
qqline(x, lty = 1)


############### 6. Correlation (상관계수)  ##############

# 상관계수는 두 확률 변수 사이의 관계를 파악하는 방식으로, 흔히 상관계수라고하면 피어슨
# 상관계수를 뜻한다.

# 중요! 상관 계수 값이 크면 데이터간의 연관 관계가 존재한다는 의미이다. 그러나 이것이 반드시
# 인과관계를 뜻하는 것은 아니다.

# 6.1 피어슨 상관계수 (Pearson Correlation Coefficient)

# 피어슨 상관계수는 [-1, 1] 사이의 값을 가진다. 0보다 큰 상관 계수 값은 한 변수가 커지면 다른
# 변수도 큰 값을 갖게 됨을 뜻하고, 음의 상관계수는 한 변수가 커지면 다른 변수가 작은 값을
# 갖게 됨을 뜻한다. 피어슨 상관계수는 선형 관계를 판단한다.


cor(iris$Sepal.Width, iris$Sepal.Length )

# Species 제외한 모든 열의 피어슨 상관 계수
cor(iris[ ,1:4])


# symnum()

symnum(cor(iris[ ,1:4]))

# corrgram 패키지

install.packages("corrgram")
library(corrgram)
corrgram(cor(iris[ ,1:4]), type ="corr",upper.panel = panel.conf)


# 6.2 Spearman's Rank Correlation Coefficient

# 상관계수를 계산할 두 데이터의 실제값 대신 두 값의 순위를 사용해
# 상관계수를 비교하는 방식
# 계산 방법이 피어슨 상관계수와 유사해 이해가 쉽고, 피어슨
# 상관계수와 달리 비선형 관계의 연관성을 파악할 수 있다는 장점

# 순위만 매길수 있다면 적용이 가능하므로 연속형(Continous) 데이터에 
# 적합한 피어슨 상관계수와 달리 이산형(Discrete) 데이터, 순서형(Ordinal) 
# 데이터에 적용이 가능


x <- c(3, 4, 5, 3, 2, 1, 7, 5)
rank(sort(x))

m <- matrix(c(1:10, (1:10)^2) , ncol =2)

install.packages("Hmisc")
library(Hmisc)

rcorr(m, type ="pearson")$r
rcorr(m, type ="spearman")$r


# 6.3 Kendal's Rank Correlation Coefficient

# 켄달의 순위 상관 계수는 (X, Y ) 형태의 순서쌍으로 데이터가 있을 때 xi < xj , yi < yj가
# 성립하면 concordant, xi < xj 이지만 yi > yj이면 discordant라고 정의한다. 즉, x가 클 때 y도
# 크면 concordant, x가 크지만 y는 작다면 discordant로 보는 것이다.

install.packages("Kendall")
library(Kendall)

Kendall(c(1, 2, 3, 4, 5) , c(1, 0, 3, 4, 5))

# 6.4 상관 계수 검정 (Corrleation Test)

# H0 : 상관계수가 0이다

cor.test(c(1, 2, 3, 4, 5) , c(1, 0, 3, 4, 5) , method ="pearson")

cor.test(c(1, 2, 3, 4, 5) , c(1, 0, 3, 4, 5) , method ="spearman")

cor.test(c(1, 2, 3, 4, 5) , c(1, 0, 3, 4, 5) , method ="kendall")


############### 7. 추정 및 검정  ##############

# 7.1 일표본 평균 (1-sample t/z-test)

# 한 표본(sample)의 평균으로 모평균 추정

x <- rnorm (30)
t.test (x)

x <- rnorm (30 , mean =10)
t.test (x, mu =10)



# 7.2 독립 이표본 평균 (2-sample t-test)

# 서로 독립인 두표본에서 두 평균의 값을 이용하여 두 모평균이 같은지 다른지 비교.
# 또한 여기서 모분산들이 같은지도 비교할 수 있다.

sleep
sleep2 <- sleep [, -3]
sleep2


tapply(sleep2$extra, sleep2$group, mean)

# 모분산이 같은지 먼저 검정

var.test(extra ~ group, sleep2)

t.test(extra ~ group, data = sleep2, paired =FALSE, var.equal = TRUE)


# 7.3 짝지은 이표본 평균 (Paired t-test)

# 짝지은 이표본은 두 개 표본이 짝지은 순서쌍처럼 구해진 경우이다. 
# 예를들어 다이어트 약의 효과를 보기 위해 50 명의 표본을 조사하는데 i 번째 사람에 대해 
# Xi에는 약물 섭취전의 체중, Yi에는 약물 섭취 후의 체중을 측정해 (Xi, Yi) 형태로 
# 기록했다면 짝지은 이표본에 해당한다.

with(sleep, t.test(extra[group ==1], extra[group ==2], paired = TRUE))

