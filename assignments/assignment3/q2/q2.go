package main

import "fmt"

type Baker interface {
    shoppingList(map[string]Item) map[string]Item
    printBakeInstructions()
    printBreadInfo()
}

type Bread struct {
    name string
    ingredients map[string]Item
    weight float32
    Baking
}

type Baking struct {
    bakeTime, coolTime, temperature int
}

type Item struct{
    weight int
}

func (b *Bread) shoppingList(currentItems map[string]Item) (neededItems, leftOverItems map[string]Item) {
    neededItems = make(map[string]Item)
    leftOverItems = make(map[string]Item)
    for k,v := range b.ingredients {
        if currentVal, ok := currentItems[k]; ok {
            neededWeight := currentVal.weight - v.weight
            if neededWeight < 0 {
                neededWeight *= -1
                neededItems[k] = Item{neededWeight}
            } else if neededWeight > 0 {
                leftOverItems[k] = Item{neededWeight}
            }
        } else {
            neededItems[k] = Item{v.weight}
        }
    }
    return
}

func (b *Bread) printBakeInstructions() {
    fmt.Printf("Bake at %v Celsius for %v minutes and let cool for %v minutes.\n", b.Baking.temperature, b.Baking.bakeTime, b.Baking.coolTime)
}

func (b *Bread) printBreadInfo() {
    fmt.Printf("%v\n", b.name)
    fmt.Printf("%v\n", b.ingredients)
    fmt.Printf("Weight %v kg\n", (b.weight/1000))
}

func NewBread() *Bread {
    return &Bread {
        name: "Whole Wheat bread",
        ingredients: map[string]Item {
            "whole wheat flour": {500},
            "yeast": {25},
            "salt": {25},
            "sugar": {50},
            "butter": {50},
            "water": {350},
        },
        weight: 1000,
        Baking: Baking {
            bakeTime: 120,
            coolTime: 60,
            temperature: 180,
        },
    }
}

func NewBreadVariation(name string, added, removed map[string]Item) *Bread {
    defaultIngredients := map[string]Item {
        "whole wheat flour": {500},
        "yeast": {25},
        "salt": {25},
        "sugar": {50},
        "butter": {50},
        "water": {350},
    }

    if added != nil {
        for k,v := range added {
            if defaultVal, ok := defaultIngredients[k]; ok {
                newWeight := v.weight + defaultVal.weight
                defaultIngredients[k] = Item{newWeight}
            } else {
                defaultIngredients[k] = v
            }
        }
    }

    if removed != nil {
        for k,v := range removed {
            if defaultVal, ok := defaultIngredients[k]; ok {
                tempV := defaultVal.weight - v.weight
                if tempV < 0 {
                    delete(defaultIngredients,k)
                } else {
                    defaultIngredients[k] = Item{tempV}
                }
            }
        }
    }

    var weight int
    weight = 0
    for _,v := range defaultIngredients {
        weight += v.weight
    }

    return &Bread {
        name: name,
        ingredients: defaultIngredients,
        weight: float32(weight),
        Baking: Baking {
            bakeTime: 120,
            coolTime: 60,
            temperature: 180,
        },
    }
}

func mergeLists(listA,listB map[string]Item) (listC map[string]Item) {
    listC = make(map[string]Item)
    for k,v := range listA {
        listC[k] = Item{v.weight}
    }

    for k,v := range listB {
        if cVal, ok := listC[k]; ok {
            newWeight := v.weight + cVal.weight
            listC[k] = Item{newWeight}
        } else {
            listC[k] = Item{v.weight}
        }
    }
    return
}

func main() {
    wholeWheatBread := NewBread()
    sesameBread := NewBreadVariation(
        "Sesame bread",
        map[string]Item {
            "white flour": {200},
            "sesame": {50},
        },
        map[string]Item {
            "whole wheat flour": {250},
        },
    )
    
    currentIngredients := map[string]Item {
        "whole wheat flour": {5000},
        "salt": {500},
        "sugar": {1000},
    }

    wholeWheatBread.printBreadInfo()
    fmt.Println()
    sesameBread.printBreadInfo()
    shoppingList, leftOvers := wholeWheatBread.shoppingList(currentIngredients)
    shoppingList2, _ := sesameBread.shoppingList(leftOvers)
    finalList := mergeLists(shoppingList,shoppingList2)
    fmt.Printf("\nShopping List: %v\n",finalList)
    fmt.Printf("\nBaking Instructions:\n")
    wholeWheatBread.printBakeInstructions()
    sesameBread.printBakeInstructions()
}