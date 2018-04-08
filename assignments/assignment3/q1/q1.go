package main

import (
    "fmt"
    "errors"
    "strings"
    "strconv"
    "bufio"
    "os"
    "math"
)

func AbsDiff(sliceA, sliceB []float32, version int) (res []float32, err error) {
    if (math.Abs(float64(version)) > 1) {
        err = errors.New("Bad version input")
        return
    }

    if (version == 0) {
        if len(sliceA) != len(sliceB) {
            err = errors.New("Slices are not the same length")
            return
        } else {
            res = make([]float32, len(sliceA))
        }
    } else if version == 1 {
        if (len(sliceA) >= len(sliceB)) {
            res = make([]float32, len(sliceB))
        } else {
            res = make([]float32, len(sliceA))
        }
    } else {
        if (len(sliceA) >= len(sliceB)) {
            res = make([]float32, len(sliceA))
        } else {
            res = make([]float32, len(sliceB))
        }
    }

    for i:= range res {
        var a float32
        var b float32

        if i >= len(sliceA) {
            a = 0
        } else {
            a = sliceA[i]
        }

        if i >= len(sliceB) {
            b = 0
        } else {
            b = sliceB[i]
        }

        res[i] = float32(math.Abs(float64(a - b)))
    }
    return
}

func main() {
    var a []float32
    a = []float32{3.2,-6.77,42,-0.9}
    cond := "c"
    reader:= bufio.NewReader(os.Stdin)

    for cond != "q" {
        fmt.Printf("Previous slice: %v\n",a)
        fmt.Print("Enter another slice of FPNs: ")
        badInput := false

        // Split the input and throw it into b
        var inputSplit []string
        input,_ := reader.ReadString('\n')
        input = strings.Trim(input,"\n")
        inputSplit = strings.Split(input, " ")
        b := make([]float32, len(inputSplit))
        for i:= range b {
            c,err := strconv.ParseFloat(inputSplit[i],32)
            if err != nil {
                fmt.Println(err)
                badInput = true
                break
            }
            b[i] = float32(c)
        }

        // Run the difference
        if !badInput {
            fmt.Print("What version of 'AbsDiff' do you want to run?: ")
            var ver string
            fmt.Scanln(&ver)
            verInt,err := strconv.Atoi(ver)
            if err != nil {
                fmt.Println(err)
            } else {
                res,err := AbsDiff(a,b,verInt)
                if err != nil {
                    fmt.Println(err)
                } else {
                    fmt.Printf("Result: %v\n", res)
                    a = b
                }
                badInput = false
            }
        }
        fmt.Print("q to quit (Anything else to continue): ")
        fmt.Scanln(&cond)
    }
}