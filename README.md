![CBBlcokKit](http://ww4.sinaimg.cn/large/65e4f1e6gw1f74n6ilkz8j21av093ac2.jpg)

![](http://ww3.sinaimg.cn/large/7853084cgw1f75cbek3wdj20xc02dt8p.jpg)

# ヾ(＠⌒ー⌒＠)ノ - *A block can do a lot!* - (=￣ ρ￣=) ..zzZZ

>  ------------------------------------------------   [详细讲解](https://github.com/cbangchen/CBBlockKit/wiki) ----------------------------------------------------

## Principle

```
ONE BIG BLOCK BUILD THE INTERFACE.
```

## Function

- [x] Wonderful block style.

- [x] Universal macro definition.

- [x] Encapsulation of AFNetworking.

- [x] Encapsulation of FMDB.

- [x] Cooperate with Masonry,code views Faster.

- [x] Live reload, WHAT YOU SEE IS WHAT YOU GET.

## Directory

- Store      : Data storage .

- Macros     : Common macro definition.

- Network    : Network framework.

- Protocol   : Delegate and DataSourse.

- Category   : Commonly turn UI controls into block.

- Controller : Auxiliary controller.

## Block Features
- Use blocks to replace common delegates and dataSourses.

- Local delegates and dataSourses still get higher priority.

- Send specified signal to run the specified block.

## Example
![Example](http://ww1.sinaimg.cn/large/65e4f1e6gw1f74tf36espj20wq0dzjvg.jpg)

## Example Code

![Example](http://ww1.sinaimg.cn/large/65e4f1e6gw1f74u45med8j20zk2534qf.jpg)

## Live Reload
> Enable LiveReload during your development phase! 

- Download [InjectionForXcode](http://injectionforxcode.johnholdsworth.com/InjectionPluginV6.4.pkg)

- Install it, Restart Xcode and make sure to click `Load bundles`.

- Launch it and Go to `File > Install Plugins` *(cmd+i)*

Need tell our ViewController to rebuild a view after an injection occured.

Add method:

```
- (void)injected;
```

![](http://ww2.sinaimg.cn/large/7853084cgw1f75c8bajyeg20s40ehnpg.gif)

## License

Released under the MIT license. See LICENSE for details.
