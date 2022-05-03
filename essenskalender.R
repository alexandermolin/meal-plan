# read colnames from txt:
colnames_from_txt <- function(name_of_file){
  return(scan(file = name_of_file, what = character(), nlines = 1, sep = ";"))
}

data_from_txt <- function(name_of_file, names_of_columns){
  return(matrix(scan(file = name_of_file, skip = 0, what = character(), sep = ";"),
                ncol = length(names_of_columns),
                byrow = TRUE))
}

cnames_rez <- colnames_from_txt("GitHub/meal-plan/rezepte.csv")
rezepte <- as.data.frame(data_from_txt("GitHub/meal-plan/rezepte.csv", cnames_rez))
colnames(rezepte) <- cnames_rez
rezepte <- rezepte[-1,]
rezepte$Morgen <- as.logical(rezepte$Morgen)
rezepte$Mittag <- as.logical(rezepte$Mittag)
rezepte$Abend <- as.logical(rezepte$Abend)
rezepte$Fleisch <- as.logical(rezepte$Fleisch)
rezepte$Fisch <- as.logical(rezepte$Fisch)


fruedat <- sample(rezepte[,1][rezepte[,"Morgen"]==TRUE], 7, replace = TRUE)
mittagdat <- sample(c(sample(rezepte[,1][rezepte[,"Mittag"]==TRUE &
                                  rezepte[,"Fleisch"]==FALSE &
                                  rezepte[,"Fisch"]== FALSE], 5, replace = TRUE),
                      sample(rezepte[,1][rezepte[,"Mittag"]==TRUE &
                                           rezepte[,"Fleisch"]==TRUE &
                                           rezepte[,"Fisch"]== FALSE], 1, replace = TRUE),
                      sample(rezepte[,1][rezepte[,"Mittag"]==TRUE &
                                    rezepte[,"Fleisch"]==FALSE &
                                    rezepte[,"Fisch"]== TRUE], 1, replace = TRUE)),
                      7, replace = FALSE)
abenddat <- sample(rezepte[,1][rezepte[,"Abend"]==TRUE], 7, replace = TRUE)

#wiederholungen reduzieren:
#drop_alle_fruehstueck <- drop_alle_fruehstueck[drop_alle_fruehstueck %in% fruehstueck == FALSE]

menueplan <- c(fruedat, mittagdat, abenddat)
menueplan 


StartDate <- format(Sys.Date(), "%d.%m.%y")
for (i in 1:7){
  StartDate <- c(StartDate, format(Sys.Date()+i, "%d.%m.%y"))
}
StartDate <- StartDate[-1]


file_for_cal_import <- data.frame(menueplan, StartDate, menueplan, rep(c("7:00","13:00","17:00"), each = 7))
namens <- c("Subject", "Start date", "description", "Start time")
colnames(file_for_cal_import) <- namens

for (j in 1:length(file_for_cal_import$Subject)){
  file_for_cal_import$description[j] <- rezepte$Rezept[rezepte$Titel == file_for_cal_import$Subject[j]]
}

write.csv(file_for_cal_import, "essensplan_für_cal_import.csv", row.names = FALSE, quote = TRUE)

rm(list = ls())
gc()

