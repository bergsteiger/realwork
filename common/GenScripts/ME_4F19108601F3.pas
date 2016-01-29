unit m3StorageIndexAdapter;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , SysUtils
 , l3Types
;

type
 Tm3StorageIndexAdapter = class(Tl3ProtoObject)
  procedure DoBuildIndex(aFilesMeter: Tl3ProgressProc);
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//Tm3StorageIndexAdapter
 
implementation

uses
 l3ImplUses
 , m4DBInterfaces
 , m4DB
 , l3FileUtils
 , m3StorageInterfaces
;

end.
