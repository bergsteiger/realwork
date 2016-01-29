unit K229213001;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K229213001.pas"
// �����: 29.07.2010 17:33
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K229213001
//
// {RequestLink:229213001}
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
  SearchAndReplaceTest
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK229213001 = class(TSearchAndReplaceTest)
  {* [RequestLink:229213001] }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function StringForSearch: AnsiString; override;
     {* ������ ��� ������ }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function StringForReplace: AnsiString; override;
     {* ������ ��� ������ }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK229213001
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

// start class TK229213001

{$If defined(nsTest) AND not defined(NoVCM)}
function TK229213001.StringForSearch: AnsiString;
//#UC START# *4BE051200169_4C5183260027_var*
//#UC END# *4BE051200169_4C5183260027_var*
begin
//#UC START# *4BE051200169_4C5183260027_impl*
 Result := 'bbb';
//#UC END# *4BE051200169_4C5183260027_impl*
end;//TK229213001.StringForSearch
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK229213001.StringForReplace: AnsiString;
//#UC START# *4BE0513800C9_4C5183260027_var*
//#UC END# *4BE0513800C9_4C5183260027_var*
begin
//#UC START# *4BE0513800C9_4C5183260027_impl*
 Result := #13#10;
//#UC END# *4BE0513800C9_4C5183260027_impl*
end;//TK229213001.StringForReplace
{$IfEnd} //nsTest AND not NoVCM

function TK229213001.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK229213001.GetFolder

function TK229213001.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C5183260027';
end;//TK229213001.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK229213001.Suite);

end.