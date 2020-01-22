
// This defines a generic class Contra[] that is contravariantly subtyped with 
// respect to its type parameter T.

class Contra[-T]() {

// T can only be used in "contravariant position", which (loosely speaking) means
// it can be used as the type of a method's formal parameter, but not as the return
// type of a method nor as the type of a field in the generic class.

  var v: List[Any] = List()
  def insert(x: T) = v = x::v

  override def toString() = {
    def elementsToString(l: List[Any]): String = l match {
      case List() => ""
      case (x::xs) => x.toString() + " " + elementsToString(xs)
    }
    "Contra[ " + elementsToString(v) + "]"
  }
}

class A(x: Integer) {
  override def toString() = "A<" + x + ">"
}

class B(x: Integer, y: Integer) extends A(x) {
  override def toString() = "B<" + x + "," + y + ">"
}




object foo {

  def test(m: Contra[B], z: B) = 
    m.insert(z)

  def main(args: Array[String]) = {
    val l1 = new Contra[B]()
    test(l1, new B(3,4))
    println(l1)

    val l2 = new Contra[A]()
    l2.insert(new A(5))
    test(l2, new B(3,4))   //uses contravariant subtyping in first argument
    println(l2)
  }
}



