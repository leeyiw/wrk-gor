# wrk-gor

`wrk-gor` 是一个 [wrk](https://github.com/wg/wrk) 的 Lua 扩展。该扩展可以让 wrk 读取 [goreplay](https://github.com/buger/goreplay) 记录的线上真实流量文件（.gor）并进行性能压测。

## 使用方法

1. 下载 [wrk-gor.lua](https://github.com/leeyiw/wrk-gor/raw/master/wrk-gor.lua) 到您希望调用 wrk 的目录下
2. 准备一份 goreplay 产出的数据文件（.gor），该步骤可以参考：[Saving and Replaying from file](https://github.com/buger/goreplay/wiki/Saving-and-Replaying-from-file)。这里我们使用 `requests.gor` 进行举例
2. 使用如下参数调用 wrk： `wrk -s wrk-gor.lua http://127.0.0.1:8080/ -- --gor requests.gor`，然后 wrk 就会对 `127.0.0.1:8080` 进行为期 10 秒的性能测试，测试数据从 `requests.gor` 中被 `wrk-gor.lua` 读取并加载到 wrk 中
