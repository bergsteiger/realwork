unit K269062434;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K269062434.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K269062434
//
// [$269062434]
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
  PreviewWithRowCompare
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK269062434 = class(TPreviewWithRowCompare)
  {* [$269062434] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
    {$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
    {$IfEnd} //XE AND nsTest AND not NotTunedDUnit
 end;//TK269062434
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  PrintRowHeightsSpy
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

// start class TK269062434

{$If defined(nsTest) AND not defined(NoVCM)}
function TK269062434.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4DF8BC1F007E_var*
//#UC END# *4C07AC6F036D_4DF8BC1F007E_var*
begin
//#UC START# *4C07AC6F036D_4DF8BC1F007E_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4DF8BC1F007E_impl*
end;//TK269062434.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK269062434.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK269062434.GetFolder

function TK269062434.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DF8BC1F007E';
end;//TK269062434.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK269062434.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4DF8BC1F007E_var*
//#UC END# *51AF49E5001B_4DF8BC1F007E_var*
begin
//#UC START# *51AF49E5001B_4DF8BC1F007E_impl*
 Result := True;
//#UC END# *51AF49E5001B_4DF8BC1F007E_impl*
end;//TK269062434.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK269062434.Suite);

end.