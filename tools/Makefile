all: Asm09 LinkBE Lib8 Cate09

# pour la compilation des outils voir https://learn.microsoft.com/fr-fr/dotnet/core/install/linux
# faire :
# $ wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
# $ chmod u+x ./dotnet-install.sh
# $ ./dotnet-install.sh --channel 8.0

Asm09:
	-dotnet publish asm8-2.0.0/Asm09 --runtime linux-x64 --self-contained true --configuration Release -p:DebugType=None -p:DebugSymbols=false -p:PublishSingleFile=true -p:PublishTrimmed=true

LinkBE:
	-dotnet publish asm8-2.0.0/LinkBE --runtime linux-x64 --self-contained true --configuration Release -p:DebugType=None -p:DebugSymbols=false -p:PublishSingleFile=true -p:PublishTrimmed=true

Lib8:
	-dotnet publish asm8-2.0.0/Lib8 --runtime linux-x64 --self-contained true --configuration Release -p:DebugType=None -p:DebugSymbols=false -p:PublishSingleFile=true -p:PublishTrimmed=true

Cate09:
	-dotnet publish Cate-2.4.2/Cate09 --runtime linux-x64 --self-contained true --configuration Release -p:DebugType=None -p:DebugSymbols=false -p:PublishSingleFile=true -p:PublishTrimmed=true

# le .lib généré avec les nouveaux outils est incomplet, il ne contient pas tout le code compilé
cate09.lib:
	$(MAKE) -C Cate-2.4.2/runtime/6809

clean:
	-rm -f Asm09 LinkBE Lib8 Cate09

