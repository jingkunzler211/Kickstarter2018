

#import kickstarter 2018 data
ks.projects.201801 <- read.csv("C:/Users/jingk/OneDrive/Desktop/CIS 9557/ks-projects-201801.csv",
                               stringsAsFactors = FALSE)

##remove id, name, currency, goal, pledged, because only usd goal & pledged matter

ks1 <- ks.projects.201801[-c(1,2,5,7,9)]
View(ks1)

##seems that some usd pledged values can be different from usd pledged real, thus remove usd pledged
ks2 <- ks1[-8]
View(ks2)

class(ks2$deadline)

##convert dates from character to date format
ks2$deadline <- as.Date(ks2$deadline)
ks2$launched <- as.Date(ks2$launched)

View(ks2)

##remove non-us data, aka subsetting only us data
ks3 <- subset(ks2, country == "US", select = c("category", "main_category", "deadline",
                                              "launched","state","backers",
                                              "usd_pledged_real","usd_goal_real"))
View(ks3)

##adding a column called dollar_difference = usd_pledged_real - usd_goal
## so that positive values and 0 means the project was successful, and
## negative values mean the project was by all means unsuccessful (failed or canceled)

ks3$dollar_difference = ks3$usd_pledged_real - ks3$usd_goal_real

##adding a column called length (in days) = deadline - launched

ks3$length <- difftime(ks3$deadline, ks3$launched, units = "days")

##creating new csv file called ksfinal using ks3
write.csv(ks3,"C:/Users/jingk/OneDrive/Desktop/CIS 9557/ksfinal.csv")
