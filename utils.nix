let 
  pretty = txt : "---- " + txt + " ----";
  tracePretty = txt : builtins.trace (pretty txt);
in
rec {
  mkLogPath = label : 
  let 
    logFile = builtins.toFile (label + ".log") "";
  in
    tracePretty (label + " log file: " + logFile) logFile;    
    
  mkPlaceBashLogCall = label : txt :
  let 
    logPath = mkLogPath label;
  in
    tracePretty  
      ("placeBashLogCall " + txt)  
      "echo ${txt} > ${logPath}";
       
  #mkLog = label : 
  #let 
    #logPath = mkLogPath label;
  #in
    #log label logPath; 

  #log = label : logPath : txt :   
    # implement something like
    # writeFile logFilePath txt
}
