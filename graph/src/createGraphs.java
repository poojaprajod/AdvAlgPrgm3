import java.util.ArrayList;

public class createGraphs {
    static GraphGenerator g = new GraphGenerator();

    public static void main(String[] args){
        ArrayList<Double> arr = new ArrayList();
        arr.add(0.1);
        arr.add(0.2);
        arr.add(0.3);
        arr.add(0.4);
        arr.add(0.5);
        arr.add(0.6);
        arr.add(0.7);
        arr.add(0.8);
        arr.add(0.9);
        arr.add((double) 1);

        for(int n = 10; n <= 70; n = n + 10) {
            for (double p : arr) {
                for (int w = 10; w <= 320; w = w*2) {
                    for (int id = 1; id <= 5; id = id + 1) {
                        String[] arguments = new String[4];
                        arguments[0] = Integer.toString(n);
                        arguments[1] = Double.toString(p);
                        arguments[2] = Integer.toString(w);
                        arguments[3] = Integer.toString(id);
                        g.run(arguments);
                    }
                }
            }
        }
    }
}
