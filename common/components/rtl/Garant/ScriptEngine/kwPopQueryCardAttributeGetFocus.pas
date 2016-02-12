unit kwPopQueryCardAttributeGetFocus;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetFocus.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , tfwScriptingInterfaces
 , evQueryCardEditor
;

type
 TkwPopQueryCardAttributeGetFocus = {final} class(TkwQueryCardFromStackWord)
  protected
   procedure DoCard(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopQueryCardAttributeGetFocus
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , evQueryCardInt
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopQueryCardAttributeGetFocus.DoCard(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
//#UC START# *4E808E8B01BB_4FEF234F01FB_var*
var
 l_Control: IevCustomEditorControl;
 l_C: IevEditorControl;
//#UC END# *4E808E8B01BB_4FEF234F01FB_var*
begin
//#UC START# *4E808E8B01BB_4FEF234F01FB_impl*
 l_Control := aCard.GetControl;
 if Supports(l_Control, IevEditorControl, l_C) then
  aCtx.rEngine.PushString(l_C.Req.ReqName)
 else
  RunnerError('Текущее поле не найдено', aCtx);
//#UC END# *4E808E8B01BB_4FEF234F01FB_impl*
end;//TkwPopQueryCardAttributeGetFocus.DoCard

class function TkwPopQueryCardAttributeGetFocus.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:QueryCard:Attribute:GetFocus';
end;//TkwPopQueryCardAttributeGetFocus.GetWordNameForRegister

initialization
 TkwPopQueryCardAttributeGetFocus.RegisterInEngine;
 {* Регистрация pop_QueryCard_Attribute_GetFocus }
{$IfEnd} // NOT Defined(NoScripts)

end.
