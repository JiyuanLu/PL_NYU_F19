
//This is a fairly complete example, showing the use of type constraints
//on type variables in generics.

trait CanBeCompared[T] {
  def <(other: T): Boolean
  def <=(other:T) = <(other) || ==(other)
  def >(other:T) = !(<(other)) && !=(other)
  def >=(other: T) = !(<(other))
}

//This defines a generic tree class such that:
// 1) the type T of the label associated with the node implements 
//    the CanBeCompared[T] trait, so that two labels of type T can
//    be compared to each other, and
// 2) The tree class itself implements CanBeCompared[Tree[T]], so that
//    two trees of type Tree[T] can be compared.

abstract class Tree[T <: CanBeCompared[T]] extends CanBeCompared[Tree[T]]

//This code defines < between two trees, such that T1 < T2 if T1 and T2 have the
//same structure and each label in T1 is less than the corresponding label of T2.
//It makes for a strange definition of > and >=, but the point of this code is
//simply to show how generics and type constrais work in Scala.

case class  Node[T  <: CanBeCompared[T]](v: T, l: Tree[T], r: Tree[T]) extends Tree[T] {
  def <(other: Tree[T]) = other match {
    case Node(ov,ol,or) => (v < ov) && (l < ol) && (r < or)
    case _ => false
  }

  override def toString() = "("+l+")"+ v+"("+r+")"
}

case class  Empty[T <: CanBeCompared[T]]() extends Tree[T] {
  def <(other: Tree[T]) = other match {
    case Empty() => true
    case _ => false
 }

  override def toString() = ""
}

case class  Leaf[T <: CanBeCompared[T]](v: T) extends Tree[T] {
  def <(other: Tree[T]) = other match {
    case Leaf(ov) => v < ov
    case _ => false
  }
  override def toString() = (s"$v")
}
  

class MyInt(x:Int) extends CanBeCompared[MyInt] {
  val value = x
  def get = x
  def ==(other: MyInt) = x == other.get
  def <(other: MyInt) = x < other.get
  override def toString(): String = (s"$x")
}



object Prog {

  def compare[T <: CanBeCompared[T]](a: T, b: T) = {
    if (a < b)
      println("Yes")
    else
      println("No")
  }

  def main(args: Array[String]) = {

    val a = new MyInt(16)
    val b = new MyInt(7)
    //comparing two MyInt's
    compare(a,b)

    
    val x: Tree[MyInt] = Node(new MyInt(6), Node(new MyInt(4),Leaf(new MyInt(3)),Leaf(new MyInt(5))), 
		 Node(new MyInt(8),Leaf(new MyInt(7)),Empty()))

    val y: Tree[MyInt] = Node(new MyInt(16), Node(new MyInt(14),Leaf(new MyInt(13)),Leaf(new MyInt(15))), 
		 Node(new MyInt(18),Leaf(new MyInt(17)),Empty()))

    //comparing two Tree[MyInt]'s
    compare(x,y)

  }
}
