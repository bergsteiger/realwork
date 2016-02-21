unit kwPopQueryCardGetCurrentReqName;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardGetCurrentReqName.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , tfwScriptingInterfaces
 , evQueryCardEditor
;

type
 TkwPopQueryCardGetCurrentReqName = {final} class(TkwQueryCardFromStackWord)
  protected
   procedure DoCard(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopQueryCardGetCurrentReqName
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evQueryCardInt
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopQueryCardGetCurrentReqName.DoCard(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
//#UC START# *4E808E8B01BB_4FDB10E9009A_var*
var
 l_Control: IevEditorControl;
//#UC END# *4E808E8B01BB_4FDB10E9009A_var*
begin
//#UC START# *4E808E8B01BB_4FDB10E9009A_impl*
 if aCard.Selection.Cursor.MostInner.Obj^.AsObject.QT(IevEditorControl, l_Control) then
  aCtx.rEngine.PushString(l_Control.Req.ReqName)
 else
  Assert(False, 'Ошибка при получении интерфейса поля редактора!');
//#UC END# *4E808E8B01BB_4FDB10E9009A_impl*
end;//TkwPopQueryCardGetCurrentReqName.DoCard

class function TkwPopQueryCardGetCurrentReqName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:QueryCard:GetCurrentReqName';
end;//TkwPopQueryCardGetCurrentReqName.GetWordNameForRegister

initialization
 TkwPopQueryCardGetCurrentReqName.RegisterInEngine;
 {* Регистрация pop_QueryCard_GetCurrentReqName }
{$IfEnd} // NOT Defined(NoScripts)

end.
