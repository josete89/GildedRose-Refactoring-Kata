
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
    
    private func notSulfuras(_ name:String) -> Bool{
        return name != "Sulfuras, Hand of Ragnaros"
    }
    
    private func increase(_ quality:Int) -> Int {
        return quality + 1
    }
    
    private func deacrese(_ quality:Int) -> Int {
        return quality - 1
    }
    
    private func thereIsNoCuality(_ quality:Int,name:String) -> Int{
        if (quality > 0) {
            if (notSulfuras(name)) {
                return deacrese(quality)
            }
        }
        return quality
    }
    
    public func updateQuality() {
        
        let updatedItems = self.items.map({ item -> Item in
            
            let name = item.name
            var quality = item.quality
            var sellIn = item.sellIn
            
            if(notAgedBrie(name) && notBackstage(name)){
                quality = thereIsNoCuality(quality, name: name)
                
            }else{
                if (quality < qualityTreshold) {
                    quality =  increase(quality)
                    if (name == "Backstage passes to a TAFKAL80ETC concert") {
                        if (sellIn < 11) {
                            if (quality < qualityTreshold) {
                                quality = increase(quality)
                            }
                        }
                        if (sellIn < 6) {
                            if (quality < qualityTreshold) {
                                quality = increase(quality)
                            }
                        }
                    }
                }
            }

            if (notSulfuras(name)) {
                sellIn = sellIn - 1
            }
            
            if (sellIn < 0) {
                if (notAgedBrie(name)) {
                    if (notBackstage(name)) {
                        quality = thereIsNoCuality(quality, name: name)
                    } else {
                        quality = 0
                    }
                } else {
                    if (quality < qualityTreshold) {
                        quality = increase(quality)
                    }
                }
            }
            
            item.name = name
            item.sellIn = sellIn
            item.quality = quality
            
            return item
        })
        
        self.items = updatedItems
        
    }
}
