setwd("C:/Users/becca/Documents/GitHub/visR")
#install.packages(c('devtools', 'Rtools'))
#install.packages(c('RBesT', 'DOT', 'ggpubr', 'pammtools', 'gt', 'parcats', 'easyalluvial', 'here', 'plotly'))
library(devtools)
#build()
install()
library(visR)

dataset <- NULL

for(PatientID in 1:5000){
  
  max_line <- sample(0:5, 1, prob = c(0.2, 0.4, 0.2, 0.15, 0.04, 0.01))
  
  if(max_line == 1){
    
    min_line <- sample(c(0, 1), 1, prob = c(0.3, 0.7))
    
  } else{ min_line <- 0 }
  
  for(LineNumber in min_line:max_line){
    
    LineName <- sample(c('Treatment_A', 'Treatment_B', 'Treatment_C'), 1, prob = c(0.5, 0.3, 0.2))
    
    patient_data_line <- data.frame(PatientID = PatientID,
                                    LineName = LineName,
                                    LineNumber = LineNumber)
    
    dataset <- rbind(patient_data_line , dataset)
    
  }
  
}

vr_alluvial_plot(dataset)



library(survival)
library(dplyr)
library(magrittr)
library(ggplot2)
# Load data from the Veteran's Cancer Study
data(veteran)

data <-  veteran %>%
  mutate(trt = as.factor(case_when(
    trt == 1 ~ "standard therapy",
    trt == 2 ~ "test chemotherapy"
  )))

vr_kaplan_meier(
  data = data,
  data_source = "Veteran's Lung Cancer Study",
  title = paste0(
    "Comparison of survival in male patients having advanced inoperable ",
    "lung cancer under standard therapy vs. test chemotherapy"))

