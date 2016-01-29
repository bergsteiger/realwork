unit k2EVDReaderService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , k2CustomFileReader
 , l3Interfaces
 , l3Variant
;

 (*
 Mk2EVDReaderService = interface
  {* Контракт сервиса Tk2EVDReaderService }
  function GetReader: Tk2CustomFileReader;
  function MakeReader(const aFileName: AnsiString;
   const aFilter: Ik2TagGenerator): Il3Reader;
 end;//Mk2EVDReaderService
 *)
 
type
 Ik2EVDReaderService = interface
  {* Интерфейс сервиса Tk2EVDReaderService }
  function GetReader: Tk2CustomFileReader;
  function MakeReader(const aFileName: AnsiString;
   const aFilter: Ik2TagGenerator): Il3Reader;
 end;//Ik2EVDReaderService
 
 Tk2EVDReaderService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function MakeReader(const aFileName: AnsiString;
   const aFilter: Ik2TagGenerator): Il3Reader;
  function GetReader: Tk2CustomFileReader;
 end;//Tk2EVDReaderService
 
implementation

uses
 l3ImplUses
;

end.
