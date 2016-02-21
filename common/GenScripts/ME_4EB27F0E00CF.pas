unit kwPopEditorGetParaByID;
 {* Получает от редактора параграф по его ID.

Пример:
[code]
 12 editor:GetParaByID
 IF
  Para:Text .
 ELSE
 'Параграф не найден' .
 ENDIF
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorGetParaByID.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorGetParaByID = class(TkwEditorFromStackWord)
  {* Получает от редактора параграф по его ID.

Пример:
[code]
 12 editor:GetParaByID
 IF
  Para:Text .
 ELSE
 'Параграф не найден' .
 ENDIF
[code] }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorGetParaByID
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nevTools
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopEditorGetParaByID.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4EB27F0E00CF_var*
var
 l_O : InevObject;
 l_P : InevPara;
//#UC END# *4F4CB81200CA_4EB27F0E00CF_var*
begin
//#UC START# *4F4CB81200CA_4EB27F0E00CF_impl*
 if anEditor.TextSource.DocumentContainer.FindObjByID(aCtx.rEngine.PopInt, l_O) then
 begin
  if not l_O.AsObject.QT(InevPara, l_P) then
   RunnerError('', aCtx);
  aCtx.rEngine.PushIntf(l_P, TypeInfo(InevPara));
  aCtx.rEngine.PushBool(true);
 end//anEditor.TextSource.DocumentContainer.FindObjByID(anID, l_O)
 else
  aCtx.rEngine.PushBool(false);
//#UC END# *4F4CB81200CA_4EB27F0E00CF_impl*
end;//TkwPopEditorGetParaByID.DoWithEditor

class function TkwPopEditorGetParaByID.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:GetParaByID';
end;//TkwPopEditorGetParaByID.GetWordNameForRegister

initialization
 TkwPopEditorGetParaByID.RegisterInEngine;
 {* Регистрация pop_editor_GetParaByID }
{$IfEnd} // NOT Defined(NoScripts)

end.
