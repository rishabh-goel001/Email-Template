library("stringr")
library("htmltools")
setwd('C:/Users/Acer/Documents')
emails <- read.csv("sample_email.csv",sep=",",header=TRUE,stringsAsFactors = FALSE)
df_email <- as.data.frame(emails)
head(emails)
str(emails)  

####### Email Template
email_template = as.data.frame(paste(paste0('Email to :', df_email$email), 
                                              paste0('Subject Line:', df_email$subject), 
                                              paste0('Hi ', df_email$first_name, ' ', df_email$last_name, ','),
                                              df_email$Email.Boby,
                                              paste0('Please do contact me at ', df_email$phone),
                                              'Thanks,',
                                              'Rob Willison',
                                              sep = '\n')) 


colnames(email_template) <- 'Mail_Template'
write.csv(email_template,"emails.csv")                  

  
#### find emails in email body

pattern = '[a-zA-Z0-9\\.]+@[a-zA-Z0-9-]+\\.[a-z]'
avector <- as.vector(df_email$Email.Boby)
m <- gregexpr(pattern, avector)
df_email$email_matches <- t(as.data.frame(lapply(regmatches(avector, m), function(x) if(identical(x, character(0))) NA_character_ else x)))


pattern_phone = '[(]?[0-9]{3}[)]?[ |-][0-9]{3}-[0-9]{4}'
avector <- as.vector(df_email$Email.Boby)
m <- gregexpr(pattern_phone, avector)
df_email$phone_matches <- t(as.data.frame(lapply(regmatches(avector, m), function(x) if(identical(x, character(0))) NA_character_ else x)))


#df_email
email_addresses <- as.data.frame(df_email$email_matches)
phone_matches <- as.data.frame(df_email$phone_matches)
write.csv(email_addresses,"emailmatches.csv", row.names = FALSE)

write.csv(phone_matches,"phonematches.csv", row.names = FALSE)
