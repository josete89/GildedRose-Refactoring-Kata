
public class GildedRose {
    var items:[Item]

    let qualityTreshold = 50
    let sellTreshold = 11
    
    required public init(items:[Item]) {
        self.items = items
    }

    private func notAgedBrie(_ name:String) -> Bool {
        return name != "Aged Brie"
    }

    private func notBackstage(_ name:String) -> Bool{
        return name != "Backstage passes to a TAFKAL80ETC concert"
    }

    
    public func updateQuality() {
        
        let updatedItems = self.items.map({ item -> Item in
            let newItem = item
            
            let name = item.name
            var quality = item.quality
            var sellIn = item.sellIn
            
            if(notAgedBrie(name) && notBackstage(name)){
                if (quality > 0) {
                    if (name != "Sulfuras, Hand of Ragnaros") {
                        quality = quality - 1
                    }
                }
            }else{
                if (quality < qualityTreshold) {
                    quality = quality + 1
                    
                    if (name == "Backstage passes to a TAFKAL80ETC concert") {
                        if (sellIn < 11) {
                            if (quality < qualityTreshold) {
                                quality = quality + 1
                            }
                        }
                        
                        if (sellIn < 6) {
                            if (quality < qualityTreshold) {
                                quality = quality + 1
                            }
                        }
                    }
                }
            }

            if (name != "Sulfuras, Hand of Ragnaros") {
                sellIn = sellIn - 1
            }
            
            if (sellIn < 0) {
                if (notAgedBrie(name)) {
                    if (notBackstage(name)) {
                        if (quality > 0) {
                            if (name != "Sulfuras, Hand of Ragnaros") {
                                quality = quality - 1
                            }
                        }
                    } else {
                        quality = quality - quality
                    }
                } else {
                    if (quality < qualityTreshold) {
                        quality = quality + 1
                    }
                }
            }
            
            //print(" actual -> \(newItem)")
            //print(" new -> \(Item(name: newItem.name, sellIn: newItem.sellIn, quality: newItem.quality))")
            //return Item(name: newItem.name, sellIn: newItem.sellIn, quality: newItem.quality)
            
            newItem.name = name
            newItem.sellIn = sellIn
            newItem.quality = quality
            
            return item
        })
        
        self.items = updatedItems
        
    }
}
