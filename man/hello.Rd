\name{Normal}
\alias{pnorm}
\title{The Normal Distribution}
\description{
Density, distribution function, quantile function and random generation for the normal distribution with mean equal to \code{mean} and standard deviation equal to \code{sd}.
}
\usage{
dnorm(x, mean = 0, sd = 1, log = FALSE)
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
rnorm(n, mean = 0, sd = 1)
}
\arguments{
  \item{x, q}{Vector of quantiles.}
  \item{p}{Vector of probabilities.}
  \item{n}{Number of observations. If \code{length(n) > 1}, the length is taken to be the number required.}
  \item{mean}{Vector of means.}
  \item{sd}{Vector of standard deviations.}
  \item{log, log.p}{Logical; if \code{TRUE}, probabilities \code{p} are given as \code{log(p)}.}
  \item{lower.tail}{Logical; if \code{TRUE} (default), probabilities are \eqn{P[X \le x]}; otherwise, \eqn{P[X > x]}.}
}
\details{
If \code{mean} or \code{sd} are not specified they assume the default values of 0 and 1, respectively.

The normal distribution has density

\deqn{f(x) = \frac{1}{\sqrt{2\pi}\sigma} e^{-(x-\mu)^2 / (2\sigma^2)}}

where \eqn{\mu} is the mean of the distribution and \eqn{\sigma} the standard deviation.
}
\value{
\code{dnorm} gives the density, \code{pnorm} gives the distribution function, \code{qnorm} gives the quantile function, and \code{rnorm} generates random deviates.

The length of the result is determined by \code{n} for \code{rnorm}, and is the maximum of the lengths of the numerical arguments for the other functions.

The numerical arguments other than \code{n} are recycled to the length of the result. Only the first elements of the logical arguments are used.

For \code{sd = 0} this gives the limit as \code{sd} decreases to 0, a point mass at \code{mu}. \code{sd < 0} is an error and returns \code{NaN}.
}
\source{
For \code{pnorm}, based on

Cody, W. D. (1993) Algorithm 715: SPECFUN – A portable FORTRAN package of special function routines and test drivers. ACM Transactions on Mathematical Software 19, 22–32.

For \code{qnorm}, the code is based on a C translation of

Wichura, M. J. (1988) Algorithm AS 241: The percentage points of the normal distribution. Applied Statistics, 37, 477–484; doi:10.2307/2347330.

For \code{rnorm}, see \code{RNG} for how to select the algorithm and for references to the supplied methods.
}
\references{
Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) \emph{The New S Language}. Wadsworth & Brooks/Cole.

Johnson, N. L., Kotz, S. and Balakrishnan, N. (1995) \emph{Continuous Univariate Distributions}, volume 1, chapter 13. Wiley, New York.

Maechler, M. (2022) Asymptotic tail formulas for gaussian quantiles; DPQ vignette \url{https://CRAN.R-project.org/package=DPQ/vignettes/qnorm-asymp.pdf}.
}
\seealso{
\code{\link{Distributions}} for other standard distributions, including \code{\link{dlnorm}} for the Lognormal distribution.
}
\examples{
require(graphics)

dnorm(0) == 1/sqrt(2*pi)
dnorm(1) == exp(-1/2)/sqrt(2*pi)
dnorm(1) == 1/sqrt(2*pi*exp(1))

## Using "log = TRUE" for an extended range:
par(mfrow = c(2,1))
plot(function(x) dnorm(x, log = TRUE), -60, 50,
     main = "log { Normal density }")
curve(log(dnorm(x)), add = TRUE, col = "red", lwd = 2)
mtext("dnorm(x, log=TRUE)", adj = 0)
mtext("log(dnorm(x))", col = "red", adj = 1)

plot(function(x) pnorm(x, log.p = TRUE), -50, 10,
     main = "log { Normal Cumulative }")
curve(log(pnorm(x)), add = TRUE, col = "red", lwd = 2)
mtext("pnorm(x, log=TRUE)", adj = 0)
mtext("log(pnorm(x))", col = "red", adj = 1)

## if you want the so-called 'error function'
erf <- function(x) 2 * pnorm(x * sqrt(2)) - 1
## (see Abramowitz and Stegun 29.2.29)
## and the so-called 'complementary error function'
erfc <- function(x) 2 * pnorm(x * sqrt(2), lower = FALSE)
## and the inverses
erfinv <- function(x) qnorm((1 + x)/2)/sqrt(2)
erfcinv <- function(x) qnorm(x/2, lower = FALSE)/sqrt(2)

Rozdělení pravděpodobnosti náhodné veličiny
1. b) P(6) = 0
2. c) První je 0,4, druhá 0,8
3. a) střední hodnota náhodné veličiny je 3,67
4. a) F(0) = 0, F(10) = 1
5. d) F(1) = 0,067, F(3) = 0,4

Náhodná veličina X nabývá
1. a) F1 = 0,6 ; F3 = 0,88 ; F7 = 1
2. b) 0,35
3. c) 0,11 a 0,18
4. d) 1,46

Výška vysokoškolské studentky má normální
1. c) 0,00466
2. a) dvě až tři
3. a) 168,65
4. b) 175,35
5. d) 168,65 až 175,35

Počet různých druhů zboží
1. d) 1,31
2. b) 0,9739
3. c) 0,987
4. a) v bodě 1 do jedničky
5. a) 0,35

V loterii Sportka tipuje sázející
1. d) 13 983 816
2. a) 0,000 000 0715
3. b) 0,0177
4. a) 0,564
5. c) 0,0186

Předpokládejte, že skutečný obsah litrové láhve
1. c) 1-F(1,02)
2. d) 2,275%
3. a) 68,268%

Chceme posoudit, zda existují rozdíly v průměrné roční spotřebě energie
1. c) nejnižší 10 a nejvyšší 13
2. d) průměrná roční spotřeba energie v jednom region je jiná, než v ostatních
3. b) 97,5
4. a) Porovnáváme vypočtenou hodnotu testového kritéria 6,318348…
5. a) Na 5% hladině významnosti ZAMÍTÁME nulovou hypotézu a přijímáme alternativní hypotézu, že
PRŮMĚRNÁ roční spotřeba energie jedné domácnosti aspoň v jednom regionu…

Chceme posoudit, zda existují rozdíly v průměrném měsíčním nájmu nových bytů
1. A) Nejnižší 743, nejvyšší 1064,4
2. C) Průměrný měsíční nájem aspoň v jednom regionu je jiný
3. A) 400513,2
4. D) Porovnáváme vypočtenou hodnotu….
5. B) na 5% hladině významnosti nezamítáme…

Z údajů o hektarových výnosech pšenice
1. a) H0 : u1 = u2 = u3 = u4
2. d) nezamítáme H0
3. c) 0,269

Za produkci podniku, který vyrábí dva druhy výrobků
1. c) +31,8%
2. d) zvýšil se vice % než Laspayersovým indexem
3. a) zvýšil se méně než Paascheho indexem

Posuďte relativní změnu množství, průměrné ceny a hodnoty akcií
1. a) +4,2%
2. b) zvýšilo o méně než 70 %
3. b) +74,4%

V tabulce jsou uvedeny čtvrtletní údaje o počtu ubytovaných v hotelu
Danou čtvrtletní časovou řadu modelujte pomocí regresního přístupu
1. c) 39,8
2. b) 48,4
3. a) -83
4. c) ve 3. Čtvrtletí
5. c) 791

Hodnoty z tabulky představují počet prodaných kusů
1. b) 12 -6 29 18 -25
2. c) 1,107 0,952 1,246 1,122 0,848
3. a) 5,6
4. a) 1,045
5. d) 146

Následující časovou řadu (počet zákazníku jisté cestovní kanceláře v tisících) očistěte od sezónních vlivů
1. c) centrované klouzavé průměry délky 4
2. a) 6,5
3. d) nelze vypočítat
4. b) 7,25

Následující časovou řadu (počet návštěvníků určitého sportovního zařízení v tisících) očistěte od sezónních vlivů
1. a) centrované klouzavé průměry délky 4
2. b) 30
3. c) nelze vypočítat
4. b) 35,625

Máte k dispozici časovou řadu ročních údajů výroby automobilů
1. b) T=63701,5+1680,6t
2. a) parametr kladný, časová řada roste
3. c) 0,786132
4. b) 6339207
5. d) 82189

O tržbách obchodního podniku máme k dispozici tyto údaje
Jaký je průměrný roční koeficient růstu odpovídající období 2006 až 2010
1. d) 1,043
2. c) nejvyšší 2010-12, nejnižší 2012-15
3. a) nejmenší 71,1, nejvyšší 74,9

U 35 pracovníků, náhodně vybraných z těch, kteří absolvovali speciální výcvik
1. A) H0 : E (X1) = E (X2)
2. B) -2,51
3. C) přibližně normované normální rozdělení
4. D) Kritický obor tvoří hodnoty menší nebo rovny -1,645
5. B) Hodnota testového kritéria nepatří

K dispozici máme časovou řadu bazických indexů
1. c) průměrný růst o 5 % ročně
2. b) o 21,6 %
3. b) o méně než 3 %

Uvažujte časovou řadu řetězových indexů (v procentech) počtu prodaných výrobků
1. B) 100,102,100,100,110,137
2. C) 100
3. A) 2015
4. D) 1,38krát

Někteří lidé nenabírají váhu, ani když se přejídají
1. B) 3,520547
2. A) 1,764686
3. D) hodnota koeficientu determinace je 0,688699……. 68,8699 % variability nárůstu tuku.
4. C) 2,563097 kg
5. A) Porovnáváme p-hodnotu 0,010792 a zvolenou hladinu významnosti 0,05

Dotazníkovým šetřením provedeným u náhodně vybraných absolventů vysokých škol v ČR
1. A) 1,96
2. B) 0,0112
3. C) 0,0219
4. D) 9,06% ; 13,44 %

Ve třech prodejnách byly zjištěny údaje o prodeji jablek za měsíce leden a únor
1. D) vzrostly o 4 %
2. B) zvýšily se o 1355 Kč
3.

Na základě čtvrtletních údajů o výrobě piva
1.
2. C) -0,243
3. A) 5,520

Na základě údajů o počtu vyvezených chladniček
1. c) lineární: 0,822, kvadratická: 0,997
2. a) lineární: 0,822, kvadratická: 0,997
3. b) lineární: 41,037
4. a) lineární: 90,997

Hmotnost novorozeného dítěte
1. a) 0,8413
2. a) 0,2525
3. a) 0,0912
4. b) 0,9044
5. d) 0,8315

Ve firmě 4Byznys byla zjišťována spokojenost různých skupin zaměstnanců
1. C) nejmenší očekávaná četnost je 5,6. Kategorie spokojenosti nemusí být sloučeny
2. A) H0: nezávislost, H1: závislost
3. A) testové kritérium je 7,8 a kritická hodnota kvantilu je 16,9
4. A) Testové kritérium spadá do oboru přijetí
5. A) Pearsonův kontingenční koeficient je roven 0,247

U náhodně vybraných respondentů byla zjišťována průměrná doba
1. a) 97,5% kvantil normovaného normálního rozdělení
2. a) 1,30
3. d) 1,96
4. c) 177,45 ; 182,55

Pro ověření regulérnosti hrací kostky jsme provedli 150 hodů
1. a) pravděpodobnost padnutí každého z šesti čísel je rovna 1/6
2. c) 8,16
3. b) chí-kvadrát rozdělení o 5 stupních volnosti
4. a) kritický obor tvoří hodnoty vyšší nebo rovna 11,1
5. a) hodnota testového kritéria patří do kritického oboru, a proto nulovou hypotézu nezamítáme

Výrobce nákladniho automobilu předpokládá
1)b H0: u =90, H1 u <90
2)b -2,971
3)c W0,05 = {t;t<=-1,761}
4)a Nulovou hypotézu o střední hodnotě zamítáme ve prospěch altrnativná hypotézy
}
}
