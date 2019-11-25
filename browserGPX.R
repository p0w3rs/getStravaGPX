#strava browser gpx export


#The place of your browsers downloadfolder 
downloadWD <- "" #For example: "C:/Users/username/Downloads"  

#The place of the activities.csv for the track IDs
archiveWD <- "" #For example: "C:/StravaArchiv"



# the place where to copy the downloaded tracks if you dont want to keep them in DL-directory. Not necessary to work.
copytoWD <- "" #For example: "C:/StravaArchiv/activities"





if(!require(KeyboardSimulator)){
    install.packages("KeyboardSimulator")
}
library("KeyboardSimulator")
`%nin%` <- Negate(`%in%`)




if (downloadWD != "" && archiveWD != "") {

  setwd(archiveWD)
  actv <- read.csv("activities.csv")
  name <- as.character(actv[ncol(actv)])#last column for activity name
  id <- actv[,1] #first column for ID numbers
  
  corrIDs <- vector()
  
  for (i in 1:length(name)) {
    if(name[i] != "") { 
      if (strsplit(name[i], split = "[.]")[[1]][length(strsplit(name[i], split = "[.]")[[1]])] == "gz") {
        corrIDs[length(corrIDs)+1] <- i
      }
    }
  }
  id <- id[corrIDs]
  
  
  
  setwd(downloadWD)
  missingid <- vector()
  removetracks <- vector()
  for (i in 1:length(id)) {
    
    
    initialFilelist <- list.files()
    #jetzt downloaden
    browseURL(paste0("https://www.strava.com/activities/", id[i], "/export_gpx"))
    trys <- 0
    while (trys < 3) {
      track <- NULL
      Sys.sleep(1.5)
      keybd.press("enter")
      Sys.sleep(1)
      #getfile
      newFilelist <-  list.files()
      track <- newFilelist[newFilelist %nin% initialFilelist]
      if(length(track) == 1){
        break
      }
      trys <- trys + 1
    }
    if (length(track) == 0) {
      cat(paste0("No track downloaded. Track-ID: ", id[i], "\n"))
      missingid[length(missingid)+1] <- id[i]
    } else if (length(track) == 1) {
      if (copytoWD != ""){# if copy directory specified
        file.copy(track, copytoWD, overwrite = T)
        removetracks[length(removetracks)+1] <- track
      }
      
    } else {
      cat(paste0("Error track-ID: ", id[i], "\n"))
      missingid[length(missingid)+1] <- id[i]
    }
  
  }
  #remove all tracks in DL folder if copytoWD specified
  for (i in 1:length(removetracks)) {
    file.remove(removetracks[i])
  }

} else{
  cat("Error: directories not specified")
}
