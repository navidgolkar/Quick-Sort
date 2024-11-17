float[] set;
String text;
float offset = 0, pivot;
int pp;
IntList lo = new IntList();
IntList hi = new IntList();
boolean run = true;
int time = 0;

void setup() {
  size(800, 600);
  frameRate(60);
  set = new float[int(0.99*width)];
  offset = 0.01*width/2;
  for (int i = 0; i < set.length; i++) set[i] = map(i, 0, set.length - 1, height/50, 9*height/10);
  disorder(set);
  lo.append(0);
  hi.append(set.length - 1);
}

void draw() {
  background(0);
  textSize(20);
  if (run) {
    if (lo.size() > 0 && hi.size() > 0) {
      pivot = set[hi.get(0)];
      pp = lo.get(0);
      for (int i = lo.get(0); i <= hi.get(0); i++) {
        if (set[i] < pivot) {
          swap(set, pp, i);
          pp++;
        }
      }
      swap(set, pp, hi.get(0));
      if (lo.get(0) < pp-1) {
        hi.append(pp-1);
        lo.append(lo.get(0));
      }
      if (pp+1 < hi.get(0)) {
        hi.append(hi.get(0));
        lo.append(pp+1);
      }
      hi.remove(0);
      lo.remove(0);
      fill(255);
      text = "Time: " + (millis() - time) + " ms";
      text(text, 20, 20);
    } else {
      run = false;
      time = millis() - time;
    }
  } else {
    fill(255);
    text = "Time: " + time + " ms";
    text("finished!\n" + text, 20, 20);
  }

  stroke(255);
  for (int i = 0; i < set.length; i++) line(i + offset, height, i + offset, height-set[i]);
}

void swap(float[] arr, int a, int b) {
  if (a != b) {
    arr[a] += arr[b];
    arr[b] = arr[a] - arr[b];
    arr[a] = arr[a] - arr[b];
  }
}

void swap(int[] arr, int a, int b) {
  int temp = arr[a];
  arr[a] = arr[b];
  arr[b] = temp;
}

void disorder(float[] arr) {
  for (int i = 0; i < set.length; i++) {
    int x = round(random(set.length - 1));
    if (i != x) swap(arr, i, x);
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    disorder(set);
    lo.clear();
    hi.clear();
    lo.append(0);
    hi.append(set.length - 1);
    time = millis();
    run = true;
  }
}
