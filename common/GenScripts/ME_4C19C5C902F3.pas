unit K217691845;
 {* [$217691845] }

// ������: "w:\common\components\rtl\Garant\Daily\K217691845.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
 , Types
;

type
 TK217691845 = class(TScrollTest)
  {* [$217691845] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function SendKey: Boolean; override;
    {* ��������� �� ����� �������� ���������� ������� ������, � �� ������ ������� ��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK217691845
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
function TK217691845.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4C19C5C902F3_var*
//#UC END# *4C07AC6F036D_4C19C5C902F3_var*
begin
//#UC START# *4C07AC6F036D_4C19C5C902F3_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C19C5C902F3_impl*
end;//TK217691845.GetNormalFontSize

function TK217691845.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4C19C5C902F3_var*
//#UC END# *4C08CF700318_4C19C5C902F3_var*
begin
//#UC START# *4C08CF700318_4C19C5C902F3_impl*
 Result.X := 1024;
 Result.Y := 603;
//#UC END# *4C08CF700318_4C19C5C902F3_impl*
end;//TK217691845.FormExtent

function TK217691845.SendKey: Boolean;
 {* ��������� �� ����� �������� ���������� ������� ������, � �� ������ ������� ��������� }
//#UC START# *4C091B9A0305_4C19C5C902F3_var*
//#UC END# *4C091B9A0305_4C19C5C902F3_var*
begin
//#UC START# *4C091B9A0305_4C19C5C902F3_impl*
 Result := True;
//#UC END# *4C091B9A0305_4C19C5C902F3_impl*
end;//TK217691845.SendKey

function TK217691845.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK217691845.GetFolder

function TK217691845.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C19C5C902F3';
end;//TK217691845.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217691845.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
