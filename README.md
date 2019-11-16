# SelectionSort
![](https://img.shields.io/badge/Development-Stopped-red)

Selection sort algorithm developed in ARM assembly. The algorithm has two lists as input, an Item_list and a Price_list. The Item_list contains the code of the product and the desired quantity, while the Price_list contains the code of the product and the price following the same notation, namely code (4 bytes) and quantity/price (4bytes)

DCD 0xXX, XX

The algorithm firstly performs the selection sort algorithm on the non ordered Price_list and store the ordered list in the heap section following the same notation of code (4 bytes) price (4bytes). With the odered list the algorithm looks at the Item_list and if the code of the product in the Item_list matches a code of a product on the Price_list the quantity price * quantity is stored in R10; this procedure is repeated for each item in the Item_list adding in R10 the quantity price * quantity. If a single item in the Item_list doesn't match a code on the Price_list at the end of the program R10 holds the value 0.  

## Tools

For this project the following tools were used
- Keil µVision 4 - ARM
