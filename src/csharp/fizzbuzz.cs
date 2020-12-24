using System;

namespace Fizzbuzz
{
    public class Solution
    {
        public static void Main(string[] args)
        {
            for (int i = 1; i <= 100; ++i)
            {
                if (i % 3 == 0)
                    System.Console.Write("Fizz");
                if (i % 5 == 0)
                    System.Console.Write("Buzz");
                if ((i % 3 != 0) && (i % 5 != 0))
                    System.Console.Write(i);
                System.Console.Write("\n");
            }
        }
    }
}