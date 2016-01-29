unit kwControlWord;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , Controls
 , tfwScriptingInterfaces
 , Classes
;

type
 TkwControlWord = class(TtfwRegisterableWord)
  procedure DoControl(aControl: TControl;
   const aCtx: TtfwContext);
  procedure DoComponent(aControl: TComponent;
   const aCtx: TtfwContext);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwControlWord
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3CloseFormHelper
 , l3MessagesService
 , l3FormsService
 , Windows
 , Forms
;

end.
