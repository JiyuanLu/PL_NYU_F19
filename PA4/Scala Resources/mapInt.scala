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
    
    def map(f:Int=>Int, l:myList):myList = {
        l match {
            case List(x, xs) => List(f(x), map(f, xs))
            case Empty() => Empty()
        }
    }
    
    def f(x:Int): Int = {
        return x + 1
    }
    
    def main(args: Array[String]) = {
        printList(l)
        println()
        //var x: Int = 0
        //x = f(x)
        //print(x)
        //print(l.x)
        //print(" ")
        //print(l.xs)
        val m = map(f, l)
        print(m)
    }
}

