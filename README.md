Brokenthorn
===
OS Development studies using BrokenThorn

Requires the following:
* GNU Mtools to build the ISO image: [Download Mtools debian(amd64.deb) package](https://www.gnu.org/software/mtools/)
```
sudo dpkg -i mtools_4.0.18_amd64.deb
```
* Qemu to test
```
sudo apt install qemu
```
* XMing to test with Qemu: [Download XMing for Windows](https://sourceforge.net/projects/xming/files/Xming/6.9.0.31/)

Use the following to make and run:
```
make clean
make
export DISPLAY=:0
make test
```

For more informaton:
* [Operating System Development - Introduction](http://brokenthorn.com/Resources/OSDev1.html)
* [OS Dev](http://wiki.osdev.org/Main_Page)
* [GNU Mtools](https://www.gnu.org/software/mtools/manual/mtools.html)
