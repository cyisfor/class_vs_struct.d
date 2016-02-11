Classes versus Structs in D

tl;dr structs are slooooooow to allocate.

It allocates a bunch of big class objects, then a bunch of big struct objects, and times both operations. My result is around 277, meaning that makeClasses executes around 277 times faster than makeStructs. 277 with dmd, with gdc makeClasses is only 197 times faster.

I made sure to be absolutely stupid about memory allocation for classes, going with freeing each individual object explicitly instead of letting the garbage collector take it at leisure, so for normal use I suspect creating class objects is even faster than this benchmark.
