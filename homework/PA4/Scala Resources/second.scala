
//This contains a simple example of inheritance in Scala

//All class inherit from Object, which defines the toString() method.

class A(x: Int, y: String) {
  val value = x
  val name = y

//To override a method of the parent class, you need to use the
//"override" keyword.
  override def toString(): String = (s"$value$name")
}

//Note the use of parameters to the class, similar the parameters
//to a constructor in Java
class B(a: Int, b: String, c: Int) extends A(a,b) {
  val age = c
  override def toString() = (s"$age$value$name$name")
}


object Prog {

  def f(a: A) = println(a)

  def main(args: Array[String]) = {
    val a = new A(33, "Thirty Three")
    println(a)

    //This illustrates subtyping -- pass a B to a method that expects an A
    val b = new B(22, "Twenty Two", 222)
    f(b)
  }
}
