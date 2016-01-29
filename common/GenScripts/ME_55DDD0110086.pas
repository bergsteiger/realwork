unit f1VersionInfoService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3VersionInfoService
;

type
 Tf1VersionInfoService = class(Tl3ProtoObject, Il3VersionInfoService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function VersionInfo: AnsiString;
 end;//Tf1VersionInfoService
 
implementation

uses
 l3ImplUses
;

end.
