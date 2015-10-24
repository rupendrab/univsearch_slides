download_read_and_cleanse_scorecard_file <- function() {
        if (! file.exists("scorecard_data.csv")) {
                download.file("https://s3.amazonaws.com/ed-college-choice-public/Most+Recent+Cohorts+(Scorecard+Elements).csv", 
                              destfile = "scorecard_data.csv",
                              method = "curl")
        }
        suppressPackageStartupMessages(library(dplyr))
        recentData <- read.csv("scorecard_data.csv", stringsAsFactors = FALSE)
        myData <- recentData %>% filter(SATWRMID != "NULL")
        suppressWarnings({
                myData <- myData %>% mutate(SATVR25 = as.numeric(SATVR25),
                                            SATVR75 = as.numeric(SATVR75),
                                            SATVRMID = as.numeric(SATVRMID))
                myData <- myData %>% mutate(SATWR25 = as.numeric(SATWR25),
                                            SATWR75 = as.numeric(SATWR75),
                                            SATWRMID = as.numeric(SATWRMID))
                myData <- myData %>% mutate(SATMT25 = as.numeric(SATMT25),
                                            SATMT75 = as.numeric(SATMT75),
                                            SATMTMID = as.numeric(SATMTMID))
        })
        newData <- myData[,c(c(1:6), grep("^SAT", colnames(myData)))]
        newData
}

getUnivMatches <- function(satwr, satmt, satvr, pctrank, topn) {
        if (pctrank == 25) {
                newDataSorted <- newData %>%
                        mutate(ScoreDifference = abs(satwr - SATWR25) + abs(satmt - SATMT25) + abs(satvr - SATVR25))
        }
        else if (pctrank == 50) {
                newDataSorted <- newData %>%
                        mutate(ScoreDifference = abs(satwr - SATWRMID) + abs(satmt - SATMTMID) + abs(satvr - SATVRMID))
        }
        else if (pctrank == 75) {
                newDataSorted <- newData %>%
                        mutate(ScoreDifference = abs(satwr - SATWR75) + abs(satmt - SATMT75) + abs(satvr - SATVR75))
        }
        newDataSorted <- newDataSorted %>%
                filter(ScoreDifference <= 60) %>%
                arrange(ScoreDifference)
        
        noMatches <- dim(newDataSorted)[1]
        if (noMatches < topn) {
                matchesMid <- newDataSorted
        }
        else {
                matchesMid <- newDataSorted[1:min(topn,dim(newDataSorted)[1]),]
        }
        # print(matchesMid)
        
        if (noMatches > 0) {
                matchesMid$Location = paste(matchesMid$CITY, ", ", matchesMid$STABBR, sep="")
                matchesMid <- matchesMid %>%
                        select(INSTNM, Location, 
                               SATVR25, SATVRMID, SATVR75, 
                               SATWR25, SATWRMID, SATWR75, 
                               SATMT25, SATMTMID, SATMT75, 
                               ScoreDifference) %>%
                        rename("Institute" = INSTNM,
                               "Reading 25" = SATVR25,
                               "Reading 50" = SATVRMID,
                               "Reading 75" = SATVR75,
                               "Writing 25" = SATWR25,
                               "Writing 50" = SATWRMID,
                               "Writing 75" = SATWR75,
                               "Math 25" = SATMT25,
                               "Math 50" = SATMTMID,
                               "Math 75" = SATMT75
                        )
                
                matchesMid$hint <- paste(matchesMid$Institute, ", ", matchesMid$Location, sep="")
                matchesMid$MatchScore <- 100 - matchesMid$ScoreDifference
                Geo <- gvisGeoChart(matchesMid, locationvar='Location', colorvar='MatchScore', hovervar='hint',
                                    options=list(region='US', height=350, width=800,
                                                 displayMode = 'markers', resolution = "metros", backgroundColor = "lightblue",
                                                 enableRegionInteractivity = TRUE,
                                                 colorAxis = "{colors:['lightgreen', 'green', 'darkgreen']}"))
                # colors='[0xe5f5f9, 0x99d8c9, 0x2ca25f]'))
                dataTab <- gvisTable(matchesMid[,! names(matchesMid) %in% c("hint")], options = list(page='enable', 
                                                                                                     width='100%', 
                                                                                                     height='300',
                                                                                                     frozenColumns=2))
                plotData <- gvisMerge(Geo, dataTab)
        }
        
        
        toret <- function(typ) {
                if (typ == "count") {
                        noMatches
                }
                else if (typ == "plot") {
                        plotData
                }
                else if (typ == "data") {
                        matchesMid
                }
                else if (typ == "chartonly") {
                        Geo
                }
                else if (typ == "dataonly") {
                        dataTab
                }
        }
        toret
}
