##############################################
########### 자료 처리 응용 실습 ##############
##############################################
# R을 이용한 데이터 처리 & 분석 실무(길벗)


################# 1. IF, FOR, WHILE ####################

# If Statement
#IF라는 statement가 주어지면 참(TRUE)일때 실행,
#거짓 (FALSE)이면 실행 안함


#if (test_expression) {
#  statement
#}

x <- -3
if(x > 0){
  print("Positive number")
}

x=2
if(x%%2==0){
  print("Even number")
}

  

# Else
# If에서 참이 아닐경우 실행하는 statement


#if (test_expression) {
#  statement1
#} else {
#  statement2
#}

if ( TRUE ) {
  print ('TRUE ')
  print ('hello ')
} else {
  print ('FALSE ')
  print ('world ')
}


x=2
if(x%%2==0){
  print("짝수")
}else{
  print("홀수")
}


x <- -5
if(x > 0){
  print("Non-negative number")
} else {
  print("Negative number")
}


# ifelse

#if문을 다수의 데이터에 한번에 적용하는 연산가능

x <- c(1, 2, 3, 4, 5)
ifelse(x %% 2 == 0, "even", "odd")


# 반복문

# for, while이 있다

# for statement
# for (i in data){
# i를 사용한 문장
#}

#데이터에 들어있는 각각의 값을 변수 i에 할당하면서 각각에
# 대해 블록안의 문장을 수행


for (i in 1:10) {
  print(i)
}

x = c(1, 5, 10, 20, 30, 100, 200)
for (i in 1:length(x)){
  print(x[i])
}

x <- c(2,5,3,9,8,11,6)
count <- 0
for (val in x) {
  if(val %% 2 == 0)  count = count+1
}
print(count)


# while statement

#while (cond){
# 조건이 참일때 수행할 문장
#}

# 조건 cond참일 때 블록안의 문장을 수행

i <- 0
while (i < 10) {
   print (i)
   i <- i + 1
}

i <- 1
while (i < 6) {
  print(i)
  i = i+1
}

# next
# while문의 처음으로 들어감

i <- 0

while (i <=9){
  i <- i+1
  if (i %%2 !=0){
    next
  }
  print(i)
}


################# 2. 연산 ####################

# 2.1 수치연산 
# +, -, *, /
# n %% m
# n %/% m
# n^m
# exp(n)
# log(x)
# sin(x), cos(x), tan(x)

1:5 * 2 + 1


# 2.2. 벡터 연산
# 벡터 또는 리스트를 한번에 연산하는것
# 벡터연산은 for문과 달리 벡터나 리스트를 한번에 처리하는 것이 가능

x <- c(1, 2, 3, 4, 5)
x + 1

# 벡터 연산 가능

x <- c(1, 2, 3, 4, 5)
x + x
x == x
x == c(1, 2, 3, 5, 5)
c(T, T, T) & c(T, F, T)

# R은 벡터 기반 연산 지원

x <- c(1, 2, 3, 4, 5)
sum(x)
mean(x)
median(x)
sd(x)

# 벡터 연산을 사용하면 데이터 프레임에 저장된 데이터 중
# 원하는 정보를 쉽게 얻을수 있음

d <- data.frame(x = c(1, 2, 3, 4, 5), 
                y =c("a", "b", "c", "d", "e"))
d

d[c(TRUE, FALSE, TRUE, FALSE, TRUE),]

# TIP! 짝수인 행만 선택하는 경우
d[d$x %% 2 == 0,]

# 2.3 NA 처리

# 결측치가 데이터에 포함되어 있을 경우 연산결과가 다음과 같이 
# NA로 바뀌어버리므로 주의가 필요

NA & TRUE
NA + 1

# 문제점을 해결하기위해 많은 R 함수들이 na.rm 인자를 받는다. na.rm 은 NA값이
# 있을때 해당값을 제거할 것인지를 지정하기 위한 목적

sum(c(1, 2, 3, NA))

sum(c(1, 2, 3, NA), na.rm =T)

################# 3. 함수 ####################

# 4.1 정의
# 코드의 반복을 줄이거나 코드의 가독성을 높이기 위해 작성
# function_name <- function(, , ){
# 함수 본문
# return(반환값)
#}

# 피보나치 수열 1  1   2   3   5  8
fibo <- function (n) {
  if (n == 1 || n == 2) {
    return (1)
  }
  return(fibo(n - 1) + fibo(n - 2))
}

fibo(5)
fibo(6)

# tip

fibo <- function (n) {
  if (n == 1 || n == 2) {
    1
  } else {
    fibo (n - 1) + fibo (n - 2)
  }
}

fibo(6)


# 함수를 호출할때는 인자의 위치를 맞춰서 값을 넘겨주는 방식, 
# 또는 인자의 이름을 명명해서 넘겨주는 방식 두가지가 모두 가능 

f <- function (x, y) {
  print (x)
  print (y)
}

f(1, 2)
f(y=1, x=2)

# 4.2 가변 길이 인자
# R의 함수들의 도움말을 살펴보면 ‘...’를 인자 목록에 적은 경우를 종종 볼수 있음
# 이는 임의의 인자들을 받아서 다른 함수에 넘겨주는 용도로 주로 사용

f <- function(x, y) {
  print (x)
  print (y)
}
g <- function(z, ... ) {
  print (z)
  f(...)
}

g(1, 2, 3)



# 객체를 삭제 하고 싶을때
?rm
?ls

rm( list =ls ())
f <- function () {
  print (x)
}
f()

