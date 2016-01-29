unit k2EVDWriterService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , k2CustomFileGenerator
 , l3Variant
;

 (*
 Mk2EVDWriterService = interface
  {* Контракт сервиса Tk2EVDWriterService }
  function GetWriter: Tk2CustomFileGenerator;
  function MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
 end;//Mk2EVDWriterService
 *)
 
type
 Ik2EVDWriterService = interface
  {* Интерфейс сервиса Tk2EVDWriterService }
  function GetWriter: Tk2CustomFileGenerator;
  function MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
 end;//Ik2EVDWriterService
 
 Tk2EVDWriterService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetWriter: Tk2CustomFileGenerator;
  function MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
 end;//Tk2EVDWriterService
 
implementation

uses
 l3ImplUses
;

end.
