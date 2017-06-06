import java.util.NoSuchElementException;
public class MyDeque {
  private Tile[] ary;
  private int front, back, size;

  public MyDeque() {
    ary = new Tile[10];
    front = 0;
    back = 0;
    size = 0;
  }

  private void grow() {
    Tile[] big = new Tile[2*ary.length];
    for (int ind=0; ind<ary.length-front; ind++) {
      big[big.length-1-ind] = ary[ary.length-1-ind];
    }
    for (int ind=0; ind<back; ind++) {
      big[ind] = ary[ind];
    }
    front += big.length-ary.length;
    ary = big;
  }
  private void check(int mode) {
    if (mode == 0 && front == back && size == ary.length) {
      grow();
    } else if (mode == 1 && size == 0) {
      throw new NoSuchElementException();
    }
  }


  public void addFirst(Tile str) {
    if (str == null) {
      throw new NullPointerException();
    }
    check(0);
    if (front == 0) {
      front = ary.length-1;
    } else {
      front--;
    }
    ary[front] = str;
    size++;
  }
  public void addLast(Tile str) {
    if (str == null) {
      throw new NullPointerException();
    }
    check(0);
    ary[back] = str;
    if (back == ary.length-1) {
      back = 0;
    } else {
      back++;
    }
    size++;
  }

  public Tile removeFirst() {
    check(1);
    Tile str = ary[front];
    if (front == ary.length-1) {
      front = 0;
    } else {
      front++;
    }
    size--;
    return str;
  }
  public Tile removeLast() {
    check(1);
    if (back == 0) {
      back = ary.length-1;
    } else {
      back--;
    }
    size --;
    return ary[back];
  }

  public Tile getFirst() {
    check(1);
    return ary[front];
  }
  public Tile getLast() {
    check(1);
    if (back == 0) {
      return ary[ary.length-1];
    }
    return ary[back-1];
  }

  public boolean hasNext() {
    return size != 0;
  }
}