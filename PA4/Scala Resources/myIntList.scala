abstract class myList
case class List(x:Int, xs:myList) extends myList
case class Empty() extends myList

object Pat{
    val l = List(1, List(2, List(3, Empty())))
    
    def printList(e: myList):Unit = {
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

