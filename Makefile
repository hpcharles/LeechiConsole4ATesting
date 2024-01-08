
CFLAGS = -march=rv64imfv 
FILES = A.1-VectorAdd-Example.o A.2-MixedWidthMaskAndCompute.o		\
A.3-MemCpy-Example.o A.4-Conditionnal-Example.o A.5-Saxpy-Example.o	\
A.6-SGEMM-Example.o


all: ${FILES}
