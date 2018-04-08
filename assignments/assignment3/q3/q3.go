package main

import (
    "fmt"
    "math/rand"
    "math"
)

func AbsDiff(listA,listB []float32) []float32 {
    maxLength := math.Max(float64(len(listA)), float64(len(listB)))
    listC := make([]float32, int(maxLength))

    for i := range listC {
        var a, b float32 = 0, 0

        if i < len(listA) {
            a = listA[i]
        }

        if i < len(listB) {
            b = listB[i]
        }

        currDiff := math.Abs(float64(a) - float64(b))
        listC[i] = float32(currDiff)
    }

    return listC
}

func RandomArray(len int) []float32 {
    array := make([]float32, len)
    for i := range array {
        array[i] = rand.Float32()
    }
    return array
}

func Process(inArr []float32, out chan float32) {
    diffedArr := AbsDiff(inArr[len(inArr)/2:], inArr[:len(inArr)/2])
    var sum float32 = 0
    for i := range diffedArr {
        sum += diffedArr[i]
    }
    out <- sum
}

func main() {
    rand.Seed(100)

    out := make(chan float32)
    defer close(out)

    for i := 0; i<1000; i++ {
        a := RandomArray(2*(50+rand.Intn(50)))
        go Process(a, out)
    }

    var sum float32 = 0
    for i := 0; i< 1000; i++ {
        newVal := <-out
        sum += newVal
    }

    fmt.Println(sum)
}