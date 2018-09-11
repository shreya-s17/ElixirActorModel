# SUMOFSQUARES

**Finding perfect square which are sums of consecutive squares**

## Group info
| Name  | UFID  |
|---|---|
| Amruta Basrur | 44634819  |
|  Shreya Singh| 79154462  |

## Instructions

1. Unzip Amruta_Shreya.zip file and navigate to Amruta_Shreya folder.
2. Open the command promt and enter the below mix command to compile and run the code.
</br>Input: Enter desired n and k value
</br>Output: Empty list or list of values satisfying given input </br>
**time mix run project1.exs n k** </br>
3. **Input:**
time mix run project1.exs 1000000 4</br>
**Output**</br>
[]</br>
real    0m2.727s</br>
user    0m5.563s</br>
sys     0m1.063s</br>
Here [] in the output indicate that no such values exist for given input.</br>
</br> **Real time** : 2.727 sec</br>
  **CPU time** : 5.563 + 1.063 = 6.626 sec</br>
  **Ratio** : 2.429 > 1</br>
  The Real/CPU time ratio has been calculated by dividing real time by user time + system time which is greater than 1.
4. Examples of various inputs and outputs</br></br>
![Outputs](/Sketch.png)
</br>
  

5. Size of the work was determined by trying different bulk sizes against different n, k. It came out to be a function of roots of input n. By trials, the best performance was obtained in the 8th root of n i.e (1/8th) power of n.

6. Largest problem solved is 100000000 2.

