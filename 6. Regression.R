##############################################
########### 자료 처리 응용 실습 ##############
##############################################
# R을 이용한 데이터 처리 & 분석 실무(길벗)


###################################################################
############### 6. Linear Regression Model #######################
###################################################################

############### 1. 단순선형회귀 (Simple Linear Regression)  ##############

#y=f(x)+error

#f(x): 예측변수= 설명변수 = 독립변수 
#y: 반응 변수, 종속 변수


# 선형 회귀는 독립변수와 종속 변수간의 관계를 모델링하는 기법
# 머신러닝에서 예측 모델링 중 가장 기초가 되는 모델
# 이때 독립변수가 하나이면 단순 (Simple) 선형 회귀라고 하고 2개 이상이면
# 다중 (multiple) 다중 선형 회귀라고 한다.

# 기본적인 모델은
# y_i = \beta_0 + \beta_1 X_{1, 1} + ... + \beta_p X_{i,p} + \epsilon_i
# 



# 선형호귀 모형은 다음과 같은 전제가 따른다

# 1. 독립변수 X는 고정된 값
# 2. 오차항의 분산이 동일
# 3. 오차항간 상호 독립
# 4. 오차항은 평균이 0이며 분산은 \sigma^2인 정규 분포를 따른다
# 5. 독립변수간 독립이다


# 1.1 모델 생성

data(cars)
head(cars)

# 모델링: dist = \beta_0 + speed X \beta_1 + \epsilon

m <- lm(dist ~ speed, cars)  
m


summary(m)

# 1.2 예측 (fitted values)

fitted(m)[1:4]


# 1.3 잔차 (residual)
# 예측값과 실제 값의 차이

residuals(m)[1:4]

# fitted(m) + residuals(m)은 cars$dist와 같음

fitted(m)[1:4] + residuals(m)[1:4]
cars$dist[1:4]

# 1.3 예측과 신뢰구간

predict(m, newdata = data.frame(speed = 3))


# 한 표본(sample)의 평균으로 모평균 추정


# 1.4 모형 평가

summary(m)
# R-squred:  평가

plot(m)



set.seed(123)
split= initial_split(ames,pro=0.7,
                     strata="Sale_price")

ames_train=training(split)
ames_test=testing(split)



























