class A
class B extends A

object example {

  def fb(g:B=>String) = {
    val b:B = new B
    g(b)
  }

  def fa(g:A=>String) = {
    val a:A = new A
    g(a)
  }

  def h(x:A) = x.toString()

  def i(y:B) = y.toString()

  def main(args: Array[String]): Unit = {
    fa(h)
    fb(h)  //passing a function of type A->String
           //to a function expecting a B->String

  //  fa(i) //passing a function of type B->string to 
            //a function expecting an A->string. Type error.
    fb(i) 
  }
}
