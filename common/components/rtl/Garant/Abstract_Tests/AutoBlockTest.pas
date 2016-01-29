unit AutoBlockTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Abstract Tests"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Abstract_Tests/AutoBlockTest.pas"
// �����: 10.12.2010 19:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TAutoBlockTest
//
// ���� ��������� ��������� �� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TAutoBlockTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� ��������� ��������� �� ����� }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* ���������� ������� ��������� ������ }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TAutoBlockTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evAutoBlock,
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

// start class TAutoBlockTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TAutoBlockTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4D0256A60243_var*
//#UC END# *4BE13147032C_4D0256A60243_var*
begin
//#UC START# *4BE13147032C_4D0256A60243_impl*
 evAutoBlock.CreateBlockStructure(aForm.Text);
//#UC END# *4BE13147032C_4D0256A60243_impl*
end;//TAutoBlockTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TAutoBlockTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TAutoBlockTest.GetFolder

function TAutoBlockTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D0256A60243';
end;//TAutoBlockTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.