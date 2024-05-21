\name{lm}
\alias{lm}
\title{Fitting Linear Models}
\description{
\code{lm} is used to fit linear models, including multivariate ones. It can be used to carry out regression, single stratum analysis of variance and analysis of covariance (although \code{aov} may provide a more convenient interface for these).
}
\usage{
lm(formula, data, subset, weights, na.action,
   method = "qr", model = TRUE, x = FALSE, y = FALSE, qr = TRUE,
   singular.ok = TRUE, contrasts = NULL, offset, ...)

## S3 method for class 'lm'
print(x, digits = max(3L, getOption("digits") - 3L), ...)
}
\arguments{
  \item{formula}{An object of class \code{"formula"} (or one that can be coerced to that class): a symbolic description of the model to be fitted. The details of model specification are given under ‘Details’.}
  \item{data}{An optional data frame, list or environment (or object coercible by \code{as.data.frame} to a data frame) containing the variables in the model. If not found in \code{data}, the variables are taken from \code{environment(formula)}, typically the environment from which \code{lm} is called.}
  \item{subset}{An optional vector specifying a subset of observations to be used in the fitting process. (See additional details about how this argument interacts with data-dependent bases in the ‘Details’ section of the \code{model.frame} documentation.)}
  \item{weights}{An optional vector of weights to be used in the fitting process. Should be \code{NULL} or a numeric vector. If non-\code{NULL}, weighted least squares is used with weights \code{weights} (that is, minimizing \code{sum(w*e^2)}); otherwise ordinary least squares is used. See also ‘Details’.}
  \item{na.action}{A function which indicates what should happen when the data contain \code{NA}s. The default is set by the \code{na.action} setting of \code{options}, and is \code{na.fail} if that is unset. The ‘factory-fresh’ default is \code{na.omit}. Another possible value is \code{NULL}, no action. Value \code{na.exclude} can be useful.}
  \item{method}{The method to be used; for fitting, currently only \code{method = "qr"} is supported; \code{method = "model.frame"} returns the model frame (the same as with \code{model = TRUE}, see below).}
  \item{model, x, y, qr}{Logical. If \code{TRUE} the corresponding components of the fit (the model frame, the model matrix, the response, the QR decomposition) are returned.}
  \item{singular.ok}{Logical. If \code{FALSE} (the default in S but not in R) a singular fit is an error.}
  \item{contrasts}{An optional list. See the \code{contrasts.arg} of \code{model.matrix.default}.}
  \item{offset}{This can be used to specify an \emph{a priori} known component to be included in the linear predictor during fitting. This should be \code{NULL} or a numeric vector or matrix of extents matching those of the response. One or more offset terms can be included in the formula instead or as well, and if more than one are specified their sum is used. See \code{model.offset}.}
  \item{...}{For \code{lm()}: additional arguments to be passed to the low level regression fitting functions (see below).}
  \item{digits}{The number of significant digits to be passed to \code{format(coef(x), .)} when \code{print()}ing.}
}
\details{
Models for \code{lm} are specified symbolically. A typical model has the form \code{response ~ terms} where \code{response} is the (numeric) response vector and \code{terms} is a series of terms which specifies a linear predictor for \code{response}. A terms specification of the form \code{first + second} indicates all the terms in \code{first} together with all the terms in \code{second} with duplicates removed. A specification of the form \code{first:second} indicates the set of terms obtained by taking the interactions of all terms in \code{first} with all terms in \code{second}. The specification \code{first*second} indicates the cross of \code{first} and \code{second}. This is the same as \code{first + second + first:second}.

If the formula includes an offset, this is evaluated and subtracted from the response.

If \code{response} is a matrix a linear model is fitted separately by least-squares to each column of the matrix and the result inherits from \code{"mlm"} (\emph{multivariate linear model}).

See \code{model.matrix} for some further details. The terms in the formula will be re-ordered so that main effects come first, followed by the interactions, all second-order, all third-order and so on: to avoid this pass a \code{terms} object as the formula (see \code{aov} and \code{demo(glm.vr)} for an example).

A formula has an implied intercept term. To remove this use either \code{y ~ x - 1} or \code{y ~ 0 + x}. See \code{formula} for more details of allowed formulae.

Non-\code{NULL} weights can be used to indicate that different observations have different variances (with the values in \code{weights} being inversely proportional to the variances); or equivalently, when the elements of \code{weights} are positive integers \eqn{w_i}, that each response \eqn{y_i} is the mean of \eqn{w_i} unit-weight observations (including the case that there are \eqn{w_i} observations equal to \eqn{y_i} and the data have been summarized). However, in the latter case, notice that within-group variation is not used. Therefore, the sigma estimate and residual degrees of freedom may be suboptimal; in the case of replication weights, even wrong. Hence, standard errors and analysis of variance tables should be treated with care.

\code{lm} calls the lower level functions \code{lm.fit}, etc, see below, for the actual numerical computations. For programming only, you may consider doing likewise.

All of \code{weights}, \code{subset} and \code{offset} are evaluated in the same way as variables in \code{formula}, that is first in \code{data} and then in the environment of \code{formula}.
}
\value{
\code{lm} returns an object of class \code{"lm"} or for multivariate (‘multiple’) responses of class \code{c("mlm", "lm")}.

The functions \code{summary} and \code{anova} are used to obtain and print a summary and analysis of variance table of the results. The generic accessor functions \code{coefficients}, \code{effects}, \code{fitted.values} and \code{residuals} extract various useful features of the value returned by \code{lm}.

An object of class \code{"lm"} is a list containing at least the following components:

  \item{coefficients}{A named vector of coefficients.}
  \item{residuals}{The residuals, that is response minus fitted values.}
  \item{fitted.values}{The fitted mean values.}
  \item{rank}{The numeric rank of the fitted linear model.}
  \item{weights}{(Only for weighted fits) the specified weights.}
  \item{df.residual}{The residual degrees of freedom.}
  \item{call}{The matched call.}
  \item{terms}{The \code{terms} object used.}
  \item{contrasts}{(Only where relevant) the contrasts used.}
  \item{xlevels}{(Only where relevant) a record of the levels of the factors used in fitting.}
  \item{offset}{The offset used (missing if none were used).}
  \item{y}{If requested, the response used.}
  \item{x}{If requested, the model matrix used.}
  \item{model}{If requested (the default), the model frame used.}
  \item{na.action}{(Where relevant) information returned by \code{model.frame} on the special handling of \code{NA}s.}

In addition, non-null fits will have components \code{assign}, \code{effects} and (unless not requested) \code{qr} relating to the linear fit, for use by extractor functions such as \code{summary} and \code{effects}.
}
\note{
Considerable care is needed when using \code{lm} with time series.

Unless \code{na.action = NULL}, the time series attributes are stripped from the variables before the regression is done. (This is necessary as omitting \code{NA}s would invalidate the time series attributes, and if \code{NA}s are omitted in the middle of the series the result would no longer be a regular time series.)

Even if the time series attributes are retained, they are not used to line up series, so that the time shift of a lagged or differenced regressor would be ignored. It is good practice to prepare a \code{data} argument by \code{ts.intersect(..., dframe = TRUE)}, then apply a suitable \code{na.action} to that data frame and call \code{lm} with \code{na.action = NULL} so that residuals and fitted values are time series.
}
\author{
The design was inspired by the S function of the same name described in Chambers (1992). The implementation of model formula by Ross Ihaka was based on Wilkinson & Rogers (1973).
}
\references{
Chambers, J. M. (1992) Linear models. Chapter 4 of \emph{Statistical Models in S} eds J. M. Chambers and T. J. Hastie, Wadsworth & Brooks/Cole.

Wilkinson, G. N. and Rogers, C. E. (1973). Symbolic descriptions of factorial models for analysis of variance. \emph{Applied Statistics}, 22, 392–399. \doi{10.2307/2346786}.
}
\seealso{
\code{\link{summary.lm}} for more detailed summaries and \code{\link{anova.lm}} for the ANOVA table; \code{\link{aov}} for a different interface.

The generic functions \code{coef}, \code{effects}, \code{residuals}, \code{fitted}, \code{vcov}.

\code{\link{predict.lm}} (via \code{predict}) for prediction, including confidence and prediction intervals; \code{\link{confint}} for confidence intervals of parameters.

\code{\link{lm.influence}} for regression diagnostics, and \code{\link{glm}} for generalized linear models.

The underlying low level functions, \code{lm.fit} for plain, and \code{lm.wfit} for weighted regression fitting.

More \code{lm()} examples are available e.g., in \code{anscombe}, \code{attitude}, \code{freeny}, \code{LifeCycleSavings}, \code{longley}, \code{stackloss}, \code{swiss}.

\code{biglm} in package \code{biglm} for an alternative way to fit linear models to large datasets (especially those with many cases).
}
\examples{
require(graphics)

## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
lm.D9 <- lm(weight ~ group)
lm.D90 <- lm(weight ~ group - 1) # omitting intercept

anova(lm.D9)
summary(lm.D90)

opar <- par(mfrow = c(2,2), oma = c(0, 0, 1.1, 0))
plot(lm.D9, las = 1)      # Residuals, Fitted, ...
par(opar)

### less simple examples in "See Also" above

Question: Rozptyl vzájemně různých záporných čísel je:
Correct Answer: kladný

Question: Pokud při výpočtu váženého aritmetického průměru vynásobíme četnosti konstantou, také průměr se vynásobí touto konstantou.
Correct Answer: Ne

Question: Násobíme-li všechny četnosti při výpočtu váženého arit. průměru konstantou, průměr se rovněž násobí touto konstantou.
Correct Answer: Ne

Question: Harmonický průměr má smysl použít ve všech situacích jako průměr aritmetický
Correct Answer: Lež

Question: Přičteme-li ke všem hodnotám znaku konstantu, jejich rozptyl se nezmění:
Correct Answer: Ano

Question: Pokud vynásobíme váhy ve váženém aritmetickém průměru konstantou, průměr se nezmění.
Correct Answer: Ano

Question: Medián souboru:
Correct Answer: Může nabývat libovolné hodnoty

Question: modus:
Correct Answer: Nepatří mezi kvantily

Question: Jestliže každou hodnotu stat. souboru zvýšíme o 10%, variační koeficient všech hodnot se:
Correct Answer: nezmění se

Question: Rozptyl je:
Correct Answer: průměr čtvercových odchylek hodnot proměnné od jejího průměru

Question: Z 30 hodnot byl vypočten arit. průměr 15 a nalezen medián 13,9. Dvě jednotky však byly opomenuty a je potřeba je dodatečně zařadit do souboru. Hodnoty sledované proměnné jsou u nich 10 a 36. Opravené výsledky budou:
Correct Answer: průměr = 15,5, medián = 13,9

Question: Pokud vynásobím váhy ve váženém aritmetickém průměru konstantou, průměr se nezmění.
Correct Answer: Ano

Question: Pokud ke každé hodnotě pozorování připočteme konstantu, medián se nezmění.
Correct Answer: Ne

Question: Směrodatná odchylka může být záporná
Correct Answer: Ne

Question: Ve sloupcovém grafu vyčteme četnost z:
Correct Answer: výšky sloupce

Question: Odlehlé hodnoty náhodné veličiny vedou k přesnějšímu průměru.
Correct Answer: Ne

Question: Rozptyl dvou záporných čísel je:
Correct Answer: kladný

Question: Proměnná obor studia je:
Correct Answer: kvalitativní

Question: Ve výsečovém grafu podíl plochy určité výseče na celkové ploše vyjadřuje:
Correct Answer: relativní četnost kategorie popisované proměnné

Question: Medián mezd mužů i medián mezd žen je 23 tis. Kč, takže medián mezd mužů a žen dohromady je též 23 tis. Kč?
Correct Answer: Pravda

Question: Čím znázorníme rozdělení četností hodnot spojité veličiny:
Correct Answer: histogram

Question: Co je vhodným bodovým odhadem relativní četnosti určité obměny statistického znaku v základním souboru:
Correct Answer: relativní četnost této obměny ve výběrovém souboru

Question: Medián mezd žen je 20, medián mezd mužů je 20, potom celkový medián je taky 20?
Correct Answer: Ano

Question: Variační koeficient musí být číslo od nuly do jedné.
Correct Answer: Ne

Question: Distribuční funkci spojité náhodné veličiny lze získat integrací hustoty pravděpodobnosti této veličiny.
Correct Answer: Ano

Question: Jen jedna z následujících pravděpodobnostních funkcí je správná pro hodnoty 1,2,3.
Correct Answer: P(1)=0,2; P(2)=0,4; P(3)=0,4

Question: Pokud jeden jev má pravděpodobnost 0,5 a druhý 0,2 a jejich sjednocení má hodnotu 0,7, pak jsou tyto jevy:
Correct Answer: Neslučitelné

Question: Pravděpodobnost jednoho jevu je 0,3 a druhého 0,5. Pravděpodobnost jejich současného nastoupení je 0,2. Potom platí:
Correct Answer: Jevy jsou závislé

Question: Uvažujeme konečný soubor N výrobků, z nichž je M zmetků. Náhodně z tohoto souboru vybereme (bez vracení) n výrobků. Náhodná veličina X představující počet zmetků mezi vybranými výrobky má rozdělení:
Correct Answer: hypergeometrické rozdělení

Question: Střední hodnota binomického rozdělení libovolných (smysluplných) parametrů je kladné číslo:
Correct Answer: Ano

Question: U symetrického rozdělení je střední hodnota vždy rovna mediánu.
Correct Answer: Ano

Question: Měříme spotřebu auta na 100 km/h, co znamená F(8) - F(6)?
Correct Answer: Pravděpodobnost, že za jednu 100 km jízdu auto spotřebuje benzín v intervalu 6 až 8.

Question: Pro dva neslučitelné jevy s pravděpodobnostmi 0,5 a 0,2 je pravděpodobnost jejich sjednocení rovna 0,7
Correct Answer: Ano

Question: Distribuční funkce náhodné veličiny
Correct Answer: Určitá pravděpodobnost, že náhodná veličina nepřekročí danou hodnotu.

Question: f(x) hustota pravděpodobnosti vyjadřuje pravděpodobnost, že náhodná veličina nabude hodnoty x.
Correct Answer: Ne

Question: Hustota pravděpodobnosti je:
Correct Answer: Funkce popisující pravděpodobnostní rozdělení spojité náh. veličiny

Question: Pravděpodobnost sjednocení dvou slučitelných jevů je definována jako:
Correct Answer: součet pravděpodobností obou jevů zmenšených o pravděpodobnost jejich průniku

Question: Testujeme hypotézu na 1% hl. významnosti. Byla určena minimální hladina významnosti. Ve kterém případě nul. hypotézu zamítáme?
Correct Answer: P=0,008

Question: Oboustranný interval spolehlivosti pro pravděpodobnost koupě nového výrobku z n=150 (nebo 50) pozorování. Pokud zůstanou všechny vstupní údaje nezměněné budeme provádět na základě vyššího rozsahu výběru n=400 (nebo 150), dostaneme:
Correct Answer: Užší interval spolehlivosti

Question: Pravděpodobnost chyby 1. druhu je větší než pravděpodobnost chyby 2.druhu.
Correct Answer: Ne

Question: Oboustranný interval spolehlivosti pro podíl zákazníků, kteří si koupí nový výrobek, byl sestrojen z n1 = 150 pozorování. Pokud zůstanou všechny vstupní údaje výpočtu neměnné, pouze výpočet budeme provádět na základě vyššího rozsahu výběru n2 = 400, dostaneme:
Correct Answer: užší interval spolehlivosti

Question: Zvětšením spolehlivosti se při stejném rozsahu výběru přesnost intervalového odhadu střední hodnoty normálního rozdělení:
Correct Answer: zmenší

Question: Pokud snížíme hodnotu hladiny významnosti testu z 0,05 na 0,01, pak se velikost kritického oboru zmenší.
Correct Answer: Ano

Question: Testové kritérium vyčteme v tabulkách a proměnnou vypočtenou z testového kritéria musíme dopočítat.
Correct Answer: Ne

Question: Hladina významnosti statistické hypotézy je:
Correct Answer: pravděpodobnost zamítnutí nulové hypotézy, která ale platí

Question: Jak snížíme pravděpodobnost chyby 2. Stupně:
Correct Answer: Zvětšením hladiny významnosti a zvětšením vzorku

Question: p-hodnota 0,03. Zamítáme na hladině významnosti 0,01 i 0,05.
Correct Answer: Ne

Question: Vyjde-li nám hodnota testového kritéria p=0,045, pak:
Correct Answer: Zamítáme hypotézu o nezávislosti na 5% hl. významnosti, na 1% nezamítáme.

Question: Pokud zamítáme H0 oboustranným testem, potom u jednoho z jednostranných testů při stejné hladině významnosti zamítáme hypotézu:
Correct Answer: vždy

Question: Skupina dobrovolníků se zúčastnila programu na snižování tělesné hmotnosti. Byly zjištěny hodnoty jejich hmotnosti v kilogramech před a po dokončení programu. Pro posouzení, zda program skutečně způsobil (v průměru) pokles tělesné hmotnosti účastníků, použijete
Correct Answer: párový t-test

Question: Hodnota mediánu studentova rozdělení je vždy:
Correct Answer: rovna nule

Question: Co znamená při testování hypotézy 1-beta.
Correct Answer: Pravděpodobnost zamítnutí nesprávné nulové hypotézy

Question: Pokud máme kvantil u(0,7), dokážeme z něj spočítat kvantil u(0,3).
Correct Answer: Ano

Question: Velká variabilita hodnot X snižuje přesnost odhadu jejich průměru.
Correct Answer: Ano

Question: Výběrový průměr je nezkresleným průměrem základního souboru
Correct Answer: Ano

Question: Na základě náhodného výběru máme rozhodnout, zda podíl kuřáků v populaci přesahuje určité procento. Je-li jich ve vzorku o rozsahu 1000 zjištěno 300, potřebujeme znát: (IDK)
Correct Answer: spolehlivost odhadu

Question: Obsahem nul. hypotézy u kor. analýzy je:
Correct Answer: nezávislost dvou kvant. znaků

Question: Podmínkou pro využití chí-kvadrátu je dostatečné obsazení ve všech skupinách
Correct Answer: Ano

Question: Pomocí hodnoty reg. koeficientu posuzujeme:
Correct Answer: změnu vysvětlované proměnné odpovídající jednotkové změně vysvětlující proměnné

Question: Pearsonův koef. kontingence při velmi těsné závislosti proměnných dosahuje hodnoty 1.
Correct Answer: Ne

Question: Chcete porovnat výkony pracovníků (tj. počet vyr. výrobků za směnu) ve třech směnách. Použijete:
Correct Answer: F test v analýze rozptylu

Question: Co říká alternativní hypotéza u analýzy rozptylu.
Correct Answer: alespoň jedna střední hodnota se liší od ostatních.

Question: Počet stupňů volnosti příslušný vnitroskupinovému součtu čtverců v analýze rozptylu:
Correct Answer: závisí na počtu skupin i na velikosti výběru

Question: Při použití Chí-kvadrát testu dobré shody ověřujeme shodu pozorovaných a teoretických četností v jednotlivých skupinách (resp. jednotlivých kategorií)
Correct Answer: Ano

Question: Regresní parabola je z hlediska parametrů lineární funkce
Correct Answer: Ano

Question: Testové kritérium u ANOVY konstruujeme jako podíl meziskupinového a celkového součtu čtverců.
Correct Answer: Ne

Question: Když je záporná směrnice přímky, je záporný i korelační koeficient.
Correct Answer: Ano

Question: Zjištěné četnosti uvnitř kont. tabulky se nazývají:
Correct Answer: sdružené

Question: Korelační koeficient se používá pro určení závislosti analýzy rozptylu.
Correct Answer: Ne

Question: Koeficient determinace v reg. analýze lze případně spočítat jako:
Correct Answer: korelační koeficient na druhou

Question: Těsnost závislosti v analýze rozptylu posuzujeme pomocí korelačního koeficientu.
Correct Answer: Ne

Question: Testujeme hypotézu v kontingenční tabulce o rozměru (r=3, s=4) a test. kritérium vyšlo G=-12,34.
Correct Answer: Nelze rozhodnout, zřejmě je chyba ve výpočtu.

Question: Korelační koeficient = -0,8, co platí?
Correct Answer: silná nepřímá závislost

Question: Testová statistika používaná při analýze nezávislosti v kont. tabulce má za předpokladu platnosti testované hypotézy:
Correct Answer: Chí-kvadrát rozdělení

Question: Při výpočtu analýzy rozptylu porovnáváme testové kritérium s F hodnotou v tabulkách (Fisher- Snedecorův kvantil)
Correct Answer: Ano

Question: Chí-kvadrát má kvalitní výsledky pouze, když máme 5 a více skupin.
Correct Answer: Ne

Question: Při testování závislosti v kontingenční tabulce se dvě podmíněné četnosti rovnají 1. V tom případě:
Correct Answer: Chí-kvadrát test nemůžeme použít.

Question: Očekávané četnosti vypočtené v jednotlivých polích kont. tabulky odpovídají hypotéze o závislosti dvou zkoumaných znaků
Correct Answer: Ne

Question: Metodu nejmenších čtverců lze přímo použít k odhadu parametrů u nelineární regrese
Correct Answer: Ne

Question: Lin. závislost 2 veličin je vyjádřena v grafu přímkou rovnoběžnou s vod. osou:
Correct Answer: Jsou na sebe lin. nezávislé

Question: Chí-kvadrát test dobré shody má počet stupňů volnosti rovný počtu členů.
Correct Answer: Ne

Question: Poměr determinace u analýzy rozptylu, jak ho vypočítáme:
Correct Answer: Meziskup. součet čtverců ku celkový součet čtverců

Question: Koeficient determinace v reg. analýze se počítá jako podíl
Correct Answer: teoretického součtu čtverců a celkového součtu čtverců

Question: U regresních funkcí lineárních v parametrech je součet odchylek skutečně pozorovaných hodnot vysvětlované proměnné od vyrovnaných hodnot odhadnutého modelu vždy kladný
Correct Answer: Ano

Question: Metoda nejmenších čtverců:
Correct Answer: slouží k odhadu parametrů reg. funkce

Question: Testové kritérium G, které se používá k ověření nezávislosti v kont. tabulce, vždy nabývá pouze nezáporných hodnot
Correct Answer: Ano

Question: Co je index determinace?
Correct Answer: Poměr čtverce modelu a celkových čtverců

Question: Pro popis reg. závislosti byla použita přímka. Potom pro výsledky t-testu o parametru Byx a t-testu o kor. koeficientu platí:
Correct Answer: je-li parametr Byx stat. významný, potom je výběrový kor. koeficient nenulový

Question: Pro korektní použití Chí-kvadrát testu musíme mít minimálně 5 skupin vysvětlující proměnné.
Correct Answer: Ne

Question: Pokud v chí-kvadrátu není splněna podmínka o počtu skupin, můžeme případně některé skupiny, které jsou věcně společné sloučit.
Correct Answer: Ano

Question: Statistika G (kontin. tabulky) vychází vždy v intervalu
Correct Answer: Ne

Question: Korelační koeficient:
Correct Answer: vyjadřuje sílu lin. závislosti

Question: Testování nezávislosti v kont. tabulce chí-kvadrát testem vyžaduje dostatečně velké:
Correct Answer: sdružené četnosti

Question: Chí-kvadrát test dobré shody má počet stupňů volnosti rovný počtu členů mínus 2.
Correct Answer: Ne

Question: Známe rovnici přímky y=130-0,08x, potom můžeme o kor. koeficientu říct:
Correct Answer: Korelační koeficient je záporný

Question: Když zaměníme řádky a sloupce u kontingenčních tabulek, nemá to vliv na výsledek.
Correct Answer: Ano

Question: Chí-kvadrát test dobré shody je založen na srovnávání pozorovaných četností a teoretických četností v jednotlivých skupinách.
Correct Answer: Ano

Question: Průměrný abs. přírustek čas. řady se rovná arit. průměru hodnot čas. řady.
Correct Answer: Ne

Question: Pro očištění čas. řady počtu dopravních nehod od sezónní složky použijeme klouz. průměry délky 7
Correct Answer: Ne

Question: Měsíční okamžikovou čas. řadu převedeme na čtvrtletní čas. řadu:
Correct Answer: vybereme z měsíční čas. řady každou 3. hodnotu

Question: Průměrnou hodnotu čas. řady je vždy vhodné vypočítat jako prostý arit. průměr jejich jednotlivých hodnot
Correct Answer: Ne

Question: Je-li hodnota koeficientu růstu v čas. řadě 0,7, znamená to:
Correct Answer: hodnota ukazatele klesla o 30%

Question: Při modelování trendů v časové řadě pomocí reg. přístupu je vždy lepším modelem trendu parabolický trend než-li trend přímkový
Correct Answer: Ne

Question: Chronologický průměr se používá při analýze okamžikových čas. řad
Correct Answer: Ano

Question: Součet sezónních faktorů u modelu řady s konst. sezónností je:
Correct Answer: roven nule

Question: Očištěná čas. řada má:
Correct Answer: trendovou a náhodnou složku

Question: Pro očištění denní čas. řady počtu dopravních nehod od sezónní složky použijeme:
Correct Answer: centrované klouz. průměry, vycházející z prostých průměrů délky 7

Question: Čtvrtletní čas. řadu očistíme od sezónnosti:
Correct Answer: Centrovanými klouz. průměry

Question: Pokud jsou všechny koef. růstu v časové řadě větší než 1, je i průměrný koeficient růstu větší než 1.
Correct Answer: Ano

Question: Průměrné tempo růstu v čas. řadě musí být vždy větší než jedna.
Correct Answer: Ne

Question: Systematické složky v čas. řadě jsou jen trendová a cyklická.
Correct Answer: Ne

Question: Trendovou složku nelze určit pomocí:
Correct Answer: průměrné čtvercové chyby (MSE)

Question: Hodnota kritéria MSE používaného v čas. řadách
Correct Answer: Nemůže být nikdy záporná

Question: Systematické složky v krátkodobé čas. řadě jsou pouze:
Correct Answer: trendová, sezónní, cyklická

Question: Při modelování sezónní složky reg. metodou do modelu:
Correct Answer: vkládáme o jednu méně sezónních umělých proměnných než je počet sezón

Question: Centrované klouz. průměry použijeme pro očištění od sezónnosti čas. řady ročních údajů.
Correct Answer: Ano

Question: Chronologický průměr se využívá o okamžikových časových řad
Correct Answer: Ano

Question: Pokud jsou všechny koef. růstu v čas. řadě větší než 1, je průměrný koeficient růstu větší než 1.
Correct Answer: Ano

Question: Průměrný koef. růstu v čas. řadě se vypočítá jako:
Correct Answer: geometrické průměr jednotlivých koef. Růstu

Question: K odstranění sezónní složky ve čtvrtletní čas. řadě HDP je nejvhodnější použít:
Correct Answer: Centrované klouz. průměry

Question: Soubor produktů a indexů spotřebitelských cen se nazývá spotřební koš
Correct Answer: Ano

Question: Jakou charakteristiku rel. změny cen 3 výrobků při stálém objemu produkce ze základního období použijeme:
Correct Answer: L. Index

Question: Pokud znáte Paascheho cen. index a Fisherův cen. index můžete zjistit:
Correct Answer: Laspeyeresův cen. index

Question: V pěti prodejnách určitého zboží prodejního řetězce došlo ke změně tržby oproti předcházejícímu období v % následovně: 15, -3, 11, 8, -11. Která z hodnot hodnotového indexu ze všech 5 prodejen není možná?
Correct Answer: 0,88

Question: Mírou inflace se rozumí relativní změna indexu spotřeb. cen
Correct Answer: Ano

Question: Průměrná roční míra inflace byla v roce 2014 1,0% a v roce 2015 1,3%, z čehož můžeme vyvodit závěr:
Correct Answer: Míra inflace stoupla meziročně o 0,3 proc. bodu

Question: K porovnání hodnot veličiny ve dvou po sobě následujících období se používá
Correct Answer: řetězový index

Question: Individuální indexy dělíme na:
Correct Answer: jednoduché a složené

Question: Spotřební koš představuje
Correct Answer: soubor reprezentantů a váhový systém indexu spotřeb. cen

Question: Pro stanovení indexu spotřeb. cen se dává přednost
Correct Answer: Laspeyresovu cen. Indexu

Question: Soubor reprezentantů a váhový systém indexu spotřeb. cen se nazývá spotřební koš.
Correct Answer: Ano

Question: Známe hodnotu jednoho výrobku v lednu a v březnu v 1 prodejním řetězci. Jaký index použijeme?
Correct Answer: hodnotový

Question: Je potřeba porovnat cenu jednoho výrobku v běžném období s jeho cenou v zk. období celkově za všechny čtyři obchody
Correct Answer: index proměnlivého složení

Question: Je hustota obyvatel ČR hodnota extenzitní?
Correct Answer: Ne

Question: Při indexní analýze pro index 1,2; 1,42; 1,36; 1,48 nemůže výsledek být.
Correct Answer: 1,52

Question: O inflaci lze například říci, že:
Correct Answer: měří se na základě indexu spotřebitelských cen a většinou se udává v procentech

Question: Jaký použijeme index pro 3 výrobky se stejným množstvím v zk. období pro výpočet rel. změny ceny.
Correct Answer: Laspeyresův cen. index

Question: Hodnota směrnice v lineárním regresním modelu vyjadřuje:
Correct Answer: změnu závisle proměnné odpovídající jednotkové změně nezávisle proměnné

Question: Rozptyl mezd ve firmě A je vyšší než ve firmě B. Co platí pro var. koeficienty?
Correct Answer: Nelze jednoznačně rozhodnout

Question: Pouze jedna z kombinací hodnot může pocházet z distribuční funkce náh. veličiny s def. oborem daným hodnotami 1, 2, a 3
Correct Answer: F(0)=0; F(2)=0,6; F(3)=1

Question: Představu o nezávislosti veličin v kont. tabulce můžeme získat tak, že sdružené četnosti vydělíme celkovým rozsahem souboru
Correct Answer: Ne

Question: Průměrný koeficient růstu lze vypočítat jako aritmetický průměr koeficientů růstu
Correct Answer: Ne

Question: Počet stupňů volnosti vnitroskupinového součtu čtverců v analýze rozptylu
Correct Answer: závisí na počtu skupin

Question: Chronologický průměr se používá při výpočtu průměrného koef. růstu
Correct Answer: Ne

Question: Fisherův index je arit. průměrem Laspeyeresova indexu a Paascheho indexu
Correct Answer: Ne

Question: Při vyčerpávajícím šetření jsou prošetřeny veškeré jednotky stat. souboru
Correct Answer: Ano

Question: Chronologický průměr se počítá jako
Correct Answer: aritmetický průměr dvou po sobě následujících hodnot čas. řady

Question: V regresním modelu má test. kritérium jaké rozdělení?
Correct Answer: Fisherovo F-rozdělení

Question: Průměrnou hodnotu čas. řady “stav zásob v tis. Kč k poslednímu dni daného měsíce” zjištěných v lednu, dubnu a květnu, vypočítáme:
Correct Answer: váženým chronologickým průměrem

Question: Hodnota MSE používaného u čas. řad
Correct Answer: Nemůže být nikdy záporná

Question: Pravděpodobnost chyby prvního druhu je vždy větší než prav. chyby druhého druhu
Correct Answer: Ne

Question: Na základě údajů o spotřebě elektrické energie v souboru domácností byl zkonstruován 90% a 95% oboustranný interval spolehlivosti pro střední hodnotu spotřeby. Pak platí
Correct Answer: 90% interval je užší než 95% interval

Question: Hladina významnosti statistického testu udává:
Correct Answer: pravděpodobnost, že zamítneme platnou nulovou hypotézu

Question: Při nezávislosti dvou kat. proměnných se sdružené teoretické četnosti rovnají součinu marginálních četností (v příslušném řádku a sloupci) děleném rozsahem souboru
Correct Answer: Ano

Question: U souborů 140 bytů s různou výší nájemného bylo nájemné zvýšeno o 20 %. Jak se změní rozptyl a var. koeficient nájemného?
Correct Answer: Rozptyl vzroste o 44 % a var. koeficient se nezmění

Question: Zvýšením rozsahu výběru se snižuje přesnost intervalového odhadu
Correct Answer: Ne

Question: Binomické rozdělení je vhodným modelem, pokud se jedná o nez. náhodné pokusy
Correct Answer: ano

Question: Statistická definice pravděpodobnosti vychází z relativní četnosti výskytu jevu
Correct Answer: ano

Question: Obsahem nul. hypotézy v ANOVĚ je:
Correct Answer: nezávislost kvantitativní proměnné na kategoriální

Question: Hodnota testového kritéria se vypočítá na základě výběrových údajů, zatímco kritická hodnota se najde v tabulkách kvantilů některého prav. rozdělení
Correct Answer: Ano

Question: Co lze vyčíst z hodnoty párového korelačního koeficientu -1,27?
Correct Answer: Chybu (této hodnoty korelační koeficient nemůže nabýt)

Question: Podmínkou korektního použití chí-kvadrát testu je, že:
Correct Answer: očekávané četnosti jednotlivých kategorií jsou alespoň 5.

Question: Chronologický průměr se používá při výpočtu průměrného koeficientu růstu
Correct Answer: Ne

Question: Pokud je první hodnota čas. řady stejná jako poslední hodnota časové řady je průměr. absolutní přírustek této časové řady roven nule
Correct Answer: Ano

Question: Pro normování normálně rozdělené náhodné veličiny potřebujeme znát:
Correct Answer: střední hodnotu a rozptyl náhodné veličiny

Question: Pouze jedna z následujících kombinací hodnot může pocházet z distribuční funkce náhodné veličiny s def. oborem daným hodnotami 1,2 a 3
Correct Answer: F(0)=0, F(2)=0,6 a F(3)=1

Question: Průměrnou hodnotu čas. řady “stav zásob v tis. Kč k poslednímu dni daného měsíce” zjištěných v roce 2018 v lednu, dubnu a pak od června do prosince vypočítáme
Correct Answer: váženým chronologickým průměrem

Question: Má-li jeden jev pravděpodobnost 0,5 a druhý 0,2, pravděpodobnost jejich průniku za předpokladu, že jde o jevy nezávislé je menší než 0,3
Correct Answer: Ano

Question: Sezónní složka se vyskytuje pouze ve čtvrtletních ekonomických čas. řadách a nikoli v měsíčních ekonomických čas. řadách
Correct Answer: Ne

Question: Metoda nejmenších čtverců je použitelná k pořízení bodového odhadu parametrů regresní funkce nelineární v parametrech
Correct Answer: NE

Question: Metoda nejmenších čtverců je použitelná k pořízení bodového odhadu parametrů regresní funkce lineární v parametrech
Correct Answer: ANO

Question: Ukazatel meziroční inflace vypovídá o procentní změně
Correct Answer: cenové hladině ve sledovaném měsíci oproti témuž měsíci loňského roku

Question: Ve výsečovém diagramu vyjadřuje velikost úhlu každé výseče:
Correct Answer: Absolutní či relativní četnost

Question: Ve sloupkovém grafu vyčteme četnost ze:
Correct Answer: výšky sloupku

Question: Co není vychýleno extrémními hodnotami základního souboru:
Correct Answer: medián

Question: Zadáno 7 konkrétních platů, kolik zaměstnanců pobírá plat, který je nižší než medián:
Correct Answer: 3

Question: Je možné, aby se u symetrického rozdělení neshodoval průměr s mediánem:
Correct Answer: Není to možné.

Question: Průměr ze souboru hmotnosti sušenek je 500g a medián 575g. Jaká je jednotlivá váha sušenek:
Correct Answer: Více sušenek váží více než je průměr.

Question: Medián může popsat polohu statistického souboru lépe než průměr, jestliže:
Correct Answer: v souboru existují ojedinělé extrémy

Question: Z 30 hodnot byl vypočten aritmetický průměr 15 a nalezen medián 13,9. Dvě jednotky však byly opomenuty a je třeba je dodatečně zařadit do souboru. Hodnoty sledované proměnné jsou u nich 10 a 36. Opravené výsledky pak budou:
Correct Answer: průměr = 15,5 ; medián = 13,9

Question: Byly naměřeny teploty pod bodem mrazu, rozptyl bude:
Correct Answer: kladný

Question: Naměřili jsme směrodatnou odchylku 0:
Correct Answer: to je možné, pokud jsou všechny hodnoty stejné

Question: Rozptyl je:
Correct Answer: průměr čtvercových odchylek od průměru

Question: Součet odchylek od průměru je roven:
Correct Answer: nule

Question: Rozptyl dvou záporných různých čísel je:
Correct Answer: kladný

Question: Máme skupinu nájmů, průměr jednorázově vzroste o 1311 CZK, jak se změní variační rozpětí a rozptyl?:
Correct Answer: Rozptyl se nezmění, var. rozpětí nelze na základě uvedené informace odhadnout

Question: Medián mezd žen = 20, medián mezd mužů = 20, celkový medián taky 20?:
Correct Answer: ANO

Question: Použití harmonického průměru je vhodné, pokud chceme spočítat průměrnou rychlost:
Correct Answer: ANO

Question: Rozptyl je vždy větší než směrodatná odchylka:
Correct Answer: NE

Question: Pokud ke každé hodnotě pozorování připočteme konstantu a, medián se nezmění:
Correct Answer: NE

Question: Pokud ke každé hodnotě pozorování připočteme konstantua, průměr, směrodatná odchylka a rozptylse nezmění:
Correct Answer: NE

Question: Směrodatná odchylka náhodné veličiny může být 0:
Correct Answer: ANO

Question: 50% kvantil se nemůže rovnat 75% kvantilu z těch samých hodnot:
Correct Answer: NE

Question: Pokud jeden jev má pravděpodobnost 0,5 a druhý 0,2 a jejich sjednocení má hodnotu 0,7, pak tyto jevy jsou:
Correct Answer: Neslučitelné

Question: Jaký druh proměnné je počet dětí v rodině:
Correct Answer: kvantitativní (diskrétní)

Question: Jen jedna znásledujících pravděpodobnostních funkcí je správná pro hodnoty 1,2,3.:
Correct Answer: P(1) = 0,2 ; P(2) = 0,4, P(3) = 0,4

Question: Máme 3 různe zapisy distribucni funkce, ale jenom jeden z nich je spravně, urcit ktery:
Correct Answer: F(0) = 0, F(1) = 0.7, F(2) = 1

Question: Jaká je hodnota opačného jevu k jevu A?:
Correct Answer: 1–P(A)

Question: Pravděpodobnost jevu jistého:
Correct Answer: 1

Question: Hypergeometrické rozdělení se užívá:
Correct Answer: u pravděpodobnostního rozdělení závislých jevů

Question: Binomické rozdělení lze za jistých okolností aproximovat normálním rozdělením:
Correct Answer: ANO

Question: Při zvyšujících se pokusech se binomické rozdělení blíží normálnímu:
Correct Answer: ANO

Question: Distribuční funkce F(x) může nabývat hodnot:
Correct Answer: 0≤F(x)≤1

Question: Výdrž baterie je náhodná veličina X a hodnota jejího 90 procentního kvantilu je rovna 210. Což znamená:
Correct Answer: 90 procent baterií vydrží méně než 210 hodin

Question: 10% kvantil normovaného normálního rozdělení je:
Correct Answer: záporný

Question: U normálního rozdělení se střední hodnotou mí a rozptylem sigma je střední hodnota rovna :
Correct Answer: modu,mediánu, aritmetickému průměru

Question: Co platí o distribuční fci F(x):
Correct Answer: 0≤F(x)≤1

Question: Hustota pravděpodobnosti je:
Correct Answer: Pravděpodobnostní rozdělení NV

Question: Je možné, aby u symetrického rozdělení vyšel průměr rozdílně než medián?:
Correct Answer: Není to možné

Question: U normálního rozdělení je střední hodnota nula a rozptyl 1. :
Correct Answer: NE

Question: Spolehlivost odhadu značíme:
Correct Answer: 1–alfa

Question: Máme interval spolehlivost 95% a 90%, potom:
Correct Answer: Interval 90% je užší než 95%

Question: Kolik mezí a které/á jsou udány u jednostranných intervalů spolehlivosti?:
Correct Answer: 1-horní nebo dolní

Question: Bodovým odhadem střední hodnoty je výběrový průměr ze vzorku:
Correct Answer: ANO

Question: Pokud nemáme směrodatnou odchylku základního souboru, nemůžeme použít směrodatnou odchylku výběrového souboru:
Correct Answer: NE

Question: Odlehlé hodnoty náhodné veličiny vedou kpřesnějšímu průměru.:
Correct Answer: NE

Question: Studentovo rozdělení u intervalůspolehlivosti použijeme:
Correct Answer: Když neznáme celkový rozptyl a n<30

Question: otázka k intervalu spolehlivosti pro střední hodnotu:
Correct Answer: středem intervalu je výběrovýprůměr

Question: Nestrannost bodového odhadu spočívá v :
Correct Answer: střední hodnota je stejná jako odhadovaný parameter

Question: známe 99% interval, potom 95% bude:
Correct Answer: uzsi, bez vypoctu nelze urcit o kolik

Question: Mějme vypočítán interval spolehlivosti na základě n=50 hodnot. Jestliže zvětšíme rozsah výběru a nyní je n = 150, dostaneme:
Correct Answer: Užší interval spolehlivosti

Question: Co se stane s přesností, když se zvýší spolehlivost intervalu?:
Correct Answer: Klesá s rostoucí spolehlivostí intervalu.

Question: Který interval je spolehlivější - byly zadány 95% a 90% intervaly.:
Correct Answer: 95% interval spolehlivosti je spolehlivější než 90 %, ale ten 90 % je zase přesnější.

Question: Přesnost intervalového odhadu je nepřímo úměrná šířce intervalu spolehlivosti:
Correct Answer: ANO

Question: Při nezamítnutí hypotézy, jež je na hladině významnosti 0,05 nesprávná se dopustíme chyby:
Correct Answer: druhého řádu

Question: Pokud na hladině významnosti zamítnu nulovou hypotézu, která platí, pak se jedná o:
Correct Answer: chybu prvního druhu

Question: Kritický obor je:
Correct Answer: Podmnožina oboru hodnot testového kritéria

Question: Na posouzení váhy lidí před a po diet se použije:
Correct Answer: Párový t test

Question: K testu bylo vybráno 25 aut a naměřená spotřeba před a po výměně katalyzátorů. Pro prokázání zlepšení spotřeby po výměně použijeme:
Correct Answer: párový t-test

Question: Kdy zamítneme hypotézu H0, když alfa je 0,1:
Correct Answer: 0,08 , pokud je touto hodnotou myšlena p-hodnota

Question: Pokud zamítneme Ho: μo=μ1 oboustranným testem, potom u jednoho zjednostranných testů při stejné hladině významnosti zamítáme hypotézu:
Correct Answer: Vždy

Question: Co značí síla testu?:
Correct Answer: Pravděpodobnost zamítnutí neplatné nulové hypotézy

Question: Hladina významnosti statistické testové hypotézy je:
Correct Answer: pravděpodobnost zamítnutí nulové hypotézy, která ale platí

Question: Jak snížíme pravděpodobnost chyby 2. druhu?:
Correct Answer: Zvětšením hladiny významnosti a zvětšením vzorku

Question: Když se změní u testování alfa z 5% na 1%, tak se kritický obor:
Correct Answer: zmenší

Question: Co znamená při testování hypotéz 1-β:
Correct Answer: pravděpodobnost zamítnutí nesprávné nulové hypotézy(síla testu)

Question: Provedli jsme 25 měření před hnojením a po hnojení půdy. Jak zjistíme, jestli velikost úrody závisí na hnojení?:
Correct Answer: Testem o rovnosti středních hodnot(párový t test)

Question: Co platí pro test rovnosti středních hodnot dvou rozdělení, pokud jsou n1 a n2 větší než 30?.:
Correct Answer: Výběry nemusí být znormálního rozdělení. Protože u velkých výběrů se všechna rozdělení blíží normálnímu

Question: Kritická hodnota se vypočítala na základě výběrových údajů, zatímco hodnota testového kritéria se najde vtabulkách kvantilů některého pravděpodobnostního rozdělení
Correct Answer: NE

Question: P-hodnota 0,03. Zamítáme na hladivě významnosti 0,01 i 0,05
Correct Answer: NE

Question: Spolehlivost odhadu značíme jako 1-alfa
Correct Answer: ANO

Question: Pravděpodobnost chyby 1.druhu je větší než pravděpodobnost chyby 2.druhu.
Correct Answer: NE

Question: Testové kritérium vyčteme v tabulkách a proměnou vypočtenou z testového kritéria musíme dopočítat.
Correct Answer: NE

Question: Pomocí chí-kvadrát testu dobré shody byla naměřena p-hodnota 0,045
Correct Answer: Nezamítáme hypotézu na 1%, ale na 5% hladině ano

Question: Test dobré shody porovnává
Correct Answer: Teoretická a skutečná data

Question: Chí kvadrát test dobré shody má počet stupňů volnosti rovný počtu skupin
Correct Answer: NE

Question: Chí-kvadrát test dobré shody ověřuje rovnost hodnot v jednotlivých skupinách
Correct Answer: NE

Question: Chí-kvadrát test dobré shody je založen na srovnání pozorovaných četností a teoretických četností v jednotlivých skupinách.
Correct Answer: ANO

Question: V testu chí kvadrátu vyšlo testové kritérim -44. Co můžeme říci?
Correct Answer: bylo špatně vypočítané kritérium

Question: Při testování závislosti v kontingenční tabulce se dvě teoretické četnosti rovnají 1. V tom případě:
Correct Answer: chí-kvadrát test nemůžeme použít, protože nejsou splněny předpoklady pro jeho užití

Question: Testujeme hypotézu ... v kontingenční tabulce o rozměru (r=3; s=4)...a testové kritérium vyšlo G=-12,34:
Correct Answer: Nelze rozhodnout, zřejmě je chyba ve výpočtu testového kritéria//G nemůže být záporné číslo

Question: Máme kontingenční tabulku 3x3 a že testové kritérium vyjde 9.85 a jestli na 95 procentní významnosti můžeme potvrdit závislost.
Correct Answer: Ano, pomocí chí-testu dobré shody s 4 stupni volnosti.

Question: Zjištěné četnosti zaznamenané uvnitř kontingenční tabulky se nazývají:
Correct Answer: Sdružené

Question: U kontingenčních tabulek využijeme:
Correct Answer: Chí-kvadrát

Question: Statistika G (kontingenční tabulky) vychází vždy vintervalu <-1,1>.
Correct Answer: NE

Question: Pro použití chí-kvadrát testu předpokládáme dostatečně velké hodnoty pozorovaných četností v jednotlivých třídách.
Correct Answer: ANO

Question: Pearsonův koeficient kontingence při velmi těsné závislosti proměnných dosahuje hodnoty 1.
Correct Answer: NE

Question: Když zaměním řádky za sloupce u kontingenčních tabulek, nemá to vliv na výsledek
Correct Answer: ANO

Question: Máme 4 druhy hnojiva a knim výnosy na hektar. Pro srovnání průměrných výnosů použijeme:
Correct Answer: F-test analýzy rozptylu

Question: Jaké jsou parametry testového kritéria u F-testu když jsou 4 firmy a od každé se zkoumalo 5 žárovek.
Correct Answer: 3 a 16

Question: Chceme porovnat průměrnou dobu cestování zmísta A do místa B po třech různých trasách. Při splnění určitých podmínek požijete:
Correct Answer: F-test v analýze rozptylu

Question: Testové kritérium používané v analýze rozptyluje:
Correct Answer: závislé na počtu tříd

Question: Co testujeme při analýze rozptylu
Correct Answer: rovnost středních hodnot

Question: Jaké rozdělení má testové kritérium při analýze rozptylu?
Correct Answer: F rozdělení (Fischerovo)

Question: Chcete porovnat výkony pracovníků (tj. Počet vyrobených výrobků za směnu) ve třech směnách. Použijete:
Correct Answer: F test v analýze rozptylu

Question: Analýza rozptylu se využívá:
Correct Answer: při měření závislosti proměnné kvantitativní na proměnné kategoriální

Question: Poměr determinace u analýzy rozptylu, jak ho vypočítáme:
Correct Answer: Meziskupinový součet čtverců / celkový součet čtverců

Question: Analýzu rozptylu je možné chápat jako testování hypotézy o shodě rozptylů?
Correct Answer: NE

Question: Při analýze rozptylu porovnáváme výsledné testové kritérium skvantilem chí kvadrátu.
Correct Answer: NE

Question: Vyjde-li nám při analýze rozptylu p-hodnota 0,03, pak zamítáme nulovou hypotézu při hladinách významnosti 0,01 i 0,05.
Correct Answer: NE

Question: Testové kriterium u analýzy rozptylu konstruujeme jako podíl meziskupinového a celkového součtu čtverců.
Correct Answer: NE

Question: Při výpočtu analýzy rozptylu porovnáváme testové kriterium sF hodnotou vtabulkách (Fisher-Snedecorův kvantil)
Correct Answer: ANO

Question: Analýza rozptylu se používá při testování závislosti dvou kategoriálních proměnných?
Correct Answer: NE

Question: Těsnost závislosti vanalýze rozptylu posuzujeme pomocí korelačního koeficientu?
Correct Answer: NE

Question: Kovariance nabývá hodnot
Correct Answer: jakýchkoli reálných

Question: Metoda nejmenších čtverců je:
Correct Answer: součet čtverců reziduí

Question: Obsahem nulové hypotézy u korelační analýzy je:
Correct Answer: Nezávislost dvou kvantitativních proměnných

Question: Lineární závislost 2 veličin je vyjádřena v grafu přímkou rovnoběžnou s vodorovnou osou. Veličiny:
Correct Answer: Jsou na sobě lineárně nezávislé

Question: Korelační analýza může být využita pro zkoumání:
Correct Answer: závislosti dvou kvantitativních proměnných

Question: Komentujte následující regresně sdružené přímky: Y=5x-2 X=5-0,2y
Correct Answer: podle znamének regresních koeficientů nemůže jít o regresně sdružené přímky

Question: Bylo zkoumáno, zda cena žárovky a délka jejího svícení spolu závisí -spočteme to
Correct Answer: Párovým korelačním koeficientem

Question: Máme I² v korelační analýze, kdy je závislost nejtěsnější:
Correct Answer: I² = 0,85

Question: Kde se používá metoda nejmenších čtverců?
Correct Answer: metoda určování parametrů regresních funkcí

Question: Při t-testu(b0/s(b0)) se používá:
Correct Answer: Studentovo rozdělení

Question: Když máme rovnici Y=16–0,8x, platí, že:
Correct Answer: Korelační koeficient musí být záporný

Question: Když vyjde u regrese F-test NEVÝZNAMNÝ, tak to znamená že:
Correct Answer: daný model nepřijímáme, neexistuje regresní závislost

Question: Znám korelační koeficient r, jaký bude poměr determinace r2
Correct Answer: nelze urcit

Question: Rozdíl mezi F-testem a dílčím t-testem
Correct Answer: F test –testuje vhodnost modelu jako celku / Dílčí t testy –testují významnost jednotlivých proměnných v modelu

Question: Regresní koeficient
Correct Answer: vyjadřuje změnu závislé proměnné při jednotkové změně nezávislé proměnné

Question: Pokud do modelu přidáme další proměnné, index determinace se:
Correct Answer: zvětší se

Question: K čemu slouží upravený index determinace?
Correct Answer: k porovnání kvality modelů s odlišnými počty parametrů a penalizuje nadbytečný počet proměnných v modelu

Question: Korelační koeficient se spočítá jako:
Correct Answer: PODÍL KOVARIANCE A SOUČINU SMĚRODATNÝCH ODCHYLEK

Question: Korelační koeficient: r2=-0,8 + graf, napsat, co platí
Correct Answer: Silná nepřímá závislost

Question: Hodnoty párového korelačního koeficientu leží v intervalu:
Correct Answer: <-1 ; 1>

Question: Koeficient determinace v regresní analýze lze případně spočítat jako:
Correct Answer: druhá mocnina korelační koeficient na druhou

Question: Co je to index determinace?
Correct Answer: Poměr čtverců modelu a celkových čtverců

Question: Regresní přímka je zadána rovnicí Y=100 + 5x, co se stane se závislou proměnnou Y, když se x zvýší o 100 jednotek?
Correct Answer: Zvýší se o 500 jednotek

Question: Regresní přímka, když se všechny y zvětší o 2 a x se nezmění, co se stane?
Correct Answer: směrnice přímky se nezmění a průsečík sosou y se změní o 2

Question: Hodnota součinu sdružených výběrových regresních koeficientů bxy a byx je vždy:
Correct Answer: V intervalu <0;1>

Question: Regresní analýza vyjadřuje závislost
Correct Answer: Dvou kvantitativních proměnných

Question: Vícenásobný regresní model o 6 neznámých, 2 jsme vyřadili, koeficient determinace se:
Correct Answer: Zmenší

Question: Z regresního modelu se čtyřmi vysvětlujícími proměnnými byly dvě proměnné odebrány jako málo důležité. Potom:
Correct Answer: index determinace v menším modelu nemůže být větší než v modelu s více proměnnými

Question: Součin výběrových koeficientů sdružených regresních přímek je vždy číslo nezáporné.
Correct Answer: ANO

Question: Pomocí regrese je možné měřit závislost dvou kvantitativních proměnných
Correct Answer: ANO

Question: Jestliže je směrnice přímky záporná, tak to znamená, že je korelační koeficient záporný.
Correct Answer: ANO

Question: Jestliže do modelu přidáme další vysvětlující proměnnou, může se index determinace snížit
Correct Answer: NE

Question: Korelační koeficient je podíl reziduálního součtu čtverců na celkovém součtu čtverců
Correct Answer: NE

Question: Může být index determinace vyšší než upravený index determinace?
Correct Answer: ANO

Question: Regresní parabola je funkcí lineární z pohledu parametrů
Correct Answer: ANO

Question: Jestliže známe jeden řetězový index, co z něho můžeme vypočítat?
Correct Answer: Meziroční tempo růstu

Question: Chronologický průměr využijeme u:
Correct Answer: časových řad okamžikových

Question: Kdy používáme vážený chronologický průměr
Correct Answer: u okamzikovych časových řad, kdy mezi obdobimy je ruzne rozmezi

Question: Průměrnou hodnotu časové řady “Počet zaměstnanců kposlednímu dni měsíce”zjištěnou v r. 1990 v lednu, březnu a pak od května každý měsíc. Vypočítáme:
Correct Answer: Váženým chronologickým průměrem

Question: Jak lze převést okamžikovou měsíční časovou řadu na čtvrtletní?
Correct Answer: Vzít z měsíční ČŘ každou 3. hodnotu

Question: Průměr u čas. řad, když známe koeficienty růstu je:
Correct Answer: GEOMETRICKÝ

Question: Očištěná časová řada má:
Correct Answer: jen trendovou a náhodnou složku

Question: Průměrný koeficient růstu se vypočítá jako:
Correct Answer: geometrický průměr

Question: Při modelování sezónní složky regresní metodou do modelu:
Correct Answer: vkládáme o jednu méně sezónních umělých proměnných než je počet sezón

Question: Jaký je relativní přírůstek, když koeficient růstu = 0,85
Correct Answer: -0,1517

Question: Součet sezónních faktorů u modelu řady skonstantní sezónností je:
Correct Answer: roven nule

Question: Čtvrtletní časovou řadu očistíme od sezónnosti:
Correct Answer: Centrovanými klouzavými průměry

Question: Systematické složky vkrátkodobé časové řadě jsou pouze:
Correct Answer: trendová, sezónní, cyklická

Question: Průměrnou hodnotu časové řady je vždy vhodné vypočítat jako prostý aritmetický průměr jejich jednotlivých hodnot.
Correct Answer: NE

Question: Při modelování trendů včasových řadách pomocí regresního přístupu je vždy lepší použít kvadratickou funkci než lineární.
Correct Answer: NE

Question: Systematické složky v časové řadě jsou jen trendová a cyklická.
Correct Answer: NE

Question: Sezónní umělé proměnné jsou jen u čtvrtletních intervalů, ne u měsíčních ani ročních.
Correct Answer: NE

Question: Průměrné tempo růstu včasové řadě musí být vždy větší než jedna.
Correct Answer: NE

Question: Klouzavé průměry umožňují vyhladit průběh časové řady a naznačit její trend
Correct Answer: ANO

Question: Index spotřebitelských cen ČSÚ měří a zveřejňuje
Correct Answer: čtvrtletně

Question: Máme bazický index z roku 2010 IB=1,28 (2009 základní rok) o řetězcovém indexu za stejné období platí
Correct Answer: Je roven 1, 28

Question: V časové řadě skladnými hodnotami je hodnota jednoho z koeficientů růstu 0,85. Pak hodnota odpovídajícího relativního přírůstku (nepřevedená na %) musí být:
Correct Answer: záporná, zintervalu (-1,0)

Question: Pokud chceme porovnat ceny dvou období, použijeme:
Correct Answer: řetězový index

Question: Máme tržby za únor a březen výrobků A a B vprodejním řetězci. K zachycení změny tržeb použijeme:
Correct Answer: Hodnotový index

Question: Individuální indexy se dělí na
Correct Answer: Jednoduché a složené

Question: Pokud znáte Pascheho cenový index a Fischerův cenový index, můžete zjistit:
Correct Answer: Laspayersův cenový index (vzorec)

Question: Míra inflace je
Correct Answer: Růst cenové hladiny vyjádřený relativně

Question: Je potřeba porovnat cenu 1 výrobku ve 4 obchodech ve dvou obdobích. Použijeme:
Correct Answer: Index proměnlivého složení

Question: Jaký použijeme index pro 3 výrobky se stejným množstvím v základním období pro výpočet relativní změny ceny?
Correct Answer: Laspeyersův cenový index

Question: Mezi extenzitní ukazatele patří
Correct Answer: Množství i hodnota

Question: Jaký typ průměru je použit ve vzorci Index množství Laspeyresův:
Correct Answer: Vážený aritmetický

Question: Je hustota obyvatel ČR hodnotna extenzivní?
Correct Answer: NE

Question: Index spotřeb. cen se používá:
Correct Answer: KMĚŘENÍ INFLACE

Question: O inflaci lze např. říci, že:
Correct Answer: měří se na základě indexu spotřebitelských cen a většinou se udává v procentech

Question: Známe hodnotu jednoho výrobku v lednu a březnu v 1 prodejním řetězci. Jaký index?
Correct Answer: hodnotový

Question: K porovnání hodnot ve dvou po sobě jdoucích následujících obdobích se používá:
Correct Answer: Řetězový index

Question: Soubor reprezentantů a váhový systém indexu spotřebních cen se nazývá spotřební koš
Correct Answer: ANO

Question: Index spotřebitelských cen je zveřejňován týdně
Correct Answer: NE

Question: Je-li X spojitá náhodná veličina, pak rozdíl distribuční funkce F(x2)-F(x1) pro x1<x2 znamená:
Correct Answer: pravděpodobnost,že X nabude hodnoty z intervalu (x1,x2)

Question: Hladina významnosti testu udává
Correct Answer: pravděpodobnost, že zamítneme platnou nulovou hypotézu

Question: Míra inflace je měřena pomocí
Correct Answer: indexu spotřebitelských cen

Question: Zkoumání závislosti kvantitativního znaku na kategoriálním se opírá o rozklad variability na :
Correct Answer: meziskupinnový a vnitroskupinový součet čtverců

Question: Pro očištění denní časové řady počtu dopravních nehod od sezónní složky použijeme
Correct Answer: sedmičlenné klouzavé průměry

Question: Korelační koeficient mezi proměnnými x (vodorovná osa) a y (svislá osa) z 10 hodnot (viz obrázek) vyšel -0,8. Jaký závěr
Correct Answer: ve výpočtu je chyba. znaménko korelačního koeficientu neodpovída rozložení bodů v grafu

Question: Navýšením všech hodnot statistického znaku o konstantu se hodnota mediánu nezmění
Correct Answer: NE

Question: Reziduální součet čtverců (v regresní analýze) je definován jako součet čtverců odchylek pozorovaných hodnot od vyrovnaných hodnot vysvětlované proměnné.
Correct Answer: ANO

Question: Závislost dvou znaků v kontingenční tabulce se projeví vyšší hodnotou testové statistiky příslušného testu
Correct Answer: ANO

Question: Velká variabilita hodnot v základním souboru snižuje přesnost odhadu jejich střední hodnoty
Correct Answer: ANO

Question: Chronologický průměr se používá při analýze intervalových časových řad
Correct Answer: NE

Question: Hodnota medíánu Studentova rozdělení je vždy rovna nule
Correct Answer: ANO

Question: Váhový systém indexu spotřebitelských cen se stanoví na základě údajů: (mby spatne)
Correct Answer: vztahujících se k běžnému období a je stálý po celou dobu platnosti indexu

Question: V případě nezávislosti sledované veličiny na třídícím faktoru ve výběrovém souboru je
Correct Answer: meziskupinová variabliita rovna nule

Question: Součet sezónních odchylek u aditivního modelu časových řad je roven:
Correct Answer: nule

Question: Na základě náhodného výběru máme rozhodnout, zda podíl kuřáků v populaci přesahuje určité procento. Je-li jich ve vzorku o rozsahu 1 000 zjištěno 300, potřebujeme znát:
Correct Answer: hladinu významnosti

Question: Pro normální rozdělení platí
Correct Answer: střední hodnota a medián se rovnají

Question: Extenzitní veličiny lze vždy shrnovat součtem
Correct Answer: NE

Question: Testové kritérium G, které se používá k ověření nezávislosti v kontingenční tabulce nabývá vždy pouze nezáporných hodnot
Correct Answer: ANO

Question: Výběrový rozptyl je možné použít jako bodový odhad rozptylu v základním souboru
Correct Answer: ANO

Question: Chronologický průměr se používá při výpočtů průměrného tempa růstu
Correct Answer: NE

Question: 50% kvantil (medián) výběrových hodnot x se nemůže rovnat 75% kvantilu ( hornímu kvartilu ) těchto hodnot
Correct Answer: NE

Question: Teoretický součet čtverců (v regresní analýze) je definován jako součet čtverců odchylek vyrovnaných hodnot od průměrné hodnoty vysvětlované proměnné
Correct Answer: ANO

Question: Zkonstruujeme oboustranný 95% a 99% interval spolehlivosti pro střední hodnotu z výběru. 99% interval spolehlivosti bude:
Correct Answer: vždy širší než 95% interval spolehlivosti, nelze však bez výpočtu určit o kolik

Question: korelační koeficient
Correct Answer: vyjadřuje sílu lineární závislosti

Question: Lze za určitých předpokladů aproximovat kvantily t-rozdělení pomocí kvantilů normovaného normálního rozdělení?
Correct Answer: ano, u dostatečně velkého výběru (n>30)

Question: V rámci výzkumu byla u 25 aut zjištěna spotřeba paliva před provedením celkové opravy. chceme-li posoudit, zda oprava přispěla ke snížení spotřeby, použijeme:
Correct Answer: párový t-test

Question: K porovnání hodnot veličiny ve dvou po sobě následujících obdobích se používá
Correct Answer: řetězový index

Question: Kritický obor a obor přijetí se mohou částečně překrývat
Correct Answer: NE

Question: Soubor reprezentantů a váhový systém indexu spotřebitelských cen se nazývá spotřební koš
Correct Answer: ANO

Question: Násobíme-li všechny váhy při výpočtu váženého aritmetického průměru konstantou, průměr se nezmění
Correct Answer: ANO

Question: Těsnost závislostí v analýze rozptylu posuzujeme pomocí korelačního koeficientu
Correct Answer: NE

Question: Hodnota kritéria MSE používaného v časových řadách
Correct Answer: nemůže být nikdy záporná

Question: Model vícenásobné regrese se třemi vysvětlujícími proměnnými rozšíříme o další dvě proměnné. Potom index determinace:
Correct Answer: nikdy neklesne

Question: Testujeme hypotézu o nezávislosti v kontingenční tabulce s dvěma sloupci a třemi řádky na hladině významnosti 0,05. Rozsah výběru je 150 pozorování. Hodnota testového kritéria vyšla záporná a je rovna G = -5,98. Hypotézu o nezávislosti za těchto podmínek.
Correct Answer: nelze rozhodnout, zjevně je chyba ve výpočtu testového kritéria

Question: Metoda nejmenších čtverců
Correct Answer: minimalizuje součet čtverců reziduí

Question: Testové kritérium
Correct Answer: nikdy nemůže vyjít menší než rozptyl náhodného výběru

Question: U jednotlivých výrobků jsme zjistili hodnotu individuálních cenových indexů ve výši 1,25 1,36 1,48 1,21 1,42. Paascheho cenový index za tyto výrobky nemůže být
Correct Answer: 1,41

Question: Intervaly spolehlivosti mohou být konstruovány buď jako jednostranné, nebo oboustrané
Correct Answer: ANO

Question: Desetiprocentní kvantil normovaného normálního rozdělení je vždy záporné číslo
Correct Answer: ANO

Question: V analýze rozptylu rozkládáme celkovou variabilitu na modelovou a meziskupinovou
Correct Answer: NE

Question: Jestliže v kontingenční tabulce prohodíme řádky a sloupce, výsledek testu nezávislosti to neovlivní
Correct Answer: ANO

Question: Průměrný koeficient růstu lze vypočítat jako aritmetický průměr koeficientu růstu
Correct Answer: NE

Question: Je-li korelační koeficient mezi veličinami X,Y záporný, index determinace je kladný
Correct Answer: NE

Question: Poměr determinace se používá v analýze rozptylu, index determinace v regresní analýze
Correct Answer: ANO

Question: Přesnost odhadu je (při dané spolehlivosti) přímo úměrná šířce intervalu spolehlivosti
Correct Answer: NE

Question: Souhrnný Laspeyersův cenový index lze vypočítat jako podíl průměrných cen v běžném období a vzákladním období
Correct Answer: NE

Question: Hodnota mediánu studentova rozdělení je vždy menší než nula
Correct Answer: NE

Question: Směrodatná odchylka konstanty je rovna nule
Correct Answer: ANO

Question: Pro použití chí-kvadrátu testu dobré shody musí být dodržena podmínka týkající se dostatečně velkých napozorovaných (empirických) četností v jednotlivých skupinách
Correct Answer: NE

Question: Při vyčerpávajícím šetření je prošetřena jen malá část jednotek statistického souboru
Correct Answer: NE

Question: Při výpočtu Paascheho cenového indexu používáme vážený harmonický průměr jednoduchých cenových indexů, kde vahami je hodnota produkce z běžného období
Correct Answer: ANO

Question: Při výběru vhodného regresního modelu vyšší index determinace vždy značí vhodnější regfresní model
Correct Answer: NE

Question: Chronologický průměr se používá při analýze okamžikových časových řad
Correct Answer: ANO

Question: Pomocí rozptylu měříme, jak velké je kolísání hodnot kolem průměru
Correct Answer: ANO

Question: Jestliže od náhodné veličiny s normálním rozdělením odečteme její střední hodnotu a tento rozdíl vydělíme rozptylem náhodné veličiny, dostaneme novou náhodnou veličinu se střední hodnotou 1 a rozptylem 1
Correct Answer: NE

Question: Pomocí hodnoty korelačního koeficientu se stanovuje intenzita
Correct Answer: Vzájemné lineární závislosti dvou kvantitativních proměnných

Question: Která posloupnost hodnot může představovat hodnoty distribuční funkce, nabývá-li náhodná veličina celočíselných hodnot v intervalu <1;6> ?
Correct Answer: 0,15 0,35 0,75 0,8 0,9 1

Question: Testové kritérium používané v analýze rozptylu:
Correct Answer: je závislé na celkovém počtu pozorování

Question: Nulová hypotéza byla zamítnuta na 5% hladině významnosti. Potom:
Correct Answer: lze tuto nulovou hypotézu rovněž zamítnout na 10% hladině významnosti

Question: Sezónně očištěná časová řada zahrunje:
Correct Answer: trendovou, cyklickou a náhodnou složku

Question: Analýza kontingenční tabulky se používá pro zkoumání:
Correct Answer: Závislosti dvou kategoriálních proměnných

Question: Je-li regresní koeficient byx záporný, sdružený regresní koeficient bxy musí být také záporný
Correct Answer: ANO

Question: P-hodnota pro chí-kvadrát test dobré shody je rovna 0,03. Potom zamítneme nulovou hypotézu na hladinách významnosti 0,01 i 0,05.
Correct Answer: NE

Question: Centrované klouzavé průměry použijeme při očištění od sezónnosti u časových řad měsíčních údajů
Correct Answer: NE

Question: Medián je citlivý na extrémní hodnoty v souboru dat
Correct Answer: NE

Question: Představu o nezávislosti veličin v kontingenční tabulce můžeme získat tak, že sdružené četnosti vydělíme celkovým rozsahem souboru
Correct Answer: ANO

Question: Extenzitní veličiny lze někdy shrnovat součtem
Correct Answer: ANO

Question: Jaký je vztah mezi výsledkem celkového F-testu o modelu a dílčího t-testu o směrnici, je-li hodnocenou regresní funkcí přímka?
Correct Answer: neliší se, testují totéž

Question: Chronologický průměr se používá pro výpočet
Correct Answer: průměru hodnot okamžikové časové řady

Question: Máte k dispozici 95% oboustranný interval spolehlivosti a 90% oboustranný interval spolehlivosti pro střední spotřebu elektrické energie domácnosti ze stejného výběru. Pak platí:
Correct Answer: 95% interval je širší než 90% interval

Question: Která z následujících funkcí je pravděpodobnostní funkcí náhodné veličiny s definičním oborem daným hodnotami 1, 2 a 3 ?
Correct Answer: P1=0,2 P2=0,4 P3=0,4

Question: Chcete porovnat průměrné mzdy ve třech podnicích na základě výběrového šetření. Při splnění určitých podmínek použijete:
Correct Answer: F-test v analýze rozptylu

Question: Dělením dvou po sobě jdoucích bazíckých indexů lze získat hodnotu řetězového indexu
Correct Answer: NE

Question: Počet stupňů volnosti při stanovení kritické hodnoty chí-kvadrát testu dobré shody je roven počtu tříd
Correct Answer: NE

Question: Pravděpodobnost chyby prvního druhu může být větší, rovna nebo menší než pravděpodobnost chyby druhého druhu
Correct Answer: ANO

Question: Ve firmě, kde mzdy všech zaměstnanců nejsou stejně, pokles mezd o 10% sníží rozptyl mezd o 19%
Correct Answer: ANO

Question: Nulová hypotéza při testování nezávislosti v kontingenční tabulce předpokládá, že se sdružené pozorované četnosti rovnají teoretickým četnostem
Correct Answer: ANO

Question: Při výpočtu intervalu spolehlivosti pro relativní četnost základního souboru můžeme použít kvantily rozdělení chí-kvadrát
Correct Answer: NE

Question: Zahrnutím další vysvětlující proměnné do lineárního regesního modelu se hodnota indexu determinace
Correct Answer: nesníží

Question: V případě roční časové řady můžeme z hodnoty řetěžového indexu v daném období bez dalších informací odvodit:
Correct Answer: meziroční tempo růstu v procentech v daném období

Question: Testové kritérium s rozdělením chí-kvadrát se používá pro posouzení závislosti:
Correct Answer: mezi dvěma kategoriálními proměnnými

Question: Metoda nejmenších čtverců slouží:
Correct Answer: k odhadu parametrů regresní funkce

Question: Oboustranný 95% interval spolehlivosti pro střední hodnotu:
Correct Answer: neobsahuje skutečnou střední hodnotu základního souboru s pravděpodobností 0,95

Question: Binomické rozdělení je příkladem rozdělení spojitých náhodných veličin.
Correct Answer: NE

Question: Index spotřebitelských cen je cenový index Laspeyresova typu.
Correct Answer: ANO

Question: Prostřední decil rozděluje obor hodnot znaku na dvě stejné četné části
Correct Answer: NE

Question: Pravděpodobnost chyby 2. druhu lze určit pouze na základě znalosti alfa (hladiny významnosti)
Correct Answer: NE

Question: Chronologický průměr se používá při výpočtu průměrného tempa růstu.
Correct Answer: NE

Question: Kovariance může nabývat jen hodnot z intervalu <0;1>
Correct Answer: NE

Question: Výběrové šetření je takový druh šetření, při kterém jsou šetřeny všechny jednotky ze základního souboru.
Correct Answer: NE

Question: Binomické rozdělení je vhodným rozdělením, pokud se jedná o nezávislé náhodné pokusy.
Correct Answer: ANO

Question: Laspeyresův souhrnný cenový index se počítá na základě objemu (množství) pouze ze základního? období.
Correct Answer: ANO

Question: Variační koeficient nabývá vždy hodnoty od nuly do jedné
Correct Answer: NE

Question: Není-li podmínka chí-kvadrát testu o dostatečně velkých teoretických četnostech splněna, není možné sloučit věcně související skupiny.
Correct Answer: NE

Question: Při výpočtu Laspeyeresova cenového indexu používáme vážený aritmetický průměr, kde vahami je hodnota produkce z běžného období.
Correct Answer: NE

Question: Průměrnou hodnotu časové řady je vždy vhodné vypočítat jako prostý aritmetický průměr jejích jednotlivých hodnot
Correct Answer: NE

Question: Podstatou testu nezávislosti v kontingenční tabulce je porovnávání očekávaných četností a tabulkových hodnot kvantilů rozdělení chí-kvadrát.
Correct Answer: ANO

Question: Normované normální rozdělení má vždy střední hodnotu 0 a směrodatnou odchylku 1.
Correct Answer: ANO

Question: Normální rozdělení má vždy střední hodnotu 0 a směrodatnou odchylku 1.
Correct Answer: NE

Question: Testové kritérium vypočítané při analýze rozptylu je porovnáváno s hodnotou kvantilů pro F ( Fisherovo-Snedecorovo) rozdělení.
Correct Answer: ANO

Question: Průměrný koeficient růstu může být menší než 1.
Correct Answer: ANO

Question: Koeficient spolehlivosti odhadu se značí 1-alfa.
Correct Answer: ANO

Question: U regresních funkcí lineárních v parametrech je součet odchylek skutečných poznaných hodnot závisle proměnné od vyrovnaných hodnot odhadnutého modelu vždy kladný.
Correct Answer: NE

Question: Očekávané četnosti vypočtené v jednotlivých polích kontingenční tabulky odpovídají hypotéze o závislosti 2 zkoumaných znaků.
Correct Answer: ANO

Question: Testové kritérium má vždy nějaké tabelované hodnoty.
Correct Answer: ANO

Question: Při přidání dalších vysvětlujících proměnných do regresní funkce se index determinace:
Correct Answer: nesníží

Question: Náhodné hodnoty distribuční funkce se pohybují v intervalu
Correct Answer: <0;1>

Question: Máme bazické indexy HDP 2003-2011. Co můžeme dalšího z toho získat.
Correct Answer: bazický index roku 2009 se základem v roce 2006

Question: Máme 5 žárovek. Zkoumáme závislost výrobce na živostnosti žárovek (v hodinách). Použijeme
Correct Answer: jednofaktorovou analýzu rozptylu

Question: Průměrná hmotnost balíčku sýra je 150g a medián 135g
Correct Answer: prodávané balíčky jsou většinou menší, než je průměrná hmotnost

Question: Pravdivý výrok ohledně oboustranného intervalu spolehlivosti pro střední hodnotu:
Correct Answer: je symetrický podle průměru naměřených hodnot

Question: Chceme zjistit průměrnou cenu jednoho výrobku ve čtyřech prodejnách v běžném období vzhledem k základnímu období. Jaký index použijeme?
Correct Answer: index proměnlivého složení

Question: Cena za najemné se zvýšila o 1350kč všem nájemcům. Jak se změní rozptyl a variační koeficient?
Correct Answer: Nezmění. Vx klesne

Question: Pomocí chí-kvadrátu můžeme porovnat
Correct Answer: empiricky zjištěné a naměřené hodnoty

Question: Ve vícenásobném regresním modelu o šesti parametrech jsme dva parametry vyřadili. Jak se změní koeficient determinace?
Correct Answer: zmenší se

Question: Kontingenční tabulka se může použít na testování nezávislosti dvou kvalitativních znaků
Correct Answer: ANO

Question: Při testování hypotézy o regresních parametrech (bi/s(bi)) se používá studentovo t-rozdělení
Correct Answer: ANO

Question: Test ANOVA se používá při testování analýzy rozptylu
Correct Answer: NE

Question: Máme-li u25, můžeme vypočítat dolní kvantil každého normálního rozdělení
Correct Answer: ANO

Question: Při přeměřování každé časové řady se využívá aritmetický průměr
Correct Answer: NE

Question: MSE slouží k
Correct Answer: odhadům parametrů regresní funkce

Question: Z 10 hodnot máme korelačním koeficientem vypočítanou a graficky znázorněnou závislost mezi znaky x (vodorovná osa) a y (svislá osa) 0,8. Rozhodněte, co platí: (je tam klesající značení regrese)
Correct Answer: ve výpočtu korelačního koeficientu je chyba, protože znaménko

Question: Stanovena chyba odhadu 4 %. Který interval to nesplňuje?
Correct Answer: (40 %, 49 %)

Question: Chceme vypočítat průměr … v ČR a známe hustotu obyvatelstva a počet obyvatel v jednotlivých okresech, co použijeme pro výpočet?
Correct Answer: vážený aritmetický průměr

Question: Měsíční intervalovou časovou řadu převedeme na čtvrtletní
Correct Answer: součtem hodnot za 3 měsíce

Question: Fischerův index vypočítáme pomocí aritmetického průměru.
Correct Answer: NE

Question: Poměr determinace se spočítá jako podíl meziskupinového a vnitroskupinového součtu čtverců.
Correct Answer: NE

Question: Studentovo t-rozdělení má medián roven nule.
Correct Answer: ANO

Question: Centrovanými klouzavými průměry očišťujeme roční časové řady.
Correct Answer: NE

Question: inflace je míra zvýšení cen vyjádřená absolutně
Correct Answer: NE

Question: pokud časová řada začíná i končí stejným číslem pak průměr 1. dif. je vždy 0
Correct Answer: ANO

Question: pravděpodobnost chyby 1. druhu je vyšší než pravděpodobnost chyby II. druhu
Correct Answer: NE

Question: V klasickém regresním lineárním modelu y = β0 + β1 + ε
Correct Answer: Absolutní hodnota korelačního koeficientu je druhá mocnina indexu determinace

Question: Vyšlo nám testové kritérium G = 7 (už nevím), pak na hladině významnosti 0,05 testovanou hypotézu:
Correct Answer: Nezamítáme, protože Chí kvadrát s 9 stupni volnosti má kvantil 16,9

Question: Známe-li bazický index roku 2010 se základem v roce 2009
Correct Answer: Můžeme spočítat bazický index roku 2009

Question: Míru těsnosti závislosti v analýze rozptylu měříme indexem determinace.
Correct Answer: NE

Question: Test hypotézy o regresních parametrech s testovaným kritériem b0 / sb0 využívá Fischerovo rozdělení
Correct Answer: NE

Question: Pro použití Chí-kvadrát-testu může můžou četnosti nabývat maximálně hodnoty 5
Correct Answer: NE

Question: Při normálním rozdělení se medián rovná střední hodnotě:
Correct Answer: ANO

Question: Kdy používáme t Studentovo rozdělení pro zjištění střední hodnoty?
Correct Answer: Když máme normální rozdělení a malý výběr (n<30)

Question: Když máme rovnici: Y = 35 - 18X
Correct Answer: Korelační koeficient musí být záporný

Question: Vztah mezi řetězovými a bazickými indexy
Correct Answer: Násobením po sobě jdoucích řetězových indexů dostaneme bazické

Question: Sezónní složka se vyskytuje pouze u čtvrtletních časových řad a nikoli u měsíčních.
Correct Answer: NE

Question: Na měření inflace užíváme index spotřebitelských cen
Correct Answer: ANO

Question: Při testování hypotéz dopočítáme testové kritérium z hodnot výběrového souboru a kritickou hranici vyčtěme z tabulek z
Correct Answer: ANO

Question: Při modelování trendů v ČŘ pomosí regresního přístupu je vždy lepším modelem trendu trend parabolický nežli trend přimkový.
Correct Answer: NE

Question: Testové kritérium vypočítané při analýze rozptylu je porovnáváno s Chí-kvadrantem
Correct Answer: NE

Question: Pomocí regrese je možné měřit závislost dvou kvantitativních proměnných
Correct Answer: ANO

Question: P-hodnota 0,03 ... zamítáme na hladině významnosti 0,01 i na 0,05
Correct Answer: NE

Question: co se stane s rozptylem a variačním koeficientem, když se všechna x zvýší o 20 %?
Correct Answer: rozptyl vzroste o 44 % a variační koeficient se nezmění

Question: Hladina významnosti je pravděpodobnost správného zamítnutí H0 při platnosti H1
Correct Answer: NE

Question: Chí kvadrát test dobré shody má počet stupňů volnosti rovný počtu měření minus počet tříd
Correct Answer: NE

Question: Regresní přímka je zadána rovnicí Y=100 + 5x, co se stane se závislou proměnnou Y, když x=100?
Correct Answer: zvýší se o 500 jednotek

Question: V lednu byly naměřeny záporné hodnoty °C, rozptyl bude:
Correct Answer: kladný

Question: Kvantil t rozdělní 0.05 (to znamená alfa je 5%) je vždy:
Correct Answer: záporný

Question: Rozptyl můžeme rozložit na meziskupinovou složku a modelovou
Correct Answer: NE

Question: Soubor produktů a indexů spotřebitelských cen se nazývají spotřebitelský koš.
Correct Answer: ANO

Question: Pokud je náhodná veličina X spotřebou auta na 100 km, potom F(8) - F(6) znamená:
Correct Answer: při jedné náhodné 100 km jízdě bude spotřeba mezi 6 a 8

Question: Index determinace (je to koeficient determinace taky) popisuje:
Correct Answer: variabilitu nejspíš (mám v tom teď guláš :D)

Question: Co je to 1-beta? (je to správné rozhodnutí druhého druhu)
Correct Answer: zamítnutí H0, platí li H1

Question: když změníme řadu čísel o konstantu, medián se nezmění:
Correct Answer: NE

Question: Zvýší-li se interval spolehlivosti (spolehlivost odhadu), co se stane s přesností?
Correct Answer: zmenší se

Question: Pro všechny stupně volnosti χ0,20 platí, že:
Correct Answer: χ0,20 > 0

Question: Každý měsíc neměříme inflaci:
Correct Answer: meziroční

Question: Bodovým odhadem je výběrový průměr ze vzorku.
Correct Answer: ANO

Question: Pokud zamítáme hypotézu o α=0,05, příjímáme hypotézu o α=0,01.
Correct Answer: NE

Question: Binomické rozdělení využijeme u nespojitých veličin.
Correct Answer: ANO

Question: Variační koeficient:
Correct Answer: relativní ukazatel míry variability

Question: Oboustranný interval spolehlivosti pro pravděpodobnost koupě výrobku n 150 pozorování. Pokud zůstanou všechny vstupní údaje beze změny a zvětšíme rozsah výběru n‘=400 dostaneme:
Correct Answer: užší interval spolehlivosti

Question: Celkový F – test a dílčí t – test u regresního modelu – přímka. Jak je to s testy:
Correct Answer: žádný rozdíl, testují v tomto případě to samé

Question: Index determinace u regrese:
Correct Answer: podíl teoretického a celkového součtu čtverců

Question: Hladina významnosti je doplněk chyby II. druhu do jedné.
Correct Answer: NE

Question: časové řady – pro výpočet průměrného koeficientu růstu nemusíme znát všechny hodnoty časové řady
Correct Answer: ANO

Question: analýza rozptylu – když vypočítám testové kritérium, pak v tabulkách najdu hodnotu pro kvantil Fischerova rozdělení (F1-α)
Correct Answer: ANO

Question: Symetrické rozdělení
Correct Answer: Studentovo a normální

Question: Sdružené četnosti v kontingenční tabulce
Correct Answer: Jsou sdruženými četnostmi dvou objektů (nebo tak něco)

Question: Pokud zamítneme hypotězu Ho na 5 procentní hladině významnosti potom
Correct Answer: Vždy zamíntneme i na 10 % hladině význanosti

Question: 10 procentní kvartil normalního rozdělení je vždy záporný
Correct Answer: ANO

Question: Teoretický/regresní součet čtverců je součet čtvercových odchylek vyrovnaných hodnot od průměrné hodnoty
Correct Answer: ANO

Question: Pří vyběrovém šetření zjištujeme udaje z vyběrového souboru
Correct Answer: ANO

Question: Kritický obor u testového kritéria v kontingenční tabulce je oboustranný, pravostranný a levostranný
Correct Answer: NE

Question: Pomocí chí-kvadrát testu byla naměřena hodnota 0,045
Correct Answer: Nezamítáme na 1%, ale na 5% zamítáme

Question: Závislost dvou hodnot v regresi vypočítáme pomocí:
Correct Answer: párového testu korelačního koeficientu

Question: Zadány 2 regresní přímky Y= x- 5 a X= 2x – 6 (čísla vymyšlena)
Correct Answer: podle znamének regresních koeficientů nemůže jít o regresně sdružené přímky

Question: U normálního rozdělení
Correct Answer: se střední hodnota a medián rovnají (protože normální rozdělení je symetrické)

Question: Když máme rovnici Y = 16 – 0,8 x (tie čísla som si vymyslela, ale bolo tam „mínus“), platí, že:
Correct Answer: Koleční koeficient musí být záporný

Question: Podmínkou pro využití chí-kvadrátu je dostatočné obsazení ve všech skupinách
Correct Answer: NE

Question: Považujme výšku postavy za spojitou náhodnou veličinu se střední hodnotou 178. Pak pravděpodobnost, že výška náhodně vybrané osoby je 178 cm
Correct Answer: je tak malá, že ji považujeme za nulovou

Question: Analýza rozptylu se používá pro
Correct Answer: zjištění závislosti kvantitativní proměnné na kategoriální proměnné

Question: Pokud je hodnota koeficientu růstu rovna číslu 1, znamená to, že
Correct Answer: nedošlo k žádné změně

Question: Výběrové šetření je takový druh šetření, při kterém jsou šetřeny jen některé jednotky ze základního souboru
Correct Answer: NE

Question: Statistická definice pravděpodobnosti je založena na velkém množství nezávislých opakování téhož náhodného pokusu
Correct Answer: ANO

Question: Síla testu je doplněk hladiny významnosti do jedné
Correct Answer: NE

Question: Pokud je první hodnota časové řady stejná jako poslední hodnota časové řady je průměrný absolutní přírůstek této časové řady roven nule
Correct Answer: ANO

Question: Individuální složené indexy používáme v případě nestejnorodých ukazatelů
Correct Answer: NE

Question: Členění na indexy množství a úrovně vychází z typu posuzovaného ukazatele
Correct Answer: ANO

Question: Pokud snížíme všem zaměstanncům firmy mzdu o tisíc Korun, potom směrodatná odchylka mezd v této firmě poklesne také o tisíc korun
Correct Answer: NE

Question: S růstem spolehlivosti intervalového odhadu roste přčesnost odhadu
Correct Answer: NE

Question: Podmínkou korektního užití chí-kvadrát testu dobré shody je vytvoření alespoň 5 tříd
Correct Answer: NE

Question: Fisherův index je aritmetickým průměrem Laspeyersova a Paascheho indexu
Correct Answer: NE

Question: U souboru 140 bytů s různou výší nájemného bylo nájemné jednotně zvýšeno o 20%. Jak se změní rozptyl a variační koeficient nájemného?
Correct Answer: rozptyl vzroste o 44%, variační koeficient se nezmění

Question: Obsahem nulové hypotézy v ANOVĚ je
Correct Answer: nezávislost kvantitativní proměnné na kategoriální

Question: Směrodatná odchylka souboru je ve čtvercích jednotek, ve kterých jsou uvedeny původní hodnoty souboru
Correct Answer: NE

Question: Binomické rozdělení je vhodným modelem, pokud se jedná o závislé náhodné pokusy
Correct Answer: NE

Question: Při nezávislosti dvou kategoriálních proměnných se sdružené teoretické četnosti rovnají součinu marginálních četností (v příslušném řádku a sloupci) děleném rozsahem souboru
Correct Answer: ANO

Question: Míra inflace se rozumí změna cenové hladiny vyjádřena absolutně
Correct Answer: NE

Question: Podmínkou korektního užití chí-kvadrát testu dobré shody je
Correct Answer: očekávané četnosti jednotlivých kategorií jsou alespoň 5

Question: Pro očištění denní časové řady počtu dopravních nehod od sezónní složky použijeme
Correct Answer: prosté klouzavé průměry délky 7

Question: Zahrnutím další vysvětlující proměnné do lineárního regresního modelu se hodnota indexu determinace může snížit
Correct Answer: NE

Question: Sezónní složka se vyskytuje pouze ve čtvrtletních ekonomicých časových řadách a nikoliv v měsíčních ekonomických časových řadách
Correct Answer: NE

Question: Souhrnný Laspeyresův cenový index lze vypočítat jako podíl průměrných cen v běžném období a v základním období
Correct Answer: NE

Question: Testová statistika používaná při analýze nezávislosti v kontingenční tabulce má za předpokladu platnosti testovan
Correct Answer: Chí-kvadrát rozdělení (neznám celou otázku ale v kontingenční tabulce se využívá chí-kvadrát takže asi tohle :-))

Question: Součet odchylek pozorovaných hodnot od jejich aritmetického průměru
Correct Answer: je vždy roven nule

Question: Pro distribuční funkci F(x) platí
Correct Answer: 0<=F(x)<=1

Question: Šířka oboustranného intervalu spolehlivosti pro střední hodnotu
Correct Answer: klesá s rostoucím rozsahem výběru

Question: Regresní koeficient b1 v odhadnuté rovnici lineární regrese b0 + b1x může nabýt
Correct Answer: libovolné hodnoty

Question: Jestliže známe hodnoty Paascheho cenového indexu a Fisherova cenového indexu, můžeme z nich spočítat
Correct Answer: laspeyresův cenový index

Question: Aritmetický průměr je citlivý na extrémní hodnoty v souboru dat
Correct Answer: ANO

Question: Chronologický průměr se používá k výpočtu průměrné hodnoty intervalových časových řad
Correct Answer: NE

Question: Mírou inflace se rozumí změna cenové hladiny vyjádřena absolutně
Correct Answer: NE

Question: Délka periody sezónnosti u čtvrtletní časové řady je 3
Correct Answer: NE

Question: za Odrinální ( Pořadovou ) proměnnou je možné považovat
Correct Answer: nejvyšší dosažené vzdělání

Question: Pro popis regresní závislosti byla použita přímka. Potom pro hodnoty kovariance parametru byx platí
Correct Answer: Sxy>0, potom je byx kladný

Question: K odstranění sezónní složky ve čtvrtletní časové řadě HDP je nejvhodnější použít
Correct Answer: centrované klouzavé průměry

Question: V pěti prodejnách určitého prodejní řetězce došlo ke změně tržby oproti předcházejícímu období v procentech následovně +15, -3, +11, +8, -11. Která z hodnot indexu celkových tržeb za všech 5 prodejen není možná?
Correct Answer: 0,88

Question: Očekávané četnosti se budou od pozorovaných četností v příslušných polích kontingenční tabulky lišit tím méně, čím silnější je závislost mezi zkoumanými znaky
Correct Answer: NE

Question: Klouzavé průměry lze využít k vyhlazení časové řady a k zachycení jejího dlouhodobého vývoje
Correct Answer: ANO

Question: Mírou inflace se rozumí změna spotřebního koše vyjádřena relativně
Correct Answer: ANO

Question: Při analýze rozpylu meziskupinového rozptylu závisí na počtě skupin
Correct Answer: ANO

Question: V kvantilu s indexem 0.25 (U0.25) můžeme určit hodnotu dolního kvartilu libovolného normálního rozdělení, známe-li jeho parametry.
Correct Answer: ANO

Question: Kontingenční tabulka umožňuje testování existence vztahu mezi 2 znaky v klasickém regresivním modelu. y=b0 + b1*x+E máte testové kritérium b0=S(b0) studentovo t rozdělení
Correct Answer: ANO

}
