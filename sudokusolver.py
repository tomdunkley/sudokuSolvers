import csv

class Sudoku:
    def __init__(this, file=""):
        this.values = [["" for i in range (9)] for j in range(9)]
        if file != "":
            with open(file) as csvFile:
                csvReader = csv.reader(csvFile)
                r = 0
                for row in csvReader:
                    for c in range(9):
                        v = row[c]
                        if v in ["1","2","3","4","5","6","7","8","9"]:
                            this.values[r][c] = v
                    r += 1

    def display(this):
        for r in range(9):
            for c in range(9):
                print(this.values[r][c] if this.values[r][c] != "" else " ", end="")
                print("|" if (c%3 == 2 and c!=8) else "", end="")
            print("\n-----------" if (r%3 == 2 and r!=8) else "")

    

    def solve(this):
       
        possValues = [[[str(v) for v in range(1,10)] if (this.values[r][c] == "") else [this.values[r][c]] for c in range (9)] for r in range(9)]
        #print(this.values)
        
        updated = True
        while updated:
            for vr in range(9):
                for vc in range(9):
                    v = this.values[vr][vc]
                    if v != "":
                        
                        # Do box
                        for r in range((vr//3)*3, (vr//3)*3+3):
                            for c in range((vc//3)*3, (vc//3)*3+3):
                                if r!=vr or c!=vc:
                                    try:
                                        possValues[r][c].remove(v)
                                        if possValues[r][c] == []:
                                            print("BOX", v, vr, vc)
                                    except ValueError:
                                        continue

                        # Do row
                        r = vr
                        for c in range(9):
                            if c!=vc:
                                try:
                                    possValues[r][c].remove(v)
                                    if possValues[r][c] == []:
                                        print("ROW", v, vr, vc)
                                except ValueError:
                                    continue

 
                        # Do column
                        c = vc
                        for r in range(9):
                             if r!=vr:
                                try:
                                    possValues[r][c].remove(v)
                                    if possValues[r][c] == []:
                                        print("COL", v, vr, vc)
                                except ValueError:
                                    continue

 
            updated = False
            for r in range(9):
                for c in range(9):
                    if len(possValues[r][c]) == 0:
                        print(possValues)
                        raise Exception("Can't solve this soduko")

                    if len(possValues[r][c]) == 1 and this.values[r][c] == "":
                        this.values[r][c] = possValues[r][c][0]
                        updated = True
 
         
        

def solveSudoku(filename):       
    a = Sudoku(file=filename)
    a.display()
    print("\n========================\n")
    a.solve()
    a.display()


solveSudoku("sudokutest.csv")
