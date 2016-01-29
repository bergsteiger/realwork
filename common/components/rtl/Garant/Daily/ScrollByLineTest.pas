unit ScrollByLineTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/ScrollByLineTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TScrollByLineTest
//
// ���� ��������� ���� ���������
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
  TextEditorVisitor
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TScrollByLineTest = {abstract} class(TTextEditorVisitor)
  {* ���� ��������� ���� ��������� }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* ���������� ����� }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TScrollByLineTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
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

// start class TScrollByLineTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TScrollByLineTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4CB6E426014A_var*
//#UC END# *4BE419AF0217_4CB6E426014A_var*
begin
//#UC START# *4BE419AF0217_4CB6E426014A_impl*
 ScrollByLine(aForm, -1, False, False);
//#UC END# *4BE419AF0217_4CB6E426014A_impl*
end;//TScrollByLineTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TScrollByLineTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TScrollByLineTest.GetFolder

function TScrollByLineTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CB6E426014A';
end;//TScrollByLineTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.