import java.util.*;

// Question 1
class ComparableList<T extends Comparable<T>> extends ArrayList<T> implements Comparable<ComparableList<T>>{
    public int compareTo(ComparableList<T> that){
        Iterator<T> thisIterator = this.iterator();
        Iterator<T> thatIterator = that.iterator();
        while (thisIterator.hasNext() && thatIterator.hasNext()){
            T e1 = thisIterator.next();
            T e2 = thatIterator.next();
            int res = e1.compareTo(e2);
            if (res == 0)
                continue;
            else if (res < 0)
                return -1;
            else
                return 1;
        }
        
        if (this.size() > that.size())
            return 1;
        else if (this.size() < that.size())
            return -1;
        else
            return 0;
    }
        
    // @override
    public String toString(){
        String s = "[[";
        for (T t : this)
            s = s + t + " ";
        s += "]]";
        return s;
    }
}

// Question 2
class A implements Comparable<A>{
    Integer x;
    
    public A (Integer x){
        this.x = x;
    }
    
    public int get(){
        return this.x;
    }
    
    public int compareTo(A that){
        Integer v1 = this.get();
        Integer v2 = that.get();
        return v1.compareTo(v2);
    }
    
    // @override
    public String toString(){
        return "A<" + this.x.toString() + ">";
    }
}

// Question 3
class B extends A{
    Integer y;
    
    public B (Integer x, Integer y){
        super(x);
        this.y = y;
    }
    
    // @override
    public int get(){
        return this.x + this.y;
    }
    
    // @override
    public String toString(){
        return "B<" + x.toString() + "," + y.toString() + ">";
    }
}

// Question 4 & 5
public class part1
{
    public static <T extends Comparable<T>> void addToCList(T z, ComparableList<T> L){
        L.add(z);
    }
    
    public static void main(String args[]){
        test();
    }
    
    static void test() {
        ComparableList<A> c1 = new ComparableList<A>();
        ComparableList<A> c2 = new ComparableList<A>();
        for(int i = 0; i < 10; i++) {
            addToCList(new A(i), c1);
            addToCList(new A(i), c2);
        }
        
        addToCList(new A(12), c1);
        addToCList(new B(6,6), c2);
        
        addToCList(new B(7,11), c1);
        addToCList(new A(13), c2);

        System.out.print("c1: ");
        System.out.println(c1);
        
        System.out.print("c2: ");
        System.out.println(c2);

        switch (c1.compareTo(c2)) {
        case -1: 
            System.out.println("c1 < c2");
            break;
        case 0:
            System.out.println("c1 = c2");
            break;
        case 1:
            System.out.println("c1 > c2");
            break;
        default:
            System.out.println("Uh Oh");
            break;
        }

    }
}
        

            