unit kwPopEditorDeleteUserComment;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorDeleteUserComment.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

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
 TkwPopEditorDeleteUserComment = class(TkwEditorFromStackNextParaWord)
  protected
   procedure DoNextPara(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPara: InevPara); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorDeleteUserComment
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , CommentPara_Const
;

procedure TkwPopEditorDeleteUserComment.DoNextPara(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPara: InevPara);
//#UC START# *50BA0CC800CA_4DB7EA830363_var*
var
 l_Res : Boolean;
 l_Op  : InevOp;
//#UC END# *50BA0CC800CA_4DB7EA830363_var*
begin
//#UC START# *50BA0CC800CA_4DB7EA830363_impl*
 l_Res := false;
 if aPara.AsObject.IsKindOf(k2_typCommentPara) then
 begin
  l_Op := anEditor.StartOp;
  try
   if aPara.Edit.Delete(false, l_Op) then
    l_Res := true;
  finally
   l_Op := nil;
  end;//try..finally
 end;//aPara.IsKindOf(k2_typCommentPara)
 aCtx.rEngine.PushBool(l_Res);
//#UC END# *50BA0CC800CA_4DB7EA830363_impl*
end;//TkwPopEditorDeleteUserComment.DoNextPara

class function TkwPopEditorDeleteUserComment.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:DeleteComment';
end;//TkwPopEditorDeleteUserComment.GetWordNameForRegister

initialization
 TkwPopEditorDeleteUserComment.RegisterInEngine;
 {* Регистрация pop_editor_DeleteUserComment }
{$IfEnd} // NOT Defined(NoScripts)

end.
