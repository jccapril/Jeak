# Jeak
基于  [grpc-swift](https://github.com/grpc/grpc-swift) 项目

## 环境

###protoc 插件安装
生成 `protoc-gen-swift` 和 `protoc-gen-grpc-swift`  并放入$PATH 环境中，
下面提供了两种方法
#### Git
``` Shell
$: git clone https://github.com/grpc/grpc-swift.git
$: cd grpc-swift
$: make generate-helloworld
$: cd .build/release
$: sudo cp protoc-gen-swift protoc-gen-swiftgrpc /usr/local/bin
```
#### Cocoapods
另外再开一个空白项目
```Shell
pod 'gRPC-Swift-Plugins'
```
到项目目录下之后在终端进行下面操作
``` Shell
$: cd Pods/gRPC-Swift-Plugins/bin
$: sudo cp protoc-gen-swift protoc-gen-swiftgrpc /usr/local/bin
```


### 生成 login.grpc.swift  & login.pb.swift   
```Shell
$:make generate-login
```
### 清除 login.grpc.swift &  login.pb.swift   
```Shell
$:make clean-login
```


## 附

## 解决Swift Package Dependencies 速度慢
科学上网
给git设置代理
```Shell
$: git config --global https.proxy http://127.0.0.1:1080
$: git config --global http.proxy http://127.0.0.1:1080

```
取消git代理
```Shell
$: git config --global --unset http.proxy
$: git config --global --unset https.proxy
```
如果还是不行 可以参考这个[文章](https://juejin.cn/post/6844904193170341896)


## 生成.grpc.swift 和 .pb.swift 文件

 可以在终端使用下面的代码，也可以参考 `Makefile`
```Shell
$: protoc {proto在所在路径} \
    --proto_path={proto在所在的文件夹路径}\
    --plugin=protoc-gen-swift \
    --swift_opt=Visibility=Public \
    --swift_out={输出路径} \
    --plugin=protoc-gen-grpc-swift \
    --grpc-swift_opt=Visibility=Public \
    --grpc-swift_out={输出路径}
```
