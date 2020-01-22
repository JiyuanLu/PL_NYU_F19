

// Illustrates the use of anonymous functions  (like Lambda expressions)
// The syntax is (parameters) => body. You'll generally need to wrap
// it in parentheses.

object lambdaExample {
  def higher(f:Int=>Int) = f(f(3))

  def higher2(f:(Int,Int)=>Int) = f(3,4)
  
  def main(args: Array[String]) = { 
        println(higher((x) => x+1)) 
        println(higher2((x,y) => x+y))
  }
}

