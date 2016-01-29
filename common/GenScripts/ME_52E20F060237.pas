unit kwImageEnControl;

interface

uses
 l3IntfUses
 , imageenview
 , tfwScriptingInterfaces
 , Controls
;

type
 TkwImageEnControl = class(_kwControlFromStackWord_)
  procedure DoWithImageEn(aControl: TImageEnView;
   const aCtx: TtfwContext);
  procedure DoControl(aControl: TControl;
   const aCtx: TtfwContext);
 end;//TkwImageEnControl
 
implementation

uses
 l3ImplUses
;

end.
