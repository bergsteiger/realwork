unit kwEndAddSubByMouse;
 {* «акончить простановку ссылки на саб с помощью мыши (Drag&Drop):
окно_редактора:постановить_ссылку_мышью }

// ћодуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEndAddSubByMouse.pas"
// —тереотип: "ScriptKeyword"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , kwControlWord
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
;

type
 TkwEndAddSubByMouse = class(TkwControlWord)
  {* «акончить простановку ссылки на саб с помощью мыши (Drag&Drop):
окно_редактора:постановить_ссылку_мышью }
  protected
   {$If NOT Defined(NoVCL)}
   procedure DoControl(aControl: TControl;
    const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoVCL)
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEndAddSubByMouse
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Messages
 , DragData
 , arArchiTestAdapter2
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

{$If NOT Defined(NoVCL)}
procedure TkwEndAddSubByMouse.DoControl(aControl: TControl;
 const aCtx: TtfwContext);
//#UC START# *4DB98B990054_4F0C009200D7_var*
//#UC END# *4DB98B990054_4F0C009200D7_var*
begin
//#UC START# *4DB98B990054_4F0C009200D7_impl*
 AcEndDragAndDrop(aControl);
//#UC END# *4DB98B990054_4F0C009200D7_impl*
end;//TkwEndAddSubByMouse.DoControl
{$IfEnd} // NOT Defined(NoVCL)

class function TkwEndAddSubByMouse.GetWordNameForRegister: AnsiString;
begin
 Result := 'окно_редактора:постановить_ссылку_мышью';
end;//TkwEndAddSubByMouse.GetWordNameForRegister

initialization
 TkwEndAddSubByMouse.RegisterInEngine;
 {* –егистраци€ TkwEndAddSubByMouse }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
