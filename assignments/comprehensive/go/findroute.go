package main

import (
    "fmt"
    "math"
    "os"
    "bufio"
    "strings"
    "strconv"
    "sort"
)

type Pool struct {
    name string
    lat float64
    lon float64
    closest string
}

type Edge struct {
    name string
    dist float64
}

// Tree stuff
type Tree struct {
    data Pool
    children []*Tree
}

func traverse(t *Tree, ch chan Pool) {
    if t == nil {
        return
    }

    ch <- t.data
    for i := range t.children {
        traverse(t.children[i], ch)
    }
}

func traverseTree(t *Tree) <-chan Pool {
    ch:= make(chan Pool)
    go func() {
        traverse(t, ch)
        close(ch)
    }()
    return ch
}

func insert(t *Tree, p Pool, parent string) *Tree {
    if t == nil {
        return nil
    }

    if (t.data.name == parent) {
        t.children = append(t.children, &Tree{p, nil})
    } else {
        var tempChildren []*Tree
        for i := range t.children {
            tempChildren = append(tempChildren, insert(t.children[i], p, parent))
        }
        t.children = tempChildren
    }
    return t
}

// Distance calculations
func convertToRad(deg float64) (float64) {
    return float64(math.Pi*(deg/180.0))
}

func innerPart(l1, l2 float64) (float64) {
    return math.Pow(math.Sin((l1-l2)/2),2)
}

func getDistance(A,B Pool) (dist float64) {
    latRadA := convertToRad(A.lat)
    lonRadA := convertToRad(A.lon)
    latRadB := convertToRad(B.lat)
    lonRadB := convertToRad(B.lon)
    lat := innerPart(latRadA, latRadB)
    lon := innerPart(lonRadA, lonRadB)
    drad := 2*math.Asin(math.Sqrt(lat+(math.Cos(latRadA)*math.Cos(latRadB)*lon)))
    return 6371.0*drad
}

// Reading from file
func getPoolsFromFile (file string) ([]Pool) {
    f, err := os.Open(file)
    if err != nil {
        fmt.Println(err)
    }
    defer f.Close()

    var pools []Pool
    scanner := bufio.NewScanner(f)
    for scanner.Scan() {
        s := strings.Split(scanner.Text(),",")
        latTemp, _ := strconv.ParseFloat(s[2], 64)
        lonTemp, _ := strconv.ParseFloat(s[1], 64)
        tempPool := Pool{s[0],latTemp,lonTemp, ""}
        pools = append(pools, tempPool)
    }

    if err := scanner.Err(); err != nil {
        fmt.Println(err)
    }

    sort.Sort(byLon(pools))
    return pools
}

// Custom sort operator for west -> east
type byLon []Pool

func (p byLon) Len() int {
    return len(p)
}

func (p byLon) Swap(i, j int) {
    p[i], p[j] = p[j], p[i]
}

func (p byLon) Less(i, j int) bool {
    return p[i].lon < p[j].lon
}


// Calculate the closest pool
func getClosest(p Pool, westPools []Pool) (string) {
    var dist float64
    dist = -1
    var closest string

    for i := range westPools {
        tempDist := getDistance(p, westPools[i])
        if (tempDist < dist || dist == -1) {
            dist = tempDist
            closest = westPools[i].name
        }
    }
    return closest
}

func findClosest(p, westPools []Pool, ch chan []Pool) {
    for i := range p {
        closest := getClosest(p[i], westPools[:len(westPools)-len(p)+i])
        p[i].closest = closest
    }
    ch <- p
}

func findRoute(filename string, num int) (route []Edge){
    pools := getPoolsFromFile(filename)
    ch := make(chan []Pool, num)
    chlengths := (len(pools)-1)/num
    go func() {
        for i := 0; i < num; i++ {
            findClosest(pools[chlengths*i+1:chlengths*(i+1)+1], pools[:chlengths*(i+1)+1], ch)
        }
        close(ch)
    }()

    var updatedPools []Pool
    for i:= range ch {
        updatedPools = append(updatedPools, i...)
    }

    root := &Tree{pools[0], nil}
    for i := range updatedPools {
        root = insert(root, updatedPools[i], updatedPools[i].closest)
    }

    chTree := traverseTree(root)
    var poolList []Pool
    for i := range chTree {
        poolList = append(poolList, i)
    }

    var path []Edge
    prevPool := poolList[0]
    var totalDist float64 = 0
    for i := range poolList {
        totalDist += getDistance(prevPool, poolList[i])
        path = append(path, Edge{poolList[i].name, totalDist})
        prevPool = poolList[i]
    }
    return path
}

func saveRoute(route []Edge, filename string) bool {
    file, err := os.Create(filename)
    if err != nil {
        fmt.Println(err)
    }

    defer file.Close()

    for i := range route {
        fmt.Fprintf(file, "%v %v\n", route[i].name, route[i].dist)
    }

    return true
}


func main() {
    path := findRoute("pools-go.txt", 10)
    retVal := saveRoute(path, "path-go.txt")
    fmt.Printf("%v\n",retVal)
}