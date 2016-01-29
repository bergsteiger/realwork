unit ncsMessageFactory;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessageClassList
 , ncsMessage
 , Classes
 , l3Variant
;

type
 TncsMessageFactory = class(Tl3ProtoObject)
  procedure Register(aClass: TncsMessageClass);
  procedure UnRegister(aClass: TncsMessageClass);
  function Find(const aMessageTag: AnsiString): TncsMessageClass;
  function MakeFromEVD(aStream: TStream): TncsMessage;
  function MakeFromTaggedData(aData: Tl3Tag): TncsMessage;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TncsMessageFactory
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
;

end.
