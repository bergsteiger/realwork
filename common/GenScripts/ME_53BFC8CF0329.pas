unit vcmComponentDestroyer.imp;

interface

uses
 l3IntfUses
 , Messages
;

type
 _vcmComponentDestroyer_ = class(MvcmEntityForm)
  procedure vcmMsgClearPopup(var aMessage: TMessage);
  procedure vcmMsgCloseChildForm(var aMessage: TMessage);
  procedure vcmMsgFreeComponent(var aMessage: TMessage);
 end;//_vcmComponentDestroyer_
 
implementation

uses
 l3ImplUses
 , vcmMenuManager
 , vcmFormsUtils
 , Menus
 , SysUtils
 , vcmEntityForm
 , vcmForm
 , vcmMessages
;

end.
