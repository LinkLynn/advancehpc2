NVCC=/usr/local/cuda/bin/nvcc
SAMPLES=/usr/local/cuda/samples/common/inc

INCLUDES=-I${SAMPLES} -I.
CFLAGS=-std=c++11

all: Exercise2

Exercise2: main.o chronoGPU.o chronoCPU.o D_Matrix.o H_Matrix.o Student.o
	${NVCC} ${CFLAGS} ${INCLUDES} $^ -o $@

main.o: main.cu utils/chronoGPU.hpp D_Matrix.cuh H_Matrix.cuh
	${NVCC} ${CFLAGS} ${INCLUDES} -c $< -o $@

chronoGPU.o: utils/chronoGPU.cu utils/chronoGPU.hpp
	${NVCC} ${CFLAGS} ${INCLUDES} -c $< -o $@

chronoCPU.o: utils/chronoCPU.cpp utils/chronoCPU.hpp
	${NVCC} ${CFLAGS} ${INCLUDES} -c $< -o $@

D_Matrix.o: D_Matrix.cu D_Matrix.cuh
	${NVCC} ${CFLAGS} ${INCLUDES} -c $< -o $@

H_Matrix.o: H_Matrix.cu H_Matrix.cuh
	${NVCC} ${CFLAGS} ${INCLUDES} -c $< -o $@

Student.o: Student.cu H_Matrix.cuh D_Matrix.cuh
	${NVCC} ${CFLAGS} ${INCLUDES} -c $< -o $@
