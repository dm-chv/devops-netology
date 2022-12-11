## 2.4.1  
-----
### Ответ:  

aefead2207ef7e2aa5dc81a34aedf0cad4c32545 Update CHANGELOG.md  


###Описание:  

> sudo git log --oneline | grep aefea  
#### мне так привычнее)  

2.4.2
----- 
### Ответ:   
v0.12.23

### Описание:       
> sudo git show 85024d3  
> commit 85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23)  
> Author: tf-release-bot <terraform@hashicorp.com>  
> Date:   Thu Mar 5 20:56:10 2020 +0000  
>
>    v0.12.23
>
####- в show эта информация присуттвует...

## 2.4.3
----- 
### Ответ:
два родителя -  56cd7859e0 и 9ea88f22fc  

### Описание:
> sudo git show b8d720
> commit b8d720f8340221f2146e4e4870bf2ee0bc48f2d5
> Merge: 56cd7859e0 9ea88f22fc
> команда show показывает, что этот коммит смёржили из двух родительских

## 2.4.4
### Ответ:
33ff1c03bb (tag: v0.12.24) v0.12.24
b14b74c493 [Website] vmc provider links
3f235065b9 Update CHANGELOG.md
6ae64e247b registry: Fix panic when server is unreachable
5c619ca1ba website: Remove links to the getting started guide's old location
06275647e2 Update CHANGELOG.md
d5f9411f51 command: Fix bug when using terraform login on Windows
4b6d06cc5d Update CHANGELOG.md
dd01a35078 Update CHANGELOG.md
225466bc3e Cleanup after v0.12.23 release

### Описание:
> sudo git log v0.12.23..v0.12.24 --oneline

### 2.4.5 
## Ответ:
8c928e83589d90a031f811fae52a81be7153e82f

### Описание:
> sudo git log -S 'func providerSource' --oneline
> Данная команда показывает константу, когда она существовала, так же изначяально 
> я решил другим способом:
> sudo git grep -o -n -p 'func providerSource' - тут мы получаем в каком файле была определена функция
> sudo git log -L :'func providerSource':provider_source.go - этой командой мы осуществляем поиск всех изменений 
> фукции в файле, здесь мы получаем несколько коммитов, первый из них - тот что нам нужно(определение переменной)


## 2.4.6
### Ответ:
125eb51dc4 Remove accidentally-committed binary
22c121df86 Bump compatibility version to 1.3.0 for terraform core release (#30988)
35a058fb3d main: configure credentials from the CLI config file
c0b1761096 prevent log output during init
8364383c35 Push plugin discovery down into command package  
### Описание:
> sudo git log -S globalPluginDirs --oneline
> данная команда выводит когда существовала константа, соответственно, года делалились изменения.


##2.4.7 
### Ответ: 
Martin Atkins

### Описание:
> sudo git log -S 'synchronizedWriters' --oneline
> bdfea50cc8 remove unused
> fd4f7eb0b9 remove prefixed io
> 5ac311e2a9 main: synchronize writes to VT100-faker on Windows
> sudo git show 5ac311e2a9
> commit 5ac311e2a91e381e2f52234668b49ba670aa0fe5
> Author: Martin Atkins <mart@degeneration.co.uk>
> + проверил поиском в файле, где определянтся функция - нет ли там указания на другого автора.

