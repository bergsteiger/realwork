unit kwPopEditorSetStyle2Table;
 {* [code]
aStyle anEditor pop:editor:SetStyle2Table
[code]
aStyle -  ����� ����� �� ������� ������.
anEditor - ��������, � ������� ������������ ���������. }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwPopEditorSetStyle2Table.pas"
// ���������: "ScriptKeyword"
// ������� ������: "pop_editor_SetStyle2Table" MUID: (52B17C50008A)
// ��� ����: "TkwPopEditorSetStyle2Table"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorSetStyle2Table = {final} class(TkwEditorFromStackWord)
  {* [code]
aStyle anEditor pop:editor:SetStyle2Table
[code]
aStyle -  ����� ����� �� ������� ������.
anEditor - ��������, � ������� ������������ ���������. }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSetStyle2Table
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evCommonUtils
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *52B17C50008Aimpl_uses*
 //#UC END# *52B17C50008Aimpl_uses*
;

procedure TkwPopEditorSetStyle2Table.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_52B17C50008A_var*
var
 l_StyleID: Integer;
//#UC END# *4F4CB81200CA_52B17C50008A_var*
begin
//#UC START# *4F4CB81200CA_52B17C50008A_impl*
 if aCtx.rEngine.IsTopInt then
  l_StyleID := aCtx.rEngine.PopInt
 else
  Assert(False, '�� ����� ����� ��� ���������!');
 aCtx.rCaller.Check(evSetTableStyle(anEditor), '�� ������� ��������� ����� �� �������!');
//#UC END# *4F4CB81200CA_52B17C50008A_impl*
end;//TkwPopEditorSetStyle2Table.DoWithEditor

class function TkwPopEditorSetStyle2Table.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:SetStyle2Table';
end;//TkwPopEditorSetStyle2Table.GetWordNameForRegister

initialization
 TkwPopEditorSetStyle2Table.RegisterInEngine;
 {* ����������� pop_editor_SetStyle2Table }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
