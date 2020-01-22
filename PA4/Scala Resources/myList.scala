abstract class myList[T]
case class List[T](x:T, xs:myList[T]) extends myList[T]
case class Empty[T]() extends myList[T]

object Pat{
    //val l = List(1, List(2, List(3, Empty())))
    val l = List("abc", List("def", List("ghi", Empty())))
    
    //def printList(e: myList[Int]):Unit = {
    def printList(e: myList[String]):Unit = {
        e match {
            case List(x, xs) => print(x)
                               print(" ")
                               printList(xs)
            case Empty() => ()
        }
    }
    
    def main(args: Array[String]) = {
        printList(l)
        println()
    }
}

