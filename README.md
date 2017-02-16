# ReusableHViewDemo
一个横向的tableview
![image](https://github.com/gitxiyue/ReusableHViewDemo/blob/master/11.png)
![image](https://github.com/gitxiyue/ReusableHViewDemo/blob/master/22.png)
![image](https://github.com/gitxiyue/ReusableHViewDemo/blob/master/33.png)

###用法
    ReusableHView *rhv = [[ReusableHView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_W, 120) cellSize:CGSizeMake(110, 100) padding:UIEdgeInsetsMake(10, 10, 10, 0) visible:3];
    rhv.reusableDelegate = self;
    [self.view addSubview:rhv];

