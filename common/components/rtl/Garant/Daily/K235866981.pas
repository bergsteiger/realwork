unit K235866981;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K235866981.pas"
// �����: 04.10.2010 20:49
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K235866981
//
// {RequestLink:235866981}
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
  PreviewTestBefore235875079
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK235866981 = class(TPreviewTestBefore235875079)
  {* [RequestLink:235866981] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
    {$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
    {$IfEnd} //XE AND nsTest AND not NotTunedDUnit
 end;//TK235866981
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

// start class TK235866981

function TK235866981.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK235866981.GetFolder

function TK235866981.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CAA05800080';
end;//TK235866981.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK235866981.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4CAA05800080_var*
//#UC END# *51AF49E5001B_4CAA05800080_var*
begin
//#UC START# *51AF49E5001B_4CAA05800080_impl*
 Result := true;
//#UC END# *51AF49E5001B_4CAA05800080_impl*
end;//TK235866981.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK235866981.Suite);

end.