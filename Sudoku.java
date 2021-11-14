package sudoku;

import java.io.*;
import java.util.*;

class Sudoku {
    String[][] values;

    private Sudoku() {
        values = new String[9][9];
    }

    private void readInFile(String filename) throws IOException {
        BufferedReader bufferedReader = new BufferedReader(new FileReader(filename));
        String line;
        int i = 0;
        while ((line = bufferedReader.readLine()) != null & i<9) {
            values[i] = line.split(",", -1);
            for (int j = 0; j < 9; j++) {
                values[i][j] = values[i][j].equals(" ") ? "" : values[i][j];
            }
            i++;
        }
        if (i>9) {
            throw new IOException("Input csv not a valid sudoku");
        }
    }

    public static Sudoku sudokuFromFile(String filename) throws IOException {
        Sudoku s = new Sudoku();
        s.readInFile(filename);
        return s;
    }

    public void display() {
        for (int r = 0; r < 9; r++) {
            for (int c = 0; c < 9; c++) {
                System.out.print(this.values[r][c].equals("") ? " " : this.values[r][c]);
                System.out.print((c%3 == 2 && c!=8)?"|":"");
            }
            System.out.println((r%3 == 2 && r!=8)?"\n-----------":"");
        }
    }
    
    public void solve() throws Exception {
        Set<String>[][] possValues = new Set[9][9];
        for (int r = 0; r < 9; r++) {
            for (int c = 0; c < 9; c++) {
                possValues[r][c] = new HashSet<>();
                if (this.values[r][c].equals("")) {
                    for (int v = 1; v <= 9; v++) {
                        possValues[r][c].add(Integer.toString(v));
                    }
                }
                else {
                    possValues[r][c].add(this.values[r][c]);
                }
            }
        }
        
        boolean updated = true;
        
        while (updated) {
            for (int vr = 0; vr < 9; vr++) {
                for (int vc = 0; vc < 9; vc++) {
                    String v = this.values[vr][vc];
                    if (!v.equals("")) {
                        // Do box
                        for (int r = Math.floorDiv(vr,3)*3; r <= Math.floorDiv(vr,3)*3+2; r++) {
                            for (int c = Math.floorDiv(vc,3)*3; c <= Math.floorDiv(vc,3)*3+2; c++) {
                                if (r!=vr || c!=vc) {
                                    possValues[r][c].remove(v);
                                }
                            }
                        }

                        // Do row
                        int r = vr;
                        for (int c = 0; c < 9; c++) {
                            if (c!=vc) {
                                possValues[r][c].remove(v);
                            }
                        }

                        // Do column
                        int c = vc;
                        for (r = 0; r < 9; r++) {
                            if (r!=vr) {
                                possValues[r][c].remove(v);
                            }
                        }
                    }
                }
            }

            updated = false;
            for (int r = 0; r < 9; r++) {
                for (int c = 0; c < 9; c++) {
                    if (possValues[r][c].size() == 0) {
                        throw new Exception("Can't solve this sudoku");
                    }

                    if (possValues[r][c].size() == 1 && this.values[r][c].equals("")) {
                        this.values[r][c] = (String) possValues[r][c].toArray()[0];
                        updated = true;
                    }
                }
            }
        }


    }

    public static Sudoku solve(String filename) throws Exception {
        Sudoku a = Sudoku.sudokuFromFile(filename);
        a.display();
        a.solve();
        System.out.println("\n======================\n");
        a.display();
        return a;
    }

    public static void main(String[] args) throws Exception {
        solve("sudokutest.csv");
    }
}