unit K235052899;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K235052899.pas"
// �����: 17.09.2010 20:22
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K235052899
//
// {RequestLink:235052899}.
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
  EVDwithFormulasToRTFWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK235052899 = class(TEVDwithFormulasToRTFWriterTest)
  {* [RequestLink:235052899]. }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
    {$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
    {$IfEnd} //XE AND nsTest AND not NotTunedDUnit
 end;//TK235052899
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK235052899

function TK235052899.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK235052899.GetFolder

function TK235052899.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C9395B90345';
end;//TK235052899.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK235052899.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4C9395B90345_var*
//#UC END# *51AF49E5001B_4C9395B90345_var*
begin
//#UC START# *51AF49E5001B_4C9395B90345_impl*
 Result := true;
//#UC END# *51AF49E5001B_4C9395B90345_impl*
end;//TK235052899.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK235052899.Suite);

end.