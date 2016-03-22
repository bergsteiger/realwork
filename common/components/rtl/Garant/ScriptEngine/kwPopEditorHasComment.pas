unit kwPopEditorHasComment;
 {* editor:HasComment. Помещает в стек true, если текущий параграф содержит комментарий. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorHasComment.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_HasComment" MUID: (4DD0F87600ED)
// Имя типа: "TkwPopEditorHasComment"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackNextParaWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwPopEditorHasComment = class(TkwEditorFromStackNextParaWord)
  {* editor:HasComment. Помещает в стек true, если текущий параграф содержит комментарий. }
  protected
   procedure DoNextPara(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPara: InevPara); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorHasComment
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

procedure TkwPopEditorHasComment.DoNextPara(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPara: InevPara);
//#UC START# *50BA0CC800CA_4DD0F87600ED_var*
//#UC END# *50BA0CC800CA_4DD0F87600ED_var*
begin
//#UC START# *50BA0CC800CA_4DD0F87600ED_impl*
 aCtx.rEngine.PushBool(aPara.AsObject.IsKindOf(k2_typCommentPara));
//#UC END# *50BA0CC800CA_4DD0F87600ED_impl*
end;//TkwPopEditorHasComment.DoNextPara

class function TkwPopEditorHasComment.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:HasComment';
end;//TkwPopEditorHasComment.GetWordNameForRegister

initialization
 TkwPopEditorHasComment.RegisterInEngine;
 {* Регистрация pop_editor_HasComment }
{$IfEnd} // NOT Defined(NoScripts)

end.
