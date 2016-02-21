unit kwPopEditorSelectColumn;
 {* *������:* aColID anEditorControl pop:editor:SelectCells
*��������:* �������� ������� �������. ������ ������ ��� ��������� � �������. ��������� ������� � ������� �� ����� ��������. ��������� aColID - Integer
*������:*
[code] 
2 focused:control:push pop:editor:SelectCells
[code] 
*���������:* �������� ������ �������. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectColumn.pas"
// ���������: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 _kwEditorGetTableFromCursor_Parent_ = TkwEditorFromStackWord;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\kwEditorGetTableFromCursor.imp.pas}
 TkwPopEditorSelectColumn = {final} class(_kwEditorGetTableFromCursor_)
  {* *������:* aColID anEditorControl pop:editor:SelectCells
*��������:* �������� ������� �������. ������ ������ ��� ��������� � �������. ��������� ������� � ������� �� ����� ��������. ��������� aColID - Integer
*������:*
[code] 
2 focused:control:push pop:editor:SelectCells
[code] 
*���������:* �������� ������ �������. }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSelectColumn
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , Table_Const
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\kwEditorGetTableFromCursor.imp.pas}

procedure TkwPopEditorSelectColumn.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4F548EC7007E_var*
var
 l_ColID      : Integer;
 l_TablePoint : InevBasePoint;
//#UC END# *4F4CB81200CA_4F548EC7007E_var*
begin
//#UC START# *4F4CB81200CA_4F548EC7007E_impl*
 l_TablePoint := GetTablePoint(aCtx, anEditor.Selection.Cursor);
 if aCtx.rEngine.IsTopInt then
  l_ColID := aCtx.rEngine.PopInt
 else
  Assert(False, '�� ����� ����� �������!'); 
 evSelectTableColumn(anEditor.Selection, l_TablePoint.Obj^.AsPara.AsList, l_ColID);
//#UC END# *4F4CB81200CA_4F548EC7007E_impl*
end;//TkwPopEditorSelectColumn.DoWithEditor

class function TkwPopEditorSelectColumn.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:SelectColumn';
end;//TkwPopEditorSelectColumn.GetWordNameForRegister

initialization
 TkwPopEditorSelectColumn.RegisterInEngine;
 {* ����������� pop_editor_SelectColumn }
{$IfEnd} // NOT Defined(NoScripts)

end.
