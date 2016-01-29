unit EtalonsWorkingPack;

interface

uses
 l3IntfUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , kwCheckOutputWithInput
 , kwCheckEtalon
 , kwTestResolveInputFilePath
 , l3EtalonsService
 , tfwScriptingTypes
 , SysUtils
;

type
 TkwEtalonNeeds64 = class(TtfwGlobalKeyWord)
  {* Слово скрипта EtalonNeeds64
*Пример:*
[code]
 EtalonNeeds64
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEtalonNeeds64
 
 TkwEtalonNeedsComputerName = class(TtfwGlobalKeyWord)
  {* Слово скрипта EtalonNeedsComputerName
*Пример:*
[code]
 EtalonNeedsComputerName
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEtalonNeedsComputerName
 
 TkwEtalonNeedsOSName = class(TtfwGlobalKeyWord)
  {* Слово скрипта EtalonNeedsOSName
*Пример:*
[code]
 EtalonNeedsOSName
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEtalonNeedsOSName
 
 TkwEtalonNeedsXE = class(TtfwGlobalKeyWord)
  {* Слово скрипта EtalonNeedsXE
*Пример:*
[code]
 EtalonNeedsXE
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEtalonNeedsXE
 
end.
