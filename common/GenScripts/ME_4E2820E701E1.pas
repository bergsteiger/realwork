unit kwPopEditorSelectTable;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectTable.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , nevTools
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 _SelectTablePart_Parent_ = TkwEditorFromStackCursorWord;
 {$Include SelectTablePart.imp.pas}
 TkwPopEditorSelectTable = class(_SelectTablePart_)
  private
   f_Point: InevBasePoint;
  protected
   procedure DoCursor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPoint: InevBasePoint); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function SelectTableWholly: Boolean; override;
    {* Вылять таблицу целиком }
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
    {* Возвращает параграф с таблицей }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSelectTable
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Table_Const
 , evOp
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
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

{$Include SelectTablePart.imp.pas}

procedure TkwPopEditorSelectTable.DoCursor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPoint: InevBasePoint);
//#UC START# *50B8BCDF0093_4E2820E701E1_var*
//#UC END# *50B8BCDF0093_4E2820E701E1_var*
begin
//#UC START# *50B8BCDF0093_4E2820E701E1_impl*
 f_Point := aPoint;
 try
  MakeSelection(anEditor);
 finally
  f_Point := nil; 
 end;//try..finally
//#UC END# *50B8BCDF0093_4E2820E701E1_impl*
end;//TkwPopEditorSelectTable.DoCursor

procedure TkwPopEditorSelectTable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4E2820E701E1_var*
//#UC END# *479731C50290_4E2820E701E1_var*
begin
//#UC START# *479731C50290_4E2820E701E1_impl*
 f_Point := nil;
 inherited;
//#UC END# *479731C50290_4E2820E701E1_impl*
end;//TkwPopEditorSelectTable.Cleanup

function TkwPopEditorSelectTable.SelectTableWholly: Boolean;
 {* Вылять таблицу целиком }
//#UC START# *4C34625E021F_4E2820E701E1_var*
//#UC END# *4C34625E021F_4E2820E701E1_var*
begin
//#UC START# *4C34625E021F_4E2820E701E1_impl*
 Result := True;
//#UC END# *4C34625E021F_4E2820E701E1_impl*
end;//TkwPopEditorSelectTable.SelectTableWholly

function TkwPopEditorSelectTable.GetTablePara(const aDocument: InevParaList): InevParaList;
 {* Возвращает параграф с таблицей }
//#UC START# *4CC818F4022D_4E2820E701E1_var*
var
 l_Inner: InevBasePoint;
//#UC END# *4CC818F4022D_4E2820E701E1_var*
begin
//#UC START# *4CC818F4022D_4E2820E701E1_impl*
 Result := nil;
 l_Inner := f_Point;
 while (l_Inner <> nil) and not l_Inner.AsObject.IsKindOf(k2_typTable) do
  l_Inner := l_Inner.Inner;
 if l_Inner <> nil then
  Result := l_Inner.Obj.AsPara.AsList;
//#UC END# *4CC818F4022D_4E2820E701E1_impl*
end;//TkwPopEditorSelectTable.GetTablePara

class function TkwPopEditorSelectTable.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:SelectTable';
end;//TkwPopEditorSelectTable.GetWordNameForRegister

initialization
 TkwPopEditorSelectTable.RegisterInEngine;
 {* Регистрация pop_editor_SelectTable }
{$IfEnd} // NOT Defined(NoScripts)

end.
