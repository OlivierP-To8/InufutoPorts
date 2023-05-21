all: Asm09 LinkBE Lib8 Cate09 cate09.lib

# pour la compilation des outils voir https://learn.microsoft.com/fr-fr/dotnet/core/install/linux
# faire :
# $ wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
# $ chmod u+x ./dotnet-install.sh
# $ ./dotnet-install.sh --channel 3.1

Asm09:
	-~/.dotnet/dotnet publish asm8-1.5.0/Asm09 --runtime linux-x64 --self-contained true --output . --configuration Release -p:DebugType=None -p:DebugSymbols=false -p:PublishSingleFile=true -p:PublishTrimmed=true

LinkBE:
	-~/.dotnet/dotnet publish asm8-1.5.0/LinkBE --runtime linux-x64 --self-contained true --output . --configuration Release -p:DebugType=None -p:DebugSymbols=false -p:PublishSingleFile=true -p:PublishTrimmed=true

Lib8:
	-~/.dotnet/dotnet publish asm8-1.5.0/Lib8 --runtime linux-x64 --self-contained true --output . --configuration Release -p:DebugType=None -p:DebugSymbols=false -p:PublishSingleFile=true -p:PublishTrimmed=true

Cate09:
	-~/.dotnet/dotnet publish Cate-1.5.0/Cate09 --runtime linux-x64 --self-contained true --output . --configuration Release -p:DebugType=None -p:DebugSymbols=false -p:PublishSingleFile=true -p:PublishTrimmed=true

cate09.lib:
	$(MAKE) -C Cate-1.5.0/runtime/6809

clean:
	-rm -f Asm09 LinkBE Lib8 Cate09 cate09.lib

