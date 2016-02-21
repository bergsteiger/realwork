unit kwEditorFromStackNextParaWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwEditorFromStackNextParaWord.pas"
// Стереотип: "SimpleClass"

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
 TkwEditorFromStackNextParaWord = {abstract} class(TkwEditorFromStackTextParaWord)
  protected
   procedure DoNextPara(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPara: InevPara); virtual; abstract;
   procedure DoPara(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPara: InevPara); override;
 end;//TkwEditorFromStackNextParaWord
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

procedure TkwEditorFromStackNextParaWord.DoPara(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPara: InevPara);
//#UC START# *50BA0BBD01BF_50BA0C4E001B_var*
//#UC END# *50BA0BBD01BF_50BA0C4E001B_var*
begin
//#UC START# *50BA0BBD01BF_50BA0C4E001B_impl*
 DoNextPara(aCtx, anEditor, aPara.Next);
//#UC END# *50BA0BBD01BF_50BA0C4E001B_impl*
end;//TkwEditorFromStackNextParaWord.DoPara

initialization
 TkwEditorFromStackNextParaWord.RegisterClass;
 {* Регистрация TkwEditorFromStackNextParaWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
