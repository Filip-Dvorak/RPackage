\name{t.test}
\alias{t.test}
\title{Student's t-Test}
\description{
Performs one and two sample t-tests on vectors of data.
}
\usage{
t.test(x, ...)

\method{t.test}{default}(x, y = NULL,
       alternative = c("two.sided", "less", "greater"),
       mu = 0, paired = FALSE, var.equal = FALSE,
       conf.level = 0.95, ...)

\method{t.test}{formula}(formula, data, subset, na.action, ...)
}
\arguments{
  \item{x}{A (non-empty) numeric vector of data values.}
  \item{y}{An optional (non-empty) numeric vector of data values.}
  \item{alternative}{A character string specifying the alternative hypothesis, must be one of \code{"two.sided"} (default), \code{"greater"} or \code{"less"}. You can specify just the initial letter.}
  \item{mu}{A number indicating the true value of the mean (or difference in means if you are performing a two sample test).}
  \item{paired}{A logical indicating whether you want a paired t-test.}
  \item{var.equal}{A logical variable indicating whether to treat the two variances as being equal. If \code{TRUE} then the pooled variance is used to estimate the variance otherwise the Welch (or Satterthwaite) approximation to the degrees of freedom is used.}
  \item{conf.level}{Confidence level of the interval.}
  \item{formula}{A formula of the form \code{lhs ~ rhs} where \code{lhs} is a numeric variable giving the data values and \code{rhs} either 1 for a one-sample or paired test or a factor with two levels giving the corresponding groups. If \code{lhs} is of class \code{"Pair"} and \code{rhs} is 1, a paired test is done.}
  \item{data}{An optional matrix or data frame (or similar: see \code{model.frame}) containing the variables in the formula \code{formula}. By default the variables are taken from \code{environment(formula)}.}
  \item{subset}{An optional vector specifying a subset of observations to be used.}
  \item{na.action}{A function which indicates what should happen when the data contain NAs. Defaults to \code{getOption("na.action")}.}
  \item{...}{Further arguments to be passed to or from methods.}
}
\details{
\code{alternative = "greater"} is the alternative that \code{x} has a larger mean than \code{y}. For the one-sample case: that the mean is positive.

If \code{paired} is \code{TRUE} then both \code{x} and \code{y} must be specified and they must be the same length. Missing values are silently removed (in pairs if \code{paired} is \code{TRUE}). If \code{var.equal} is \code{TRUE} then the pooled estimate of the variance is used. By default, if \code{var.equal} is \code{FALSE} then the variance is estimated separately for both groups and the Welch modification to the degrees of freedom is used.

If the input data are effectively constant (compared to the larger of the two means) an error is generated.
}
\value{
A list with class \code{"htest"} containing the following components:

  \item{statistic}{The value of the t-statistic.}
  \item{parameter}{The degrees of freedom for the t-statistic.}
  \item{p.value}{The p-value for the test.}
  \item{conf.int}{A confidence interval for the mean appropriate to the specified alternative hypothesis.}
  \item{estimate}{The estimated mean or difference in means depending on whether it was a one-sample test or a two-sample test.}
  \item{null.value}{The specified hypothesized value of the mean or mean difference depending on whether it was a one-sample test or a two-sample test.}
  \item{stderr}{The standard error of the mean (difference), used as denominator in the t-statistic formula.}
  \item{alternative}{A character string describing the alternative hypothesis.}
  \item{method}{A character string indicating what type of t-test was performed.}
  \item{data.name}{A character string giving the name(s) of the data.}
}
\seealso{
\code{\link{prop.test}}
}
\examples{
require(graphics)

t.test(1:10, y = c(7:20))      # P = .00001855
t.test(1:10, y = c(7:20, 200)) # P = .1245    -- NOT significant anymore

## Classical example: Student's sleep data
plot(extra ~ group, data = sleep)
## Traditional interface
with(sleep, t.test(extra[group == 1], extra[group == 2]))

## Formula interface
t.test(extra ~ group, data = sleep)

## Formula interface to one-sample test
t.test(extra ~ 1, data = sleep)

## Formula interface to paired test
## The sleep data are actually paired, so could have been in wide format:
sleep2 <- reshape(sleep, direction = "wide",
                  idvar = "ID", timevar = "group")
t.test(Pair(extra.1, extra.2) ~ 1, data = sleep2)

###=============================================================================
###=============================================================================
###8. týden: IMPLEMENTACE STATISTICKÝCH TESTŮ
###=============================================================================
###=============================================================================
library(carData)
data(Salaries)
attach(Salaries)
###I) Test střední hodnoty - jeden výběr
##Otestujeme průměrný plat
##Pro představu si spočteme výběrový průměr
aver_salary<- mean(salary)
##Pokusíme se prokázat, že průměrný plat je větší než 100 000

t_test <- t.test(salary, alternative = "greater", mu=100000)
t_test

###II) Test shody 2 středních hodnot pro (ne)závislé výběry
###Budeme porovnávat platy mužů a žen
salary_male <- Salaries[sex=="Male",]$salary
salary_female <- Salaries[sex=="Female",]$salary

t.test(salary_male, salary_female, alternative = "greater")

##Pokud by byl párový, tak parametr paired nastavím na TRUE

###III) Test pro relativní četnost
##Budeme chtít otestovat relativní četnost profesorů
##Pro představu si setvaíme proporční tabulku

prop.table(table(rank))
##Takže budeme chtít prokázat, že pravděpodobnost profesora je větší než 0.6

x <- sum(rank=="Prof")
n <- length(rank)

binom.test(x, n, p = 0.6, alternative = "greater")

###IV) Chí kvadrát test dobré shody
##Budeme testovat pravděpodobnosti jednotlivých akademických titulů

prop.table(table(rank))
Rank <- table(rank)

counts <- c(Rank[1],Rank[2],Rank[3])
p <- c(0.15, 0.15, 0.7)
chisq.test(counts, p)

###V) Chí kvadrát test nezávislosti
###Budeme testovat nezávislost platu na pohlaví

contingency <- table(sex, rank)
contingency
round(prop.table(contingency), digits=2)
chisq.test(contingency)


###VI) ANOVA
summary(aov(salary~sex))


###VII) Regresní přímka

lm1 <- lm(salary ~ yrs.service)
summary(lm1)
}
