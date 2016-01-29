unit evdNativeReaderServices;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , k2EVDReaderService
 , l3Interfaces
 , k2CustomFileReader
 , l3Variant
;

type
 TevdEVDReaderService = class(Tl3ProtoObject, Ik2EVDReaderService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function MakeReader(const aFileName: AnsiString;
   const aFilter: Ik2TagGenerator): Il3Reader;
  function GetReader: Tk2CustomFileReader;
 end;//TevdEVDReaderService
 
implementation

uses
 l3ImplUses
 , evdNativeReader
 , SysUtils
;

end.
