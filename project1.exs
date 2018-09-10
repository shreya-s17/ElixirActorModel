[arg1,arg2] =Enum.map(System.argv, (fn(x) -> String.to_integer(x) end) )
SUMOFSQUARES.main(arg1,arg2)