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
    
    def map[T, S](f:T=>S, l:myList[T]) : myList[S] = {
        l match {
            case List(x, xs) => List(f(x), map(f, xs))
            case Empty() => Empty()
        }
    }
    
    def f(x:Int):Int = {
        return x + 1
    }
    
    def g(s:String) : Int = {
        return s.length()
    }
    
    def main(args: Array[String]) = {
        printList(l)
        println()
        //val m = map(f, l)
        val m = map(g, l)
        print(m)
    }
}

