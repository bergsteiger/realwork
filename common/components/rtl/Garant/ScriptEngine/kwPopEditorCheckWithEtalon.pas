unit kwPopEditorCheckWithEtalon;
 {* *��������:*
�������������� �������� �������� ������ �� ������������ ��� ������. ���������� ������ �� ��������� ��������� ������ ����� ��������� �������. ��������� ���� � ������ NNN.shapes - ��� NNN - ����� ����� (��������! ��� ����� ����� ���������� � TK) . ���� �� ����� �� ������������ �������, �� �� ���������. � ��� ���������� � ����� ��������� �����. ���� ������ ��� �����������, �� ������������ ��������� ����� ������ ����� � ��������. ���� ��������� �� ������, �� �� ���� ����� �������� (���� ����� ��������� �� ���������) � ����� ������� ������� ��������� ��������� ������.
*������:*
[code]
anEditor pop:editor:CheckWithEtalon aProc
[code]
��� anEditor - ��������� �� ��������, � ������� ����� ��������� ���������. aProc - ���������, ���������� ���������.
*������:*
[code]
focused:control:push pop:editor:CheckWithEtalon "��������� ������ �������"
[code]
��������� ��������� � ���������, ��� ��������� ����� ����� ���������� ������� "��������� ������ �������". }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorCheckWithEtalon.pas"
// ���������: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwWordWorker
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
;

type
 TkwPopEditorCheckWithEtalon = {final} class(TtfwWordWorker)
  {* *��������:*
�������������� �������� �������� ������ �� ������������ ��� ������. ���������� ������ �� ��������� ��������� ������ ����� ��������� �������. ��������� ���� � ������ NNN.shapes - ��� NNN - ����� ����� (��������! ��� ����� ����� ���������� � TK) . ���� �� ����� �� ������������ �������, �� �� ���������. � ��� ���������� � ����� ��������� �����. ���� ������ ��� �����������, �� ������������ ��������� ����� ������ ����� � ��������. ���� ��������� �� ������, �� �� ���� ����� �������� (���� ����� ��������� �� ���������) � ����� ������� ������� ��������� ��������� ������.
*������:*
[code]
anEditor pop:editor:CheckWithEtalon aProc
[code]
��� anEditor - ��������� �� ��������, � ������� ����� ��������� ���������. aProc - ���������, ���������� ���������.
*������:*
[code]
focused:control:push pop:editor:CheckWithEtalon "��������� ������ �������"
[code]
��������� ��������� � ���������, ��� ��������� ����� ����� ���������� ������� "��������� ������ �������". }
  protected
   function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorCheckWithEtalon
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwCompiledCheckWithEtalon
;

function TkwPopEditorCheckWithEtalon.CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
//#UC START# *4DCBD67C0362_50D44F67024C_var*
//#UC END# *4DCBD67C0362_50D44F67024C_var*
begin
//#UC START# *4DCBD67C0362_50D44F67024C_impl*
 Result := TkwCompiledCheckWithEtalon;
//#UC END# *4DCBD67C0362_50D44F67024C_impl*
end;//TkwPopEditorCheckWithEtalon.CompiledWorkerClass

class function TkwPopEditorCheckWithEtalon.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:CheckWithEtalon';
end;//TkwPopEditorCheckWithEtalon.GetWordNameForRegister

initialization
 TkwPopEditorCheckWithEtalon.RegisterInEngine;
 {* ����������� pop_editor_CheckWithEtalon }
{$IfEnd} // NOT Defined(NoScripts)

end.
