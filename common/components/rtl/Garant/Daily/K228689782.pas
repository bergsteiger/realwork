unit K228689782;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K228689782.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K228689782
//
// [$228689782]
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
 TK228689782 = class(TPreviewTestBefore235875079)
  {* [$228689782] }
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
 end;//TK228689782
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

// start class TK228689782

{$If defined(nsTest) AND not defined(NoVCM)}
function TK228689782.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C5FAB6C00EE_var*
//#UC END# *4C07AC6F036D_4C5FAB6C00EE_var*
begin
//#UC START# *4C07AC6F036D_4C5FAB6C00EE_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C5FAB6C00EE_impl*
end;//TK228689782.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK228689782.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK228689782.GetFolder

function TK228689782.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C5FAB6C00EE';
end;//TK228689782.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK228689782.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4C5FAB6C00EE_var*
//#UC END# *51AF49E5001B_4C5FAB6C00EE_var*
begin
//#UC START# *51AF49E5001B_4C5FAB6C00EE_impl*
 Result := true;
//#UC END# *51AF49E5001B_4C5FAB6C00EE_impl*
end;//TK228689782.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK228689782.Suite);

end.