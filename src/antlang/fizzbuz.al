n:{1+ x}map range[100]
s:{a:0eq x mod 3;b:0eq x mod 5;concat apply{1elem x}map{0elem x}hfilter seq[1- max[a;b];a;b]merge seq[str[x];"Fizz";"Buzz"]}map n
echo map s