unit kwPopEditorSetTextParaStyle;
 {* StyleID textpara:SetStyleByID }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSetTextParaStyle.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_SetTextParaStyle" MUID: (4E60749A01C2)
// Имя типа: "TkwPopEditorSetTextParaStyle"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackTextParaWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwPopEditorSetTextParaStyle = class(TkwEditorFromStackTextParaWord)
  {* StyleID textpara:SetStyleByID }
  protected
   procedure DoPara(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPara: InevPara); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSetTextParaStyle
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evOp
 , CommentPara_Const
 , TextPara_Const
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopEditorSetTextParaStyle.DoPara(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPara: InevPara);
//#UC START# *50BA0BBD01BF_4E60749A01C2_var*
//#UC END# *50BA0BBD01BF_4E60749A01C2_var*
begin
//#UC START# *50BA0BBD01BF_4E60749A01C2_impl*
 if aCtx.rEngine.IsTopInt then
  anEditor.TextPara.Style.ID := aCtx.rEngine.PopInt
 else
  RunnerError('Не задан ID стиля!', aCtx);
//#UC END# *50BA0BBD01BF_4E60749A01C2_impl*
end;//TkwPopEditorSetTextParaStyle.DoPara

class function TkwPopEditorSetTextParaStyle.GetWordNameForRegister: AnsiString;
begin
 Result := 'textpara:SetStyleByID';
end;//TkwPopEditorSetTextParaStyle.GetWordNameForRegister

initialization
 TkwPopEditorSetTextParaStyle.RegisterInEngine;
 {* Регистрация pop_editor_SetTextParaStyle }
{$IfEnd} // NOT Defined(NoScripts)

end.
