unit MergeAndCheck;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/MergeAndCheck.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TMergeAndCheck
//
// ���� ����������� ����� � ��������� �������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  DrawTestPrim
  {$IfEnd} //nsTest AND not NoVCM
  ,
  nevTools,
  evCustomEditorWindow
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _SelectTablePart_Parent_ = TDrawTestPrim;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}
 TMergeAndCheck = {abstract} class(_SelectTablePart_)
  {* ���� ����������� ����� � ��������� ������������� }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); override;
     {* ���������� �����-������ �������� ����� ����������. }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
     {* �������� "����������" ����� ���������. }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TMergeAndCheck
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evOp
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}

// start class TMergeAndCheck

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TMergeAndCheck.DoBeforeDrawing(aForm: TPrimTextLoadForm);
//#UC START# *4CAC45AE011E_4CC8196F0219_var*
//#UC END# *4CAC45AE011E_4CC8196F0219_var*
begin
//#UC START# *4CAC45AE011E_4CC8196F0219_impl*
 MakeSelection(aForm.Text);
 aForm.Text.Range.Table.Cells.Merge;
 aForm.Text.Processor.Undo;
//#UC END# *4CAC45AE011E_4CC8196F0219_impl*
end;//TMergeAndCheck.DoBeforeDrawing
{$IfEnd} //nsTest AND not NoVCM

function TMergeAndCheck.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TMergeAndCheck.GetFolder

procedure TMergeAndCheck.GetSelectParam(out aStartRow: Integer;
  out aStartCell: Integer;
  out aFinishRow: Integer;
  out aFinishCell: Integer);
//#UC START# *4CC81D4101AC_4CC8196F0219_var*
//#UC END# *4CC81D4101AC_4CC8196F0219_var*
begin
//#UC START# *4CC81D4101AC_4CC8196F0219_impl*
 aStartRow := 0;
 aStartCell := 0;
 aFinishRow := 3;
 aFinishCell := 0;
//#UC END# *4CC81D4101AC_4CC8196F0219_impl*
end;//TMergeAndCheck.GetSelectParam

function TMergeAndCheck.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CC8196F0219';
end;//TMergeAndCheck.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.