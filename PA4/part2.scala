import scala.math.Ordered

// Question 1
class OInt(n:Int) extends Ordered[OInt] {
    val v = n
    
    def compare(that:OInt) : Int = {
        if (this.v > that.v)
            return 1
        else if (this.v < that.v)
            return -1
        else
            return 0
    }
    
    override def toString() : String = {
        return "<" + this.v + ">"
    }
}

// Question 2
abstract class OTree[T <: Ordered[T]] extends Ordered[OTree[T]]

case class OLeaf[T <: Ordered[T]] (value:T) extends OTree[T]{
    val v : T = value
    
    def compare(that:OTree[T]) = that match {
        case OLeaf(tv) => this.v.compare(tv)
        case ONode(tl) => -1
    }
}

case class ONode[T <: Ordered[T]] (list:List[OTree[T]]) extends OTree[T]{
    val l = list
    
    def compare(that:OTree[T]) = that match {
        case OLeaf(tv) => 1
        case ONode(tl) => compareLists(this.l, tl)
    }
    
    def compareLists(L1:List[OTree[T]], L2:List[OTree[T]]) : Int = (L1, L2) match {
        case(List(), List()) => 0
        case(List(), _) => -1
        case(_, List()) => 1
        case(x::xs, y::ys) =>
            if (x.compare(y) == 0)
                compareLists(xs, ys)
            else
                x.compare(y)
    }
}

// Question 3
object Part2{
    def main(args:Array[String]) = {
        test()
    }
    
    def compareTrees[T <: Ordered[T]] (t1:OTree[T], t2:OTree[T]) = {
        val res = t1.compare(t2)
        if (res > 0)
            println("Greater")
        else if (res < 0)
            println("Less")
        else
            println("Equal")
    }
    
    def test() = {

        val tree1 = ONode(List(OLeaf(new OInt(6))))

        val tree2 = ONode(List(OLeaf(new OInt(3)),
                   OLeaf(new OInt(4)), 
                   ONode(List(OLeaf(new OInt(5)))), 
                   ONode(List(OLeaf(new OInt(6)), 
                          OLeaf(new OInt(7))))));

        val treeTree1: OTree[OTree[OInt]] = 
          ONode(List(OLeaf(OLeaf(new OInt(1)))))

        val treeTree2: OTree[OTree[OInt]] = 
          ONode(List(OLeaf(OLeaf(new OInt(1))),
             OLeaf(ONode(List(OLeaf(new OInt(2)), 
                      OLeaf(new OInt(2)))))))


        print("tree1: ")
        println(tree1)
        print("tree2: ")
        println(tree2)
        print("treeTree1: ")
        println(treeTree1)
        print("treeTree2: ")
        println(treeTree2)
        print("Comparing tree1 and tree2: ")
        compareTrees(tree1, tree2)
        print("Comparing tree2 and tree2: ")
        compareTrees(tree2, tree2)
        print("Comparing tree2 and tree1: ")
        compareTrees(tree2, tree1)
        print("Comparing treeTree1 and treeTree2: ")
        compareTrees(treeTree1, treeTree2)
        print("Comparing treeTree2 and treeTree2: ")
        compareTrees(treeTree2, treeTree2)
        print("Comparing treeTree2 and treeTree1: ")
        compareTrees(treeTree2, treeTree1)
    }
}
