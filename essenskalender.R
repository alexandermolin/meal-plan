

alle_fruehstueck <- c("Apfel und Hirsebrei", "Apfel und Griesbrei","Apfel und Mehrkornerbrei", "Apfel und Haferbrei",
                     "Fruchtmixshake-SChlemmerfruhstuck", "Obstteller", "Gemusebrotchen", "Kasebrotchen", "Fischfruestueck")
alle_mittag_vegi <- c("Portobello pilz lawalan","spinat kartoffel frittata", "Vegi-Quiche", "Knodel mit Linsen",
                      "Spinatknudel mit porree und sellerie","Kartoffel Spinat Siegelei", "Salbeinudeln",
                      "Spinat oder Gemuese Lasagne", "cacio e pepe","Gnocchi Gemuse Pfanne", "Zucchini nudeln", "Tartiflette",
                      "Gemuse mit reis", "ratatui mit reis, oder erdaepfel","Kartoffel-Gemuse-Puffer vom Tischgrill", 
                      "Risotto", "Griechische Pizza, Buchweizenteig","Bohnen mit reis(asia)", "Wurziger Kartoffel kase kuchen", 
                      "Pikante Buchweizenpalatschinken", "Karfiol-Omlett mit topfen und oder sauerrahm","20er Laibchen mit Kurbis",
                      "Kartoffelpuffer mit Sellerie und burlacuh", "vegi-chilli",
                      "Pellkartoffeln mit Topfen & Schnittlauch oder barlauch", "Grune Soue mit Kartoffeln und ei und Spargel",
                      "Mais mit Bohnen (sudami)", "Gerste mit Bohnen (eu)", "Vegi-Wok")
alle_mittag_fisch <- c("Dorade fisch", "Nudeln mit spinat und lachs", "Wels mit kartoffel",
                       "Fisch divers", "Fisch divers", "Fisch divers", "Fisch divers", "Fisch divers")
alle_mittag_fleisch <- c("Mexikanische blutterteigtaschen","Cottage Pie", "Civapcici", "Fleisch-Quiche", 
                         "tafelspitz / schulter","GALLO pinto", "Sis yogurtlu lamm", "gefullter schweinebauch",
                         "Burger alto adige", "Lasagne", "salat mit huhnerstreifen", "Ritschert",
                         "Mexikanische blutterteigtaschen", "Pulled stgh, zb. Pork oder Truthahn", 
                         "verschierter braten mit sellerie", "Wok mit Fleisch", "Fleisch divers")
alle_abend <- c("23er Griespudding mit Rhabarber Kompott", "Brot mit Kuse", "Pellkartoffel mit topfen", "knaeckebrot mit irgendwas",
                "Kaeferbohnensalat", "Eierspeis mit knaeckebrot", "Pollenta mit Pilzsoue", "Raeucherfisch", "Zucchini-Lachs-Ricotta Rullchen")
alle_suppen <- c("rindssuppe","huhnersuppe", "Schlutzkrapferlsuppe","2er Suppe","haferschleimsuppe", "Gemuesesuppe","griesnockerlsuppe")
alle_vorspeisen <- c("salat", "suppe", "rohkost" )

drop_alle_fruehstueck <- alle_fruehstueck
drop_alle_mittag_vegi <- alle_mittag_vegi
drop_alle_mittag_fisch <- alle_mittag_fisch
drop_alle_mittag_fleisch <- alle_mittag_fleisch
drop_alle_abend <- alle_abend

fruehstueck <- (sample(drop_alle_fruehstueck, 7, replace = FALSE))
mittag <- sample(c(sample(drop_alle_mittag_vegi, 5, replace = FALSE),
                   sample(drop_alle_mittag_fisch, 1, replace = FALSE),
                   sample(drop_alle_mittag_fleisch, 1, replace = FALSE)), 7, replace = FALSE)
abend <- sample(drop_alle_abend, 7, replace = FALSE)


#wiederholungen reduzieren:
#drop_alle_fruehstueck <- drop_alle_fruehstueck[drop_alle_fruehstueck %in% fruehstueck == FALSE]

menueplan <- c(fruehstueck, mittag, abend)
menueplan 


StartDate <- format(Sys.Date(), "%d.%m.%y")
for (i in 1:7){
  StartDate <- c(StartDate, format(Sys.Date()+i, "%d.%m.%y"))
}
StartDate <- StartDate[-1]


file_for_cal_import <- data.frame(menueplan, StartDate, menueplan, rep(c("7:00","13:00","17:00"), each = 7))
namens <- c("Subject", "Start date", "description", "Start time")
colnames(file_for_cal_import) <- namens

write.csv(file_for_cal_import, "essensplan_für_cal_import.csv", row.names = FALSE, quote = FALSE)

rm(list = ls())
gc()
