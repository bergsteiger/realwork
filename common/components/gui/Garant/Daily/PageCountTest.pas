unit PageCountTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// ������: "w:/common/components/gui/Garant/Daily/PageCountTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TPageCountTest
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  PreviewTest
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TPageCountTest = {abstract} class(TPreviewTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
   function OnlyCheckPageCount: Boolean; override;
 end;//TPageCountTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TPageCountTest

function TPageCountTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TPageCountTest.GetFolder

function TPageCountTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '51AD98A501F0';
end;//TPageCountTest.GetModelElementGUID

function TPageCountTest.OnlyCheckPageCount: Boolean;
//#UC START# *51AD98E70324_51AD98A501F0_var*
//#UC END# *51AD98E70324_51AD98A501F0_var*
begin
//#UC START# *51AD98E70324_51AD98A501F0_impl*
 Result := True;
//#UC END# *51AD98E70324_51AD98A501F0_impl*
end;//TPageCountTest.OnlyCheckPageCount

{$IfEnd} //nsTest AND not NoVCM

end.