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
  {* ����� ������� EtalonNeeds64
*������:*
[code]
 EtalonNeeds64
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEtalonNeeds64
 
 TkwEtalonNeedsComputerName = class(TtfwGlobalKeyWord)
  {* ����� ������� EtalonNeedsComputerName
*������:*
[code]
 EtalonNeedsComputerName
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEtalonNeedsComputerName
 
 TkwEtalonNeedsOSName = class(TtfwGlobalKeyWord)
  {* ����� ������� EtalonNeedsOSName
*������:*
[code]
 EtalonNeedsOSName
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEtalonNeedsOSName
 
 TkwEtalonNeedsXE = class(TtfwGlobalKeyWord)
  {* ����� ������� EtalonNeedsXE
*������:*
[code]
 EtalonNeedsXE
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEtalonNeedsXE
 
end.
