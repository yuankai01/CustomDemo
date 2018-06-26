//
//  SwiftBaseDataCode.swift
//  CETCPartyBuilding
//
//  Created by gao on 2018/3/16.
//  Copyright © 2018年 Aaron Yu. All rights reserved.
//  swift 基本数据类型声明、赋值、取值、转换、打印

/*
 就像 C 语言一样，Swift 使用变量来进行存储并通过变量名来关联值。在 Swift 中，广泛的使用着值不可变的变量，它们就是常量，而且比 C 语言的常量更强大。在 Swift 中，如果你要处理的值不需要改变，那使用常量可以让你的代码更加安全并且更清晰地表达你的意图。
 
 除了我们熟悉的类型，Swift 还增加了 Objective-C 中没有的高阶数据类型比如元组（Tuple）。元组可以让你创建或者传递一组数据，比如作为函数的返回值时，你可以用一个元组可以返回多个值。
 
 Swift 还增加了可选（Optional）类型，用于处理值缺失的情况。可选表示 “那儿有一个值，并且它等于 x ” 或者 “那儿没有值” 。可选有点像在 Objective-C 中使用 nil ，但是它可以用在任何类型上，不仅仅是类。可选类型比 Objective-C 中的 nil 指针更加安全也更具表现力，它是 Swift 许多强大特性的重要组成部分。
 
 Swift 是一门类型安全的语言，这意味着 Swift 可以让你清楚地知道值的类型。如果你的代码期望得到一个 String ，类型安全会阻止你不小心传入一个 Int 。同样的，如果你的代码期望得到一个 String，类型安全会阻止你意外传入一个可选的 String 。类型安全可以帮助你在开发阶段尽早发现并修正错误。
 */

import UIKit

class SwiftBaseDataCode: UIView {
    /*
     * （4 + 4）中类型 :Int、Double、Float、Bool / String、Array、Set、Dictionary
     Swift 包含了 C 和 Objective-C 上所有基础数据类型，Int表示整型值； Double 和 Float 表示浮点型值； Bool 是布尔型值；String 是文本型数据。 Swift 还提供了三个基本的集合类型，Array ，Set 和 Dictionary ，详见集合类型。
     */
    
    //声明字符串
    /**
     *  创建空字符串
     *  此种写法，即使并没有给字符串进行赋值，当你打印的时候，会打印为空，而不会crash
     *  创建空字符串第二种写法
     *  建议使用“？”判断解析，当此变量没有值得时候，打印的话不会crash
     *  若使用“!”强制解析，当变量没有值的时候，打印的话，会crash
     */
    var string1 = String()
    var string2 : String?
    
    var string3 = ""
    var string33 = "hello word"
    
    
    //声明一个数组的三种方法：1显示声明类型、2推导出类型、3可选类型
    /*
     写 Swift 数组应该遵循像Array<Element>这样的形式，其中Element是这个数组中唯一允许存在的数据类型。我们也可以使用像[Element]这样的简单语法。尽管两种形式在功能上是一样的，但是推荐较短的那种
     */
    var array1 : [String] = []      //官方推荐第一种
    var array11 : Array<String> = []
    
    var array2 = [String]()
    var array22 = Array<String>()
    
    var array3 : [String]?
    var array33 : Array<String>?
    
    //声明字典的三种方法：
    var dict1:[String:String] = [:]//其中键、值都是String型
    var dict11:Dictionary<Int,String> = [:]//其中键是Int型  值是String型
    
    var dict2 = [String:String]()
    var dict22 = Dictionary<String,String>()
    
    var dict3 : [String:Any]?
    var dict33 : Dictionary<String, Any>?    //声明一个可选的字典类型

    //声明集合的方法：
    /*
     Swift 中的Set类型被写为Set<Element>，这里的Element表示Set中允许存储的类型，和数组不同的是，集合没有等价的简化形式。
     */
    var set1 : Set<String> = []
    var set2 = Set<String>()
    var set3 : Set<String>?
}
