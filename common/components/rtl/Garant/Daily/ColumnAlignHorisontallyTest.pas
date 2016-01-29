unit ColumnAlignHorisontallyTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/ColumnAlignHorisontallyTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TColumnAlignHorisontallyTest
//
// ������������ ������ � ������� ������������.
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
 TColumnAlignHorisontallyTest = {abstract} class(TTableToolsTest)
  {* ������������ ������ � ������� ������������. }
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
 end;//TColumnAlignHorisontallyTest
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

// start class TColumnAlignHorisontallyTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TColumnAlignHorisontallyTest.ApplyTools(const aRange: IedRange);
//#UC START# *4C345B580083_4C3C2BE800AF_var*
//#UC END# *4C345B580083_4C3C2BE800AF_var*
begin
//#UC START# *4C345B580083_4C3C2BE800AF_impl*
 aRange.TextParagraph.Formatting.HorizontalAligment := ed_halLeft; 
//#UC END# *4C345B580083_4C3C2BE800AF_impl*
end;//TColumnAlignHorisontallyTest.ApplyTools
{$IfEnd} //nsTest AND not NoVCM

function TColumnAlignHorisontallyTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TColumnAlignHorisontallyTest.GetFolder

function TColumnAlignHorisontallyTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3C2BE800AF';
end;//TColumnAlignHorisontallyTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.