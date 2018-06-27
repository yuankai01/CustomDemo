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
 
 官方推荐第一种。能用literal的尽量使用literal。同理：
 let names: Set<String> = []
 
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
    
    // MARK: Dictionary
    func dictionaryMethod() -> Dictionary<String, Any> {
        
        let dic33 = Dictionary<String, Any>()

//        let dic2 = Dictionary.init(objects: ["key1","key2"], forKeys: ["value1" as NSCopying,"value2" as NSCopying])
//        print(dic2)
        
  
        // 简写
        var dic:Dictionary = ["swiftKey":"swift"]
        
//        let adad = dic.object(forKey: "swift")

        // 例子
        var dic123 = NSDictionary(objects: ["张三","OC"], forKeys: ["name" as NSCopying,"OCKey" as NSCopying])

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
    func setMethod() -> Set<String> {
        
        let set = Set<String>.init()
        
        return set
    }
   
}
