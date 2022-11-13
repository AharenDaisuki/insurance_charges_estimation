source('CleanData.R')
source('ModelingMLE.R')
source('PlotUtils.R')
source('LinearRegDiag.R')

library(ggplot2)

# clean data
data = cleanData("/Users/lixiaoyang/insurance_charges_estimation/insurance.csv"); # modify file path name here
nonsmokerData = subset.data.frame(data, smoker == 'no');
smokerData = subset.data.frame(data, smoker == 'yes');

# gamma modeling
nsParams = fitGamma(nonsmokerData$charges);
print(nsParams);

sParams = fitGamma(smokerData$charges);
print(sParams);

# distribution
par(mfrow = c(1, 2));
pltGammaMetrics(nonsmokerData$charges, 'nonsmoker', nsParams, 20);
pltGammaMetrics(smokerData$charges, 'smoker', sParams, 15)

## bmi ~ charges

## ages ~ charges

# nonsmoker
# before
orig = linearReg(nonsmokerData$age, nonsmokerData$charges, 'age', 'charges', 'nonsmoker', c(0, 35000))
summary(orig)
confint(orig, level = 0.95)
# remove bad leverage
nonsmokerDataClean = cleanBadLeverage(orig, nonsmokerData)
# print(nrow(nonsmokerDataClean))
# after
curr = linearReg(nonsmokerDataClean$age, nonsmokerDataClean$charges, 'age', 'charges', 'nonsmoker', c(0, 35000))
summary(curr)
confint(curr, level = 0.95)

#res = rstandard(curr)
#print(res)
#plot(nonsmokerDataClean$age, res, xlab = 'age', ylab = 'residual', ylim = c(-2, 2))

# smoker
origS = linearReg(smokerData$age, smokerData$charges, 'age', 'charges', 'smoker', c(0, 50000))
summary(origS)
confint(origS, level = 0.95)
# remove bad leverage
smokerDataClean = cleanBadLeverage(origS, smokerData)
# print(nrow(smokerDataClean))
# before
currS = linearReg(smokerDataClean$age, smokerDataClean$charges, 'age', 'charges', 'smoker', c(0, 35000))
summary(currS)
confint(currS, level = 0.95)

# res = rstandard(curr)
# print(res)
# plot(smokerDataClean$age, res, xlab = 'age', ylab = 'residual', ylim = c(-2, 2))