
//This code illustrates the use of "case classes" in Scala,
//used much like datatypes and pattern matching in ML.

//A case class is much like an ordinary class, but can be used
//in a "match" clause for pattern matching.  Also, an object
//of a case class can be created without the use of the "new"
//keyword.

abstract class Tree

case class Node(v:Int, l:Tree, r:Tree) extends Tree

case class Leaf(v:Int) extends Tree

case class Empty() extends Tree


object Pat {

  //Note the absence of "new" here, and the similarity with ML
  val myTree = Node(3,Leaf(4),Node(5,Leaf(6),Empty()))

  //printTree will actually be called with an object of one of the 
  //case classes that derive from the abstract class Tree
  def printTree(t: Tree):Unit = {
    t match {
      case Node(v,l,r) => print("(") 
      	                  printTree(l) 
                          print(v)
                          printTree(r)
                          print(")")
      case Leaf(v) => print(v)
      case Empty() => ()
    }
  }

  def main(args: Array[String]) =  { 
    printTree(myTree)
    println()
  }
}


// A Scala program can have two different main() functions, in 
// different singleton classes.  After you compile this program
// by saying:
//
//    scalac pattern.scala
//
// you can choose to run the main() above by specifying the class
// in which that main() appears, namely by typing
//
//    scala Pat
//
// into the shell.  Alternatively, you can run the main() below
// by typing
//
//    scala Pat2
//
// into the shell.

object Pat2 {
  def main(args: Array[String]) = print("YES") 
}

