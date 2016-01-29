unit kwFormFromControlWord;

interface

uses
 l3IntfUses
 , kwControlWord
 , Forms
 , tfwScriptingInterfaces
 , Controls
;

type
 TkwFormFromControlWord = class(TkwControlWord)
  procedure DoForm(aForm: TForm;
   const aCtx: TtfwContext);
  procedure DoControl(aControl: TControl;
   const aCtx: TtfwContext);
 end;//TkwFormFromControlWord
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3FormsService
;

end.
