unit HorzMergeCells;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/HorzMergeCells.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::THorzMergeCells
//
// ����������� ����� �� �����������.
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
  TableToolsTest,
  evEditorInterfaces
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 THorzMergeCells = {abstract} class(TTableToolsTest)
  {* ����������� ����� �� �����������. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
     {* ������� ���������� ��� ������� }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//THorzMergeCells
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
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

// start class THorzMergeCells

{$If defined(nsTest) AND not defined(NoVCM)}
procedure THorzMergeCells.ApplyTools(const aRange: IedRange);
//#UC START# *4C345B580083_4DCA1D3D034A_var*
//#UC END# *4C345B580083_4DCA1D3D034A_var*
begin
//#UC START# *4C345B580083_4DCA1D3D034A_impl*
 aRange.Table.Cells.Merge(ed_maHorz);
//#UC END# *4C345B580083_4DCA1D3D034A_impl*
end;//THorzMergeCells.ApplyTools
{$IfEnd} //nsTest AND not NoVCM

function THorzMergeCells.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//THorzMergeCells.GetFolder

function THorzMergeCells.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DCA1D3D034A';
end;//THorzMergeCells.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.