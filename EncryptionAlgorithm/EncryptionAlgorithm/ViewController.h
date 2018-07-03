//
//  ViewController.h
//  EncryptionAlgorithm
//
//  Created by gao on 2018/7/3.
//  Copyright © 2018年 gao. All rights reserved.
//

/* iOS常用加密算法和比较
 https://blog.csdn.net/luthan/article/details/44301813
 
 3、常用的加密算法，一般银行、财经类的公司会问到这个问题，涉及到网络安全的。
 常见的iOS代码加密常用加密方式算法包括MD5加密、AES加密、BASE64加密三种。
 
 电科智药项目采用的是： 3DES + RSA混合加密方式，
 客户端：
 1、采用3DES加密生成一个随机的 key3DES值字符串，再用RSA和这个key值和规定的 RSA_KEY值又生成一个加密字符串RSAKeyStr。
 2、再用3DES根据上面生产的 key3DES加密客户端传输的数据，产生一个新的字符串 3DESDataString。
 3、最后直接将3DESDataString字符串和RSAKeyStr拼接再组合成新的数据jsonString传给服务器。
 服务端返回的数据：直接采用3DES解密服务器返回的数据。
 
 有时候会用到多重混合加密，即对加密后的数据再进行加密。
 详见：《网络安全》笔记本
 iOS常用加密算法和比较
 https://blog.csdn.net/luthan/article/details/44301813
 
 对称加密算法 （DES刚好是以对称的首字母开头的）
 对称加密算法用来对敏感数据等信息进行加密，常用的算法包括：
 英文：Data：数据；Encryption：[ɛn’krɪpʃən] 加密；Advanced：[əd’vænst] 先进的；Triple：[‘trɪpl]  三倍
 DES（Data Encryption Standard）：数据加密标准，速度较快，适用于加密大量数据的场合。
 3DES（Triple DES）：是基于DES，对一块数据用三个不同的密钥进行三次加密，强度更高。
 AES（Advanced Encryption Standard）：高级加密标准，是下一代的加密算法标准，速度快，安全级别高；
 
 非对称加密算法
 英文：Digital：数字；Signature：['sɪgnətʃə] 签名；Algorithm：[‘ælgə'rɪðəm] 算法；
 Elliptic：[ɪ’lɪptɪk] 椭圆；Curves：[kɝv] 曲线；Cryptography：[krɪp’tɒgrəfɪ] 密码学；
 RSA：由 RSA 公司发明，是一个支持变长密钥的公共密钥算法，需要加密的文件块的长度也是可变的；
 DSA（Digital Signature Algorithm）：数字签名算法，是一种标准的 DSS（数字签名标准）；
 ECC（Elliptic Curves Cryptography）：椭圆曲线密码编码学。
 ECC和RSA相比，在许多方面都有对绝对的优势，主要体现在以下方面：
 抗攻击性强。相同的密钥长度，其抗攻击性要强很多倍。
 计算量小，处理速度快。ECC总的速度比RSA、DSA要快得多。
 存储空间占用小。ECC的密钥尺寸和系统参数与RSA、DSA相比要小得多，意味着它所占的存贮空间要小得多。这对于加密算法在IC卡上的应用具有特别重要的意义。
 带宽要求低。当对长消息进行加解密时，三类密码系统有相同的带宽要求，但应用于短消息时ECC带宽要求却低得多。带宽要求低使ECC在无线网络领域具有广泛的应用前景。
 加密算法的选择
 由于非对称加密算法的运行速度比对称加密算法的速度慢很多，当我们需要加密大量的数据时，建议采用对称加密算法，提高加解密速度。
 对称加密算法不能实现签名，因此签名只能非对称算法。
 由于对称加密算法的密钥管理是一个复杂的过程，密钥的管理直接决定着他的安全性，因此当数据量很小时，我们可以考虑采用非对称加密算法。
 在实际的操作过程中，我们通常采用的方式是：采用非对称加密算法管理对称算法的密钥，然后用对称加密算法加密数据，这样我们就集成了两类加密算法的优点，既实现了加密速度快的优点，又实现了安全方便管理密钥的优点。那采用多少位的密钥呢？ RSA建议采用1024位的数字，ECC建议采用160位，AES采用128为即可。
 总结
 1.通过简单的URLENCODE ＋ BASE64编码防止数据明文传输
 2 对普通请求、返回数据，生成MD5校验（MD5中加入动态密钥），进行数据完整性（简单防篡改，安全性较低，优点：快速）校验。
 3 对于重要数据，使用RSA进行数字签名，起到防篡改作用。
 4 对于比较敏感的数据，如用户信息（登陆、注册等），客户端发送使用RSA加密，服务器返回使用DES(AES)加密。
 原因：客户端发送之所以使用RSA加密，是因为RSA解密需要知道服务器私钥，而服务器私钥一般盗取难度较大；如果使用DES的话，可以通过破解客户端获取密钥，安全性较低。而服务器返回之所以使用DES，是因为不管使用DES还是RSA，密钥（或私钥）都存储在客户端，都存在被破解的风险，因此，需要采用动态密钥（服务器动态返回？），而RSA的密钥生成比较复杂，不太适合动态密钥，并且RSA速度相对较慢，所以选用DES）
 */

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

