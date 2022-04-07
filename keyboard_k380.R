library(stringr)
library(glue)

#' Keyboard_k380
#' @param key 4A4CFC5EE71DEA8F7646C6B9FCF66B7E
#' @export
write_Keyboard_k380 <- function(key, outfile = "info") {
  template = glue(
    "[General]
    Name=Keyboard K380
    Class=0x000540
    SupportedTechnologies=BR/EDR;
    Trusted=true
    Blocked=false
    Services=00001000-0000-1000-8000-00805f9b34fb;00001124-0000-1000-8000-00805f9b34fb;00001200-0000-1000-8000-00805f9b34fb;

    [LinkKey]
    Key={key}
    Type=5
    PINLength=0

    [DeviceID]
    Source=2
    Vendor=1133
    Product=45890
    Version=16897
    "
  )
  writeLines(template, outfile)
}


is_lower_mac <- function(x) {
  sapply(x, function(x) tolower(x) == x && nchar(x) == 12)
}
is_mac <- function(x) {
  sapply(x, function(x) grepl(":", x) && toupper(x) == x)
}

hex2norm <- function(x) toupper(gsub(",", ":", x))
str2hex <- function(x) {
  if (!is_lower_mac(x)) return(x)
  n = nchar(x)/2
  sapply(1:n, function(i) {
    substr(x, (i - 1)*2 + 1, i*2)
  }) %>% paste(collapse = ":") %>% toupper()
}

## MAIN scripts ----------------------------------------------------------------
strs = readLines("blue.reg")[-(1:2)]

# strs = "
# Windows Registry Editor Version 5.00
# 
# [\\ControlSet001\Services\BTHPORT\Parameters\Keys]
# 
# [\\ControlSet001\Services\BTHPORT\Parameters\Keys\3887d5633c87]
# "MasterIRK"=hex:d6,47,e9,9f,fc,18,e7,51,f2,eb,cf,a7,9a,19,aa,36
# "f473355dab88"=hex:4a,4c,fc,5e,e7,1d,ea,8f,76,46,c6,b9,fc,f6,6b,7e
# "

is_title = grepl("\\[", strs)
flags = cumsum(is_title)

lst = split(strs, flags)[-1]
items = lst[[1]] %>% .[. != ""] # the first is 

BluetoothCard = items[1] %>% gsub("\\[|\\]", "", .) %>% gsub("\\\\", "/", .) %>% basename() %>% str2hex()

r = lapply(items[-1], function(x) {  
  name = str_extract(x, ".*(?=\\=)") %>% gsub("\"", "", .) %>% str2hex()
  key = str_extract(x, "(?<=\\=).*") %>% gsub("hex:", "", .) %>% hex2norm()
  data.frame(card = BluetoothCard, name, key)
})
# //ControlSet001/Services/BTHPORT/Parameters/Keys
df = do.call(rbind, r)
inds = is_mac(df$name) %>% which()

for (i in inds) {
  d = df[i, ]
  f = glue("bluetooth/{BluetoothCard}/{d$name}/info")
  odir = dirname(f)
  if (!dir.exists(odir))dir.create(odir, recursive = TRUE)
  write_Keyboard_k380(d$key, f)
}
cat(sprintf("[ok]: succeed to export keyboard k380 setting!\n"))
