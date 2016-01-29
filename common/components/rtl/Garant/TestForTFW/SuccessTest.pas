unit SuccessTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestForTFW"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/TestForTFW/SuccessTest.pas"
// �����: 27.09.2010 19:04
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::TestForTFW::TFWTests::TSuccessTest
//
// �������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TSuccessTest = class(TBaseTest)
  {* �������� ���� }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 published
 // published methods
   procedure DoIt;
 end;//TSuccessTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TSuccessTest

procedure TSuccessTest.DoIt;
//#UC START# *4CA0B2AC0096_4CA0B27401E4_var*
//#UC END# *4CA0B2AC0096_4CA0B27401E4_var*
begin
//#UC START# *4CA0B2AC0096_4CA0B27401E4_impl*
 Check(true);
//#UC END# *4CA0B2AC0096_4CA0B27401E4_impl*
end;//TSuccessTest.DoIt

function TSuccessTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'TFWTests';
end;//TSuccessTest.GetFolder

function TSuccessTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CA0B27401E4';
end;//TSuccessTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TSuccessTest.Suite);

end.