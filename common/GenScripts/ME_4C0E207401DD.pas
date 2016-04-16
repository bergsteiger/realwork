unit K217683893;
 {* [RequestLink:217683893]. }

// ������: "w:\common\components\rtl\Garant\Daily\K217683893.pas"
// ���������: "TestCase"
// ������� ������: "K217683893" MUID: (4C0E207401DD)
// ��� ����: "TK217683893"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollBackTest
 {$IfEnd} // NOT Defined(NoVCM)
 , Types
;

type
 TK217683893 = class({$If NOT Defined(NoVCM)}
 TScrollBackTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:217683893]. }
  protected
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK217683893
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
function TK217683893.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4C0E207401DD_var*
//#UC END# *4C07AC6F036D_4C0E207401DD_var*
begin
//#UC START# *4C07AC6F036D_4C0E207401DD_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C0E207401DD_impl*
end;//TK217683893.GetNormalFontSize

function TK217683893.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4C0E207401DD_var*
//#UC END# *4C08CF700318_4C0E207401DD_var*
begin
//#UC START# *4C08CF700318_4C0E207401DD_impl*
 Result.X := 798;
 Result.Y := 465;
//#UC END# *4C08CF700318_4C0E207401DD_impl*
end;//TK217683893.FormExtent

function TK217683893.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK217683893.GetFolder

function TK217683893.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C0E207401DD';
end;//TK217683893.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217683893.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
