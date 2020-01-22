
//This program illustrates the use in Scala of a "singleton" class, a
//class instantiated by a single object, rather than static members as
//in Java.

//Singleton classes are declared using the "object" keyword.

object Counter {
  var count = 0
  def increment = count = count + 1
  def get = count
  def useCount(f: (Int) => Unit) = f(count)

}


class Foo {

  val x = 12

  var y: Int = 20

  def f(z: Int): Int = x+y+z

//Example of a method whose name is a symbol. There is no special
//syntax for such methods.

  def +(other: Foo) : Int = y + other.y

  def set(w: Int) = {
    Counter.increment //increment the counter
    y = w
  }
}


// The main() method is put inside a singleton class.

object Bar {

  def printArg(x: Int) = println("Got the value " + x)

  def main(args: Array[String]) = {
    val o = new Foo()
    o set 17;  // same as o.set(17)
    val p = new Foo()
    p.set(25)
    println(o + p)  //same as o.+(p)
    println("Counter is now " + Counter.get)
    Counter.useCount(printArg)
    Counter.useCount((x:Int) => println(x*1000))
  }
  

}


object Another {

  def main(args: Array[String]) = {
    println("Yes")
  }
}

