## 开发环境配置

开发环境(Ubuntu):

* Ubuntu 20.04 LTS
* GCC: 9.3.0
* CMake: 3.16.3

依赖库及工具

* libcurl4-openssl-dev


请在 Ubuntu 上通过 apt-get 安装以上依赖库。
```bash
sudo apt-get install gcc
sudo apt-get install g++
sudo apt-get install cmake
```


开发环境(CentOS):

* CentOS 7.6.1810
* GCC: 8.3.1
* CMake: 3.17.5

依赖库及工具


请在 CentOS 上通过 yum 安装以上依赖库。
```bash
yum install -y devtoolset-8
yum install -y cmake
yum install devtoolset-8-libasan-devel
```

## 编译

```bash
mkdir build
cd build
cmake ..
make
```