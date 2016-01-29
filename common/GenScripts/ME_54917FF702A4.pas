unit ncsServerTransporterPtrPool;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsServerTransporterPtrList
 , ncsMessageInterfaces
;

type
 TncsServerTransporterPtrPool = class(Tl3ProtoObject)
  procedure Register(const aTransporter: IncsServerTransporter);
  procedure UnRegister(const aTransporter: IncsServerTransporter);
  function FindTransporter(const aSessionID: AnsiString): IncsServerTransporter;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TncsServerTransporterPtrPool
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
