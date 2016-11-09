# LZXThread

用于新开一个常驻线程，在特定Mode下执行某一系列操作。

- 可以将耗时操作放到该线程中来处理

- 可以自定义线程中执行代码的 `NSRunloopMode`

- 可以在添加子线程执行`selector`的时候指定是否取消线程中前一次该`selector`的执行
