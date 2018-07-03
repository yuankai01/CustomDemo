//
//  ViewController.m
//  EncryptionAlgorithm
//
//  Created by gao on 2018/7/3.
//  Copyright © 2018年 gao. All rights reserved.
//

/* iOS常见加密算法原理
 https://blog.csdn.net/qq_35247219/article/details/52072844
 五.对称加密算法
 
 优点：算法公开、计算量小、加密速度快、加密效率高、可逆
 缺点：双方使用相同钥匙，安全性得不到保证
 现状：对称加密的速度比公钥加密快很多，在很多场合都需要对称加密，相较于DES和3DES算法而言，AES算法有着更高的速度和资源使用效率，安全级别也较之更高了，被称为下一代加密标准
 nECB ：电子代码本，就是说每个块都是独立加密的nCBC ：密码块链，使用一个密钥和一个初始化向量 (IV)对数据执行加密转换
 ECB和CBC区别：CBC更加复杂更加安全，里面加入了8位的向量（8个0的话结果等于ECB）。在明文里面改一个字母，ECB密文对应的那一行会改变，CBC密文从那一行往后都会改变。
 ECB终端命令：
 $ openssl enc -des-ecb -K 616263 -nosalt -in msg1.txt -out msg1.binCBC终端命令：$ openssl enc -des-cbc -K 616263 -iv 0000000000000000 -nosalt -in msg1.txt -out msg2.bin

 六.RSA加密
 
 RSA非对称加密算法
 非对称加密算法需要两个密钥：公开密钥（publickey）和私有密钥（privatekey）公开密钥与私有密钥是一对，如果用公开密钥对数据进行加密，只有用对应的私有密钥才能解密；如果用私有密钥对数据进行加密，那么只有用对应的公开密钥才能解密
 特点：非对称密码体制的特点：算法强度复杂、安全性依赖于算法与密钥，但是由于其算法复杂，而使得加密解密速度没有对称加密解密的速度快，对称密码体制中只有一种密钥，并且是非公开的，如果要解密就得让对方知道密钥。所以保证其安全性就是保证密钥的安全，而非对称密钥体制有两种密钥，其中一个是公开的，这样就可以不需要像对称密码那样传输对方的密钥了
 基本加密原理：
 (1)找出两个“很大”的质数：P & Q
 (2)N = P * Q
 (3)M = (P – 1) * (Q – 1)
 (4)找出整数E，E与M互质，即除了1之外，没有其他公约数
 (5)找出整数D，使得E*D除以M余1，即 (E * D) % M = 1
 
 经过上述准备工作之后，可以得到：E是公钥，负责加密D是私钥，负责解密N负责公钥和私钥之间的联系加密算法，假定对X进行加密(X ^ E) % N = Yn根据费尔马小定义，根据以下公式可以完成解密操作(Y ^ D) % N = X
 但是RSA加密算法效率较差，对大型数据加密时间很长，一般用于小数据。常用场景：分部要给总部发一段报文，先对报文整个进行MD5得到一个报文摘要，再对这个报文摘要用公钥加密。然后把报文和这个RSA密文一起发过去。总部接收到报文之后要先确定报文是否在中途被人篡改，就先把这个密文用私钥解密得到报文摘要，再和整个报文MD5一下得到的报文摘要进行对比 如果一样就是没被改过。
 */

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor =  [UIColor cyanColor];
    
    dataArray = @[@"MD5",@"Base64",@"3DES",@"AES",@"RSA",@"SHA"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.estimatedRowHeight = 100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
}


@end
