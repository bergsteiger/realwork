unit MergeTablesTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/MergeTablesTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TMergeTablesTest
//
// ������������ ����������� ������
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
 TMergeTablesTest = {abstract} class(TTableToolsTest)
  {* ������������ ����������� ������ }
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
   function NeedSelection: Boolean; override;
     {* ����� �� ����-������ ��������. }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TMergeTablesTest
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

// start class TMergeTablesTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TMergeTablesTest.ApplyTools(const aRange: IedRange);
//#UC START# *4C345B580083_4C3AF74701A6_var*
//#UC END# *4C345B580083_4C3AF74701A6_var*
begin
//#UC START# *4C345B580083_4C3AF74701A6_impl*
 aRange.Table.Merge(nil);
//#UC END# *4C345B580083_4C3AF74701A6_impl*
end;//TMergeTablesTest.ApplyTools
{$IfEnd} //nsTest AND not NoVCM

function TMergeTablesTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TMergeTablesTest.GetFolder

function TMergeTablesTest.NeedSelection: Boolean;
//#UC START# *4CC8189D02DF_4C3AF74701A6_var*
//#UC END# *4CC8189D02DF_4C3AF74701A6_var*
begin
//#UC START# *4CC8189D02DF_4C3AF74701A6_impl*
 Result := False;
//#UC END# *4CC8189D02DF_4C3AF74701A6_impl*
end;//TMergeTablesTest.NeedSelection

function TMergeTablesTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3AF74701A6';
end;//TMergeTablesTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.