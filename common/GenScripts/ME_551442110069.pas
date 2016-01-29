unit l3FormatActionInfoHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ActnList
;

 (*
 Ml3FormatActionInfoHelper = interface
  {* Контракт сервиса Tl3FormatActionInfoHelper }
  function Format(anAction: TCustomAction): AnsiString;
 end;//Ml3FormatActionInfoHelper
 *)
 
type
 Il3FormatActionInfoHelper = interface
  {* Интерфейс сервиса Tl3FormatActionInfoHelper }
  function Format(anAction: TCustomAction): AnsiString;
 end;//Il3FormatActionInfoHelper
 
 Tl3FormatActionInfoHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function Format(anAction: TCustomAction): AnsiString;
 end;//Tl3FormatActionInfoHelper
 
implementation

uses
 l3ImplUses
;

end.
