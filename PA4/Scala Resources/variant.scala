
//This code illustrates the use of covariant type parameters (using +T syntax)
//for generic classes. 

class One {
  val x = 26
  override def toString() = "One: " + x
}

class Two extends One {
  val y = 99
  override def toString() = "Two: " + x + ", " + y
}

// This is the definition of a generic class MyList[] which is covariantly 
// subtyped with respect to its type parameter T. 

class MyList[+T](lis: List[T]) {

// T must appear in "covariant position", which (loosely speaking) means
// that T can appear in the type of a field of the generic class and
// can appear in the return type of a method, but cannot appear in the
// type of a method's formal parameter.

  val l: List[T] = lis

  def get = l

//Notice that cons, since it cannot have a T in contravariant 
//position (such as the type of a function parameter), introduces
//a new type varible B which ranges over the supertypes of T. 
//Since the cons method of MyList[T] is willing to insert x of type B into 
//a list, the resulting list is a MyList[B], not a MyList[T].

  def cons[B >: T](x : B): MyList[B] = new MyList[B](x::lis)

//This version of cons is commented out since it contains a T in 
//contravariant position and would be reject by the compiler.
//(Try uncommenting it and see what the scala compiler says).

//  def cons(x : T): MyList[T] = new MyList[T](x::lis)

  def hd = l match {
    case (x::xs) => x
    case List() => throw new Exception()
  }

  def tl = l match {
    case (x::xs) => xs
    case List() => throw new Exception()
  }

  override def toString() = (s"$l")
}

object variant {
  
  def foo(l: MyList[One]) = {
    println(l)
  }

  def main(args: Array[String]) = {
    val l1 = new MyList(List(new One()))
    val hd1: One = l1.hd
    foo(l1)
    println(hd1)
    val l2 = new MyList(List(new Two()))
    foo(l2)
    val hd2: One = l2.hd
    println(hd2)
  }
}
