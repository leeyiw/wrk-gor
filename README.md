# wrk-gor

A [wrk](https://github.com/wg/wrk)'s Lua extension, which let wrk uses [goreplay](https://github.com/buger/goreplay)'s data file (.gor)

## Usage

1. Download [wrk-gor.lua](https://github.com/leeyiw/wrk-gor/raw/master/wrk-gor.lua) to where you run the wrk.
2. Prepare goreplay's data file, checkout this document: [Saving and Replaying from file](https://github.com/buger/goreplay/wiki/Saving-and-Replaying-from-file). For example, we have `requests.gor` in current directory.
2. Run wrk with the following arguments: `wrk -s wrk-gor.lua http://127.0.0.1:8080/ -- --gor requests.gor`. Then wrk will perform 10 seconds' benchmark to `127.0.0.1:8080`, the HTTP requests will be generated using `requests.gor` by `wrk-gor.lua`.
