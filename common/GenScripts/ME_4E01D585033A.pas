unit vcmUserInteractiveForm;

interface

uses
 l3IntfUses
 , l3Forms
 , l3ProtoObject
 , l3CloseFormHelper
 , Controls
;

type
 TvcmCloseFormHelper = class(Tl3ProtoObject, Il3CloseFormHelper)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function Close(aControl: TWinControl): Boolean;
 end;//TvcmCloseFormHelper
 
 TvcmUserInteractiveForm = class(Tl3Form)
 end;//TvcmUserInteractiveForm
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , vcmDialogs
 , vcmMessagesSupport
 , l3MessageID
 , vcmForm
;

end.
