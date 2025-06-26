##############################################
########### 자료 처리 응용 실습 ##############
##############################################
# R을 이용한 데이터 처리 & 분석 실무(길벗)


############## 1. Iris Data #################
# Species: 붓꽃의 종. setosa, versicolor, virginica의 세가지 값중 하나를 저장한 범주형 변 수.
# Sepal.Width: 꽃받침의 너비. Number 변수.
# Sepal.Length: 꽃받침의 길이. Number 변수.
# Petal.Width: 꽃잎의 너비. Number 변수.
# Petal.Length: 꽃잎의 길이. Number 변수.

head(iris)
str(iris)

head(iris3)

# 데이터 셋 목록 보기

library(help=datasets)

data(mtcars)

############## 2. 파일 입출력 ################

# 2.1 CSV 파일 입출력
# read.csv()를 사용

setwd("/Users/kyungminahn/Dropbox/KMU/자료처리응용실습")
x <- read.csv("a.csv", header = FALSE)
x <- read.csv("a.csv", header = TRUE)

str(x)

x <- read.csv("b.csv")
names(x) <- c("id", "name", "score")
str(x)

x <- read.csv("c.csv")
str(x)
x <- read.csv("c.csv", na.strings = c("NIL"))
x
is.na(x$score)

# 데이터를 파일로 저장하기
write.csv(x, 'd.csv', row.names = F)

########### 3. save(), load() ###############
# 데이터를 다양한 알고리즘으로 처리한뒤 저장할 피요가 있을시
# R 객채를 그대로 파일로 저장 할수 있음

x <- 1:5 
y <- 6:10
save(x, y, file="xy.RData")

rm(list=ls())

load("xy.RData")


################ 4. rbind(), cbind() ###########
# 각각 행 또는 열 형태로 주어진 데이터를 합쳐서 행렬 또는
# 데이터 프레임을 만드는데 사용

rbind(c(1, 2, 3), c(4, 5, 6))


x <- data.frame(id=c(1, 2), name=c("a", "b"))
x

y <- rbind(x, c(3, "c"))
y

cbind(c(1, 2, 3), c(4, 5, 6))

y <- cbind(x, greek=c('alpha', 'beta'))
y
str(y)

################# 5. Apply 함수 ##############
# 다양한 벡터 또는 행렬데이터에 임의의 함수를 적용한 결과를 얻기 휘한 함수

# apply()
# 행렬의 행 또는 열방향으로 특정함수를 적용하는데 사용
# apply(행렬, 방향, 함수) 형태로 호출
# 행렬: 1 => 행, 행렬: 2 => 열


sum(1:10)
d <- matrix(1:9, ncol= 3)
apply(d, 1, sum)
apply(d, 2, sum)

head(iris)
apply(iris[, 1:4], 2, sum)

colSums(iris[, 1:4])
rowSums(iris[, 1:4])


############# 6. Split ################

# 데이터를 분리하는데 사용
# split(데이터, 분리조건)

split(iris, iris$Species)


############ 7. subset() #################

# split()과 유사하지만 전체를 부분으로 구분하는 대신 특정 부분만 
#취하는 용도로 사용

subset(iris, Species == "setosa")

subset(iris, Species == "setosa" & Sepal.Length > 5.0)

subset(iris, select=c(Sepal.Length, Species))

subset(iris, select=-c(Sepal.Length, Species))


######### 8.merge() ########################

# 두 데이터 프레임을 공통된 값을 기준으로 묶는 함수

x <- data.frame(name=c("a", "b", "c"), math=c(1, 2, 3))
y <- data.frame(name=c("c", "b", "a"), english=c(4, 5, 6))

merge(x, y)

# cbind() 와 다름. cbind()는 단순히 열을 합침

cbind(x, y)


############## 9. sort(), order() ###########

x <- c(20, 11, 33, 50, 47)

sort(x)
sort(x, decreasing=TRUE)

order(x)
#x[order(x)]

order(-x)

head(iris[order(iris$Sepal.Length), ])
head(iris[order(iris$Sepal.Length , iris$Petal.Length), ])


############ 10. with(), whithin() ##########

# with()는 데이터 프레임 또는 리스트 내 필드를 손쉽게 
# 접근하기 위한 함수

print(mean(iris$Sepal.Length))
print(mean(iris$Sepal.Width))

with(iris, c(mean(Sepal.Length),  mean(Sepal.Width)))

# within()은 데이터를 수정하는데 사용

x <- data.frame(val=c(1, 2, 3, 4, NA, 5, NA))
x
x <- within(x, { val <- ifelse(is.na(val), median(val, na.rm=TRUE), val) })
x

############ 11. attach(), detach() ##########

# attach()는 인자로 주어진 데이터 프레임이나라 리스트를 곧바로 접근 가능하게 해줌

Sepal.Width
attach(iris)
head(Sepal.Width)

detach(iris)
Sepal.Width

# 주의: attach()한 변수값은 detach()시 원래의 데이터 프레임에는 반영 되지 않음

data(iris)
head(iris)

attach(iris)
Sepal.Width[1] = -1
Sepal.Width

detach(iris)
head(iris)

############ 12. which() #################

# 벡터 또는 배열에서 주어진 조건을 만족하는 값이 있는곳의 색인 (index)를 찾음

x <- c(2, 4, 6, 7, 10)
x %% 2
which(x %%2 ==0)

x[which(x %% 2 == 0)]

# which.min() 과 which.max()는 주어진 벡터에서 최소 또는 최대값이 저장된 색인을 찾는 함수

which.min(x)
x[which.min(x)]

which.max(x)
x[which.max(x)]


############ 13. aggregate() #################

# 일반적인 그룹별 연산을 위한 함수
aggregate(Sepal.Width ~ Species, iris, mean)
