//
//  ArrayDicSetTest.swift
//  SwiftLogin
//
//  Created by gao on 16/10/21.
//  Copyright © 2016年 Gao. All rights reserved.
// swift4.0 学习
// http://www.swift51.com/swift4.0/chapter2/04_Collection_Types.html

import UIKit
import Foundation

/* swift 声明数组 的三种写法有什么不同？
 var users: [Users] = [] ， var adminUsers = [Users]()，var mapperUsers: [Users]?
 https://www.zhihu.com/question/53020783/answer/133081305
 
 官方推荐第一种。能用literal的尽量使用literal。
 同理：集合 let names: Set<String> = []
 
 前两种效果一样的吧，第一种显式声明了类型，第二种type inference 推导出类型。简单类型我倾向于第二种写法，看起来更清爽。只是类型推导在判断一些复杂类型时，有些坑，Xcode甚至会假死，需要显式声明类型来避开。第三种类型就不一样了，是optional。
  */

/* <#注释#>
 Swift 语言提供Arrays、Sets和Dictionaries三种基本的集合类型用来存储集合数据。数组（Arrays）是有序数据的集。集合（Sets）是无序无重复数据的集。字典（Dictionaries）是无序的键值对的集。
 用let声明的集合即为不可变的
 用var声明的集合即为可变的
 */

class ArrayDicSetTest: NSObject {

    //创建时 没有自动生成 要手动写个初始化方法，方便调用
    override init() {
        
    }
    
    // MARK: Array
    func arrayMethod() -> Array<Any> {
        
        //没有指定类型
        let array = Array<Any>()
//        let array2 = Array.init(objects: "123",12,"adfa")
        
        print(array)
        
        //创建一个Int类型的空数组
        var someInts = [Int]()
        
        //Swift 中的Array类型还提供一个可以创建特定大小并且所有数据都被默认的构造方法。我们可以把准备加入新数组的数据项数量（count）和适当类型的初始值（repeating）传入数组构造函数：
        var threeDoubles = Array(repeating: 0.0, count: 3)
        // threeDoubles 是一种 [Double] 数组，等价于 [0.0, 0.0, 0.0]
        
        /* 通过两个数组相加创建一个数组
         我们可以使用加法操作符（+）来组合两种已存在的相同类型数组。新数组的数据类型会被从两个数组的数据类型中推断出来：
         */
        var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
        // anotherThreeDoubles 被推断为 [Double]，等价于 [2.5, 2.5, 2.5]
        
        var sixDoubles = threeDoubles + anotherThreeDoubles
        // sixDoubles 被推断为 [Double]，等价于 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
        
        var shoppingList: [String] = ["Eggs", "Milk"]
        // shoppingList 已经被构造并且拥有两个初始项。
        
        //由于 Swift 的类型推断机制，当我们用字面量构造只拥有相同类型值数组的时候，我们不必把数组的类型定义清楚。
        //因为所有数组字面量中的值都是相同的类型，Swift 可以推断出[String]是shoppingList中变量的正确类型。
        var shoppingList2 = ["Eggs", "Milk"]
        
        //使用append(_:)方法在数组后面添加新的数据项：
        shoppingList.append("Flour")
        // shoppingList 现在有3个数据项，有人在摊煎饼
        // 除此之外，使用加法赋值运算符（+=）也可以直接在数组后面添加一个或多个拥有相同类型的数据项：
        shoppingList += ["Baking Powder"]
        // shoppingList 现在有四项了
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
        // shoppingList 现在有七项了
        // 可以直接使用下标语法来获取数组中的数据项，把我们需要的数据项的索引值放在直接放在数组名称的方括号中：
        
        var firstItem = shoppingList[0]
        // 第一项是 "Eggs"
        
        //用下标来改变某个已有索引值对应的数据值：
        shoppingList[0] = "Six eggs"
        // 其中的第一项现在是 "Six eggs" 而不是 "Eggs"
        
        // 还可以利用下标来一次改变一系列数据值，即使新数据和原有数据的数量是不一样的。下面的例子把"Chocolate Spread"，"Cheese"，和"Butter"替换为"Bananas"和 "Apples"：
        shoppingList[4...6] = ["Bananas", "Apples"]
        // shoppingList 现在有6项
        
        //调用数组的insert(_:at:)方法来在某个具体索引值之前添加数据项：
        
        shoppingList.insert("Maple Syrup", at: 0)
        // shoppingList 现在有7项
        // "Maple Syrup" 现在是这个列表中的第一项
        // 这次insert(_:at:)方法调用把值为"Maple Syrup"的新数据项插入列表的最开始位置，并且使用0作为索引值。
        
        // 类似的我们可以使用remove(at:)方法来移除数组中的某一项。这个方法把数组在特定索引值中存储的数据项移除并且返回这个被移除的数据项（我们不需要的时候就可以无视它）：
        
        let mapleSyrup = shoppingList.remove(at: 0)
        // 索引值为0的数据项被移除
        // shoppingList 现在只有6项，而且不包括 Maple Syrup
        // mapleSyrup 常量的值等于被移除数据项的值 "Maple Syrup"
        
        // 把数组中的最后一项移除，可以使用removeLast()方法而不是remove(at:)方法来避免我们需要获取数组的count属性。
        
        let apples = shoppingList.removeLast()
        // 数组的最后一项被移除了
        // shoppingList 现在只有5项，不包括 Apples
        // apples 常量的值现在等于 "Apples" 字符串
        
        //数组的遍历
        for item in shoppingList {
            print(item)
        }
        
        //如果我们同时需要每个数据项的值和索引值，可以使用enumerated()方法来进行数组遍历。enumerated()返回一个由每一个数据项索引值和数据值组成的元组。我们可以把这个元组分解成临时常量或者变量来进行遍历：
        for (index, value) in shoppingList.enumerated() {
            print("Item \(String(index + 1)): \(value)")
        }
        // Item 1: Six eggs
        // Item 2: Milk
        // Item 3: Flour
        // Item 4: Baking Powder
        // Item 5: Bananas
        
        return array
    }
    
    // MARK: Set
    /* 哈希化/哈希值
     一个类型为了存储在集合中，该类型必须是可哈希化的--也就是说，该类型必须提供一个方法来计算它的哈希值。一个哈希值是Int类型的，相等的对象哈希值必须相同，比如a==b,因此必须a.hashValue == b.hashValue。
     Swift 的所有基本类型(比如String,Int,Double和Bool)默认都是可哈希化的，可以作为集合的值的类型或者字典的键的类型。没有关联值的枚举成员值(在枚举有讲述)默认也是可哈希化的。
     Hashable协议。符合Hashable协议的类型需要提供一个类型为Int的可读属性hashValue。
     因为Hashable协议符合Equatable协议，所以遵循该协议的类型也必须提供一个"是否相等"运算符(==)的实现。这个Equatable协议要求任何符合==实现的实例间都是一种相等的关系。也就是说，对于a,b,c三个值来说，==的实现必须满足下面三种情况：
     a == a(自反性)
     a == b意味着b == a(对称性)
     a == b && b == c意味着a == c(传递性)
     */
    
    /* <#注释#>
     Swift 中的Set类型被写为Set<Element>，这里的Element表示Set中允许存储的类型，和数组不同的是，集合没有等价的简化形式。
     */
    func setMethod() -> Set<String> {
        
        let set = Set<String>.init()
        
        //你可以通过构造器语法创建一个特定类型的空集合：
        var letters = Set<Character>()
        print("letters is of type Set<Character> with \(letters.count) items.")
        // 打印 "letters is of type Set<Character> with 0 items."
        
        //你可以使用数组字面量来构造集合，并且可以使用简化形式写一个或者多个值作为集合元素。
        //下面的例子创建一个称之为favoriteGenres的集合来存储String类型的值：
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
        // favoriteGenres 被构造成含有三个初始值的集合
        /* 注意：
         favoriteGenres被声明为一个变量(拥有var标示符)而不是一个常量(拥有let标示符),因为它里面的元素将会在下面的例子中被增加或者移除。
         */
        
        print("I have \(favoriteGenres.count) favorite music genres.")
        // 打印 "I have 3 favorite music genres."
        //使用布尔属性isEmpty作为一个缩写形式去检查count属性是否为0：
        
        if favoriteGenres.isEmpty {
            print("As far as music goes, I'm not picky.")
        } else {
            print("I have particular music preferences.")
        }
        // 打印 "I have particular music preferences."
        //你可以通过调用Set的insert(_:)方法来添加一个新元素：
        favoriteGenres.insert("Jazz")
        // favoriteGenres 现在包含4个元素
        
        //你可以通过调用Set的remove(_:)方法去删除一个元素，如果该值是该Set的一个元素则删除该元素并且返回被删除的元素值，否则如果该Set不包含该值，则返回nil。另外，Set中的所有元素可以通过它的removeAll()方法删除。
        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")
        } else {
            print("I never much cared for that.")
        }
        // 打印 "Rock? I'm over it."
        
        //使用contains(_:)方法去检查Set中是否包含一个特定的值：
        if favoriteGenres.contains("Funk") {
            print("I get up on the good foot.")
        } else {
            print("It's too funky in here.")
        }
        // 打印 "It's too funky in here."
        
        //遍历一个集合
        //你可以在一个for-in循环中遍历一个Set中的所有值。
        for genre in favoriteGenres {
            print("\(genre)")
        }
        // Classical
        // Jazz
        // Hip hop
        
        //Swift 的Set类型没有确定的顺序，为了按照特定顺序来遍历一个Set中的值可以使用sorted()方法，它将返回一个有序数组，这个数组的元素排列顺序由操作符'<'对元素进行比较的结果来确定.
        for genre in favoriteGenres.sorted() {
            print("\(genre)")
        }
        // prints "Classical"
        // prints "Hip hop"
        // prints "Jazz
        
        return set
    }
    
    //集合的基本操作
    func actionSet() -> Void {
        /* 基本集合操作
         下面的插图描述了两个集合-a和b-以及通过阴影部分的区域显示集合各种操作的结果。
         使用intersection(_:)方法根据两个集合中都包含的值创建的一个新的集合。---- 集合A/B都有的集合
         使用symmetricDifference(_:)方法根据在一个集合中但不在两个集合中的值创建一个新的集合。---- 除去集合A/B中都有的元素后外的集合
         使用union(_:)方法根据两个集合的值创建一个新的集合。---- 合并两个结合。
         使用subtracting(_:)方法根据不在该集合中的值创建一个新的集合。---- 在结合A中不在集合B中。
         */
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        
        oddDigits.union(evenDigits).sorted()
        // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        oddDigits.intersection(evenDigits).sorted()
        // []
        oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
        // [1, 9]
        oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
        // [1, 2, 9]
    }
    
    /*  集合成员关系和相等
     下面的插图描述了三个集合-a,b和c,以及通过重叠区域表述集合间共享的元素。集合a是集合b的父集合，因为a包含了b中所有的元素，相反的，集合b是集合a的子集合，因为属于b的元素也被a包含。集合b和集合c彼此不关联，因为它们之间没有共同的元素。
     使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
     使用isSubset(of:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
     使用isSuperset(of:)方法来判断一个集合中包含另一个集合中所有的值。
     使用isStrictSubset(of:)或者isStrictSuperset(of:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
     使用isDisjoint(with:)方法来判断两个集合是否不含有相同的值(是否没有交集)。
     */
    func conterSet() -> Void {
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
        
        houseAnimals.isSubset(of: farmAnimals)
        // true
        farmAnimals.isSuperset(of: houseAnimals)
        // true
        farmAnimals.isDisjoint(with: cityAnimals)
        // true
    }
   
    // MARK: Dictionary
    /* 字典类型简化语法
     Swift 的字典使用Dictionary<Key, Value>定义，其中Key是字典中键的数据类型，Value是字典中对应于这些键所存储值的数据类型。
     注意：
     一个字典的Key类型必须遵循Hashable协议，就像Set的值类型。
     我们也可以用[Key: Value]这样简化的形式去创建一个字典类型。虽然这两种形式功能上相同，但是后者是首选，并且这本指导书涉及到字典类型时通篇采用后者。
     我们也可以用[Key: Value]这样简化的形式去创建一个字典类型。虽然这两种形式功能上相同，但是后者是首选，并且这本指导书涉及到字典类型时通篇采用后者。
     */
    func dictionaryMethod() -> Dictionary<String, Any> {
        
        let dic33 = Dictionary<String, Any>()
        
        //        let dic2 = Dictionary.init(objects: ["key1","key2"], forKeys: ["value1" as NSCopying,"value2" as NSCopying])
        //        print(dic2)
        
        
        // 简写
        var dic:Dictionary = ["swiftKey":"swift"]
        
        //        let adad = dic.object(forKey: "swift")
        
        // 例子
        var dic123 = NSDictionary(objects: ["张三","OC"], forKeys: ["name" as NSCopying,"OCKey" as NSCopying])
        
        //创建一个空字典
        //我们可以像数组一样使用构造语法创建一个拥有确定类型的空字典：
        var namesOfIntegers = [Int: String]()
        // namesOfIntegers 是一个空的 [Int: String] 字典
        //这个例子创建了一个[Int: String]类型的空字典来储存整数的英语命名。它的键是Int型，值是String型。
        //如果上下文已经提供了类型信息，我们可以使用空字典字面量来创建一个空字典，记作[:]（中括号中放一个冒号）：
        namesOfIntegers[16] = "sixteen"
        // namesOfIntegers 现在包含一个键值对
        namesOfIntegers = [:]
        // namesOfIntegers 又成为了一个 [Int: String] 类型的空字
        
        /*  用字典字面量创建字典
         我们可以使用字典字面量来构造字典，这和我们刚才介绍过的数组字面量拥有相似语法。字典字面量是一种将一个或多个键值对写作Dictionary集合的快捷途径。
         一个键值对是一个key和一个value的结合体。在字典字面量中，每一个键值对的键和值都由冒号分割。这些键值对构成一个列表，其中这些键值对由方括号包含、由逗号分割：
         [key 1: value 1, key 2: value 2, key 3: value 3]
         下面的例子创建了一个存储国际机场名称的字典。在这个字典中键是三个字母的国际航空运输相关代码，值是机场名称：
         */
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        //airports字典被声明为一种[String: String]类型，这意味着这个字典的键和值都是String类型。
        /* 注意：
         airports字典被声明为变量（用var关键字）而不是常量（let关键字）因为后来更多的机场信息会被添加到这个示例字典中。
         
         airports字典也可以用这种简短方式定义：
         var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
         因为这个语句中所有的键和值都各自拥有相同的数据类型，Swift 可以推断出Dictionary<String, String>是airports字典的正确类型。
         */
        
        //和数组一样，我们可以通过字典的只读属性count来获取某个字典的数据项数量：
        print("The dictionary of airports contains \(airports.count) items.")
        // 打印 "The dictionary of airports contains 2 items."（这个字典有两个数据项）
        //使用布尔属性isEmpty作为一个缩写形式去检查count属性是否为0：
        if airports.isEmpty {
            print("The airports dictionary is empty.")
        } else {
            print("The airports dictionary is not empty.")
        }
        // 打印 "The airports dictionary is not empty."
        //我们也可以在字典中使用下标语法来添加新的数据项。可以使用一个恰当类型的键作为下标索引，并且分配恰当类型的新值：
        airports["LHR"] = "London"
        // airports 字典现在有三个数据项
        //我们也可以使用下标语法来改变特定键对应的值：
        airports["LHR"] = "London Heathrow"
        // "LHR"对应的值 被改为 "London Heathrow
        
        /*
         作为另一种下标方法，字典的updateValue(_:forKey:)方法可以设置或者更新特定键对应的值。就像上面所示的下标示例，updateValue(_:forKey:)方法在这个键不存在对应值的时候会设置新值或者在存在时更新已存在的值。和上面的下标方法不同的，updateValue(_:forKey:)这个方法返回更新值之前的原值。这样使得我们可以检查更新是否成功。
         updateValue(_:forKey:)方法会返回对应值的类型的可选值。举例来说：对于存储String值的字典，这个函数会返回一个String?或者“可选 String”类型的值。
         如果有值存在于更新前，则这个可选值包含了旧值，否则它将会是nil。
         */
        
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        // 输出 "The old value for DUB was Dublin."
        
        // 我们也可以使用下标语法来在字典中检索特定键对应的值。因为有可能请求的键没有对应的值存在，字典的下标访问会返回对应值的类型的可选值。如果这个字典包含请求键所对应的值，下标会返回一个包含这个存在值的可选值，否则将返回nil：
        if let airportName = airports["DUB"] {
            print("The name of the airport is \(airportName).")
        } else {
            print("That airport is not in the airports dictionary.")
        }
        // 打印 "The name of the airport is Dublin Airport."
        
        // 我们还可以使用下标语法来通过给某个键的对应值赋值为nil来从字典里移除一个键值对：
        airports["APL"] = "Apple Internation"
        // "Apple Internation" 不是真的 APL 机场, 删除它
        airports["APL"] = nil
        // APL 现在被移除了
        
        // 此外，removeValue(forKey:)方法也可以用来在字典中移除键值对。这个方法在键值对存在的情况下会移除该键值对并且返回被移除的值或者在没有值的情况下返回nil：
        if let removedValue = airports.removeValue(forKey: "DUB") {
            print("The removed airport's name is \(removedValue).")
        } else {
            print("The airports dictionary does not contain a value for DUB.")
        }
        // prints "The removed airport's name is Dublin Airport."
        
        /* 字典遍历
         我们可以使用for-in循环来遍历某个字典中的键值对。每一个字典中的数据项都以(key, value)元组形式返回，并且我们可以使用临时常量或者变量来分解这些元组.
         */
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
        // YYZ: Toronto Pearson
        // LHR: London Heathrow
        
        // 通过访问keys或者values属性，我们也可以遍历字典的键或者值：
        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        // Airport code: YYZ
        // Airport code: LHR
        
        for airportName in airports.values {
            print("Airport name: \(airportName)")
        }
        // Airport name: Toronto Pearson
        // Airport name: London Heathrow
        
        // 如果我们只是需要使用某个字典的键集合或者值集合来作为某个接受Array实例的 API 的参数，可以直接使用keys或者values属性构造一个新数组：
        let airportCodes = [String](airports.keys)
        // airportCodes 是 ["YYZ", "LHR"]
        
        let airportNames = [String](airports.values)
        // airportNames 是 ["Toronto Pearson", "London Heathrow"]
        // Swift 的字典类型是无序集合类型。为了以特定的顺序遍历字典的键或值，可以对字典的keys或values属性使用sorted()方法。
        
        return dic
    }
    
    func dictinaryMethod22() -> Void {
        //        let dic = Dictionary.init()
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        let ddd = airports["XYZ"]
    }
    
    func dictionaryArrayMethod() -> Array<Any> {
        
        let array = Array<Any>.init()
        
        return array
    }
    
}
