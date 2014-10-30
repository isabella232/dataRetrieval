#' Raw Data Import for Instantaneous USGS NWIS Data
#'
#' Imports data from NWIS web service. This function gets the data from here: \url{http://waterservices.usgs.gov/}
#' A list of parameter codes can be found here: \url{http://nwis.waterdata.usgs.gov/nwis/pmcodes/}
#' A list of statistic codes can be found here: \url{http://nwis.waterdata.usgs.gov/nwis/help/?read_file=stat&format=table}
#'
#' @param siteNumber string USGS site number.  This is usually an 8 digit number
#' @param parameterCd string USGS parameter code.  This is usually an 5 digit number.
#' @param startDate string starting date for data retrieval in the form YYYY-MM-DD.
#' @param endDate string ending date for data retrieval in the form YYYY-MM-DD.
#' @keywords data import USGS web service
#' @return data dataframe with agency, site, dateTime, time zone, value, and code columns
#' @export
#' @examples
#' siteNumber <- '05114000'
#' parameterCd <- '00060'
#' startDate <- "2014-10-10"
#' endDate <- "2014-10-10"
#' # These examples require an internet connection to run
#' rawData <- readNWISunit(siteNumber,parameterCd,startDate,endDate)
#' 
#' timeZoneChange <- readNWISunit(c('04024430','04024000'),parameterCd,
#'          "2013-11-03","2013-11-03")
#' firstSite <- timeZoneChange[timeZoneChange$site_no == '04024430',]
readNWISunit <- function (siteNumber,parameterCd,startDate,endDate){  
  
  url <- constructNWISURL(siteNumber,parameterCd,startDate,endDate,"uv",format="xml")

  data <- importWaterML1(url,asDateTime=TRUE)
  

  return (data)
}

#' Reads peak flow data from NWISweb.
#' 
#' 
#' 
#' @param siteNumber string USGS site number.  This is usually an 8 digit number
#' @param startDate string starting date for data retrieval in the form YYYY-MM-DD.
#' @param endDate string ending date for data retrieval in the form YYYY-MM-DD.
#' @export
#' @examples
#' siteNumber <- '01594440'
#' data <- readNWISpeak(siteNumber, '','')
readNWISpeak <- function (siteNumber,startDate,endDate){  
  
  url <- constructNWISURL(siteNumber,NA,startDate,endDate,"peak")
  data <- importRDB1(url)
    
  return (data)
}

#' Reads the current rating table for an active USGS streamgage.
#' 
#' 
#' 
#' @param siteNumber string USGS site number.  This is usually an 8 digit number
#' @param type string can be "base", "corr", or "exsa"
#' @export
#' @examples
#' siteNumber <- '01594440'
#' data <- readNWISrating(siteNumber, "base")
readNWISrating <- function (siteNumber,type){  
  
  url <- constructNWISURL(siteNumber,service="rating",ratingType = type)
  data <- importRDB1(url)
  
  return (data)
}

#'Reads surface-water measurement data from NWISweb.
#'
#'
#'
#' @param siteNumber string USGS site number.  This is usually an 8 digit number
#' @param startDate string starting date for data retrieval in the form YYYY-MM-DD.
#' @param endDate string ending date for data retrieval in the form YYYY-MM-DD.
#' @export
#' @examples
#' siteNumber <- '01594440'
#' data <- readNWISmeas(siteNumber, '','')
readNWISmeas <- function (siteNumber,startDate,endDate){  
  
  url <- constructNWISURL(siteNumber,NA,startDate,endDate,"meas")
  data <- importRDB1(url)
  
  return (data)
}

#'Reads groundwater level measurements from NWISweb.
#'
#'
#'
#' @param siteNumber string USGS site number.  This is usually an 8 digit number
#' @param startDate string starting date for data retrieval in the form YYYY-MM-DD.
#' @param endDate string ending date for data retrieval in the form YYYY-MM-DD.
#' @export
#' @examples
#' siteNumber <- "434400121275801"
#' data <- readNWISgwl(siteNumber, '','')
readNWISgwl <- function (siteNumber,startDate,endDate){  
  
  url <- constructNWISURL(siteNumber,NA,startDate,endDate,"gwlevels",format="tsv")
  data <- importRDB1(url)
  
  return (data)
}

