unit kwPopEditorRepaintAndCheckWithEtalon;
 {* *��������:*
�������������� �������� �������� ������ �� ������������ ��� ������. ��������� ��������� �������������. ��� ������������ �� ����� ������ ���������! ��������� ���� � ������ NNN.shapes - ��� NNN - ����� ����� (��������! ��� ����� ����� ���������� � TK) . ���� �� ����� �� ������������ �������, �� �� ���������. � ��� ���������� � ����� ��������� �����. ���� ������ ��� �����������, �� ������������ ��������� ����� ������ ����� � ��������. ���� ��������� �� ������, �� �� ���� ����� �������� (���� ����� ��������� �� ���������) � ����� ������� ������� ��������� ��������� ������.
*������:*
[code]
anEditor pop:editor:RepaintCheckWithEtalon 
[code]
��� anEditor - ��������� �� ��������, � ������� ����� ������� �����������.
*������:*
[code]
focused:control:push pop:editor:RepaintCheckWithEtalon 
[code]
�������� ��������� � ���������, ��� ��������� �����. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintAndCheckWithEtalon.pas"
// ���������: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
 , nevShapesPaintedSpy
;

type
 _kwCheckWithEtalonCommon_Parent_ = TkwEditorFromStackWord;
 {$Include kwCheckWithEtalonCommon.imp.pas}
 TkwPopEditorRepaintAndCheckWithEtalon = class(_kwCheckWithEtalonCommon_)
  {* *��������:*
�������������� �������� �������� ������ �� ������������ ��� ������. ��������� ��������� �������������. ��� ������������ �� ����� ������ ���������! ��������� ���� � ������ NNN.shapes - ��� NNN - ����� ����� (��������! ��� ����� ����� ���������� � TK) . ���� �� ����� �� ������������ �������, �� �� ���������. � ��� ���������� � ����� ��������� �����. ���� ������ ��� �����������, �� ������������ ��������� ����� ������ ����� � ��������. ���� ��������� �� ������, �� �� ���� ����� �������� (���� ����� ��������� �� ���������) � ����� ������� ������� ��������� ��������� ������.
*������:*
[code]
anEditor pop:editor:RepaintCheckWithEtalon 
[code]
��� anEditor - ��������� �� ��������, � ������� ����� ������� �����������.
*������:*
[code]
focused:control:push pop:editor:RepaintCheckWithEtalon 
[code]
�������� ��������� � ���������, ��� ��������� �����. }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorRepaintAndCheckWithEtalon
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , StrUtils
;

{$Include kwCheckWithEtalonCommon.imp.pas}

procedure TkwPopEditorRepaintAndCheckWithEtalon.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4E1B0DEA0240_var*
//#UC END# *4F4CB81200CA_4E1B0DEA0240_var*
begin
//#UC START# *4F4CB81200CA_4E1B0DEA0240_impl*
 anEditor.View.ClearShapes;
 ExecuteWithEditor(aCtx, anEditor);
//#UC END# *4F4CB81200CA_4E1B0DEA0240_impl*
end;//TkwPopEditorRepaintAndCheckWithEtalon.DoWithEditor

class function TkwPopEditorRepaintAndCheckWithEtalon.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:RepaintAndCheckWithEtalon';
end;//TkwPopEditorRepaintAndCheckWithEtalon.GetWordNameForRegister

initialization
 TkwPopEditorRepaintAndCheckWithEtalon.RegisterInEngine;
 {* ����������� pop_editor_RepaintAndCheckWithEtalon }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
