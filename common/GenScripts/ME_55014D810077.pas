unit l3CloseFormHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Controls
;

 (*
 Ml3CloseFormHelper = interface
  {* Контракт сервиса Tl3CloseFormHelper }
  function Close(aControl: TWinControl): Boolean;
 end;//Ml3CloseFormHelper
 *)
 
type
 Il3CloseFormHelper = interface
  {* Интерфейс сервиса Tl3CloseFormHelper }
  function Close(aControl: TWinControl): Boolean;
 end;//Il3CloseFormHelper
 
 Tl3CloseFormHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function Close(aControl: TWinControl): Boolean;
 end;//Tl3CloseFormHelper
 
implementation

uses
 l3ImplUses
 , Forms
;

end.
