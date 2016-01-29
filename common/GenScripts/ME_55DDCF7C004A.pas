unit l3VersionInfoService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3VersionInfoService = interface
  {* Контракт сервиса Tl3VersionInfoService }
  function VersionInfo: AnsiString;
 end;//Ml3VersionInfoService
 *)
 
type
 Il3VersionInfoService = interface
  {* Интерфейс сервиса Tl3VersionInfoService }
  function VersionInfo: AnsiString;
 end;//Il3VersionInfoService
 
 Tl3VersionInfoService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function VersionInfo: AnsiString;
 end;//Tl3VersionInfoService
 
implementation

uses
 l3ImplUses
 , vtVerInf
 , SysUtils
;

end.
