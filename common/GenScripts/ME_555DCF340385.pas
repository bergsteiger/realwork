unit evdCustomNativeWriterServices;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , k2EVDWriterService
 , k2CustomFileGenerator
 , l3Variant
;

type
 TevdEVDWriterService = class(Tl3ProtoObject, Ik2EVDWriterService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetWriter: Tk2CustomFileGenerator;
  function MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
 end;//TevdEVDWriterService
 
implementation

uses
 l3ImplUses
 , evdCustomNativeWriter
 , SysUtils
;

end.
