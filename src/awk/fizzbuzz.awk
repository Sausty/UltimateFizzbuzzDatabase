BEGIN {
   if(!n) n=100
   print "# FizzBuzz:"
 
   for (ii=1; ii<=n; ii++)
       if (ii % 15 == 0)
           {print "FizzBuzz"}
       else if (ii % 3 == 0)
           {printf "Fizz "}
       else if (ii % 5 == 0)
           {printf "Buzz "}
       else
           {printf "%3d ", ii}
 
    print "\n# Done."
}