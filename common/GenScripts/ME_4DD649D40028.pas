unit kwPopEditorCurrentText;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCurrentText.pas"
// Стереотип: "ScriptKeyword"

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
 TkwPopEditorCurrentText = class(TkwEditorFromStackTextParaWord)
  protected
   procedure DoPara(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPara: InevPara); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorCurrentText
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , k2Tags
 , l3Base
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

procedure TkwPopEditorCurrentText.DoPara(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPara: InevPara);
//#UC START# *50BA0BBD01BF_4DD649D40028_var*
//#UC END# *50BA0BBD01BF_4DD649D40028_var*
begin
//#UC START# *50BA0BBD01BF_4DD649D40028_impl*
 aCtx.rEngine.PushString(aPara.AsObject.PCharLenA[k2_tiText]);
//#UC END# *50BA0BBD01BF_4DD649D40028_impl*
end;//TkwPopEditorCurrentText.DoPara

class function TkwPopEditorCurrentText.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:CurrentText';
end;//TkwPopEditorCurrentText.GetWordNameForRegister

initialization
 TkwPopEditorCurrentText.RegisterInEngine;
 {* Регистрация pop_editor_CurrentText }
{$IfEnd} // NOT Defined(NoScripts)

end.
