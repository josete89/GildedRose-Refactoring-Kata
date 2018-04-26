
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
    
    private func isBackstage(_ name:String) -> Bool{
        return name == "Backstage passes to a TAFKAL80ETC concert"
    }
    
    private func notSulfuras(_ name:String) -> Bool{
        return name != "Sulfuras, Hand of Ragnaros"
    }
    
    private func increaseQuality(_ quality:Int) -> Int {
        if (quality < qualityTreshold) {
            return quality + 1
        }
        return quality
    }
    
    private func deacrese(_ quality:Int) -> Int {
        return quality - 1
    }
    
    private func thereIsNoQuality(_ quality:Int,name:String) -> Int{
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
                quality = thereIsNoQuality(quality, name: name)
            }else{
                if (quality < qualityTreshold) {
                    quality =  quality + 1
                    if (isBackstage(name)) {
                        if (sellIn < 11) {
                            quality = increaseQuality(quality)
                        }
                        if (sellIn < 6) {
                            quality = increaseQuality(quality)
                        }
                    }
                }
            }

            if (notSulfuras(name)) {
                sellIn = sellIn - 1
            }
            
            if (sellIn < 0) {
                
                if(notAgedBrie(name) && notBackstage(name)) {
                    quality = thereIsNoQuality(quality, name: name)
                    
                }
                if (!notAgedBrie(name)){
                    quality = increaseQuality(quality)
                }
                if (isBackstage(name)){
                    quality = 0
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
