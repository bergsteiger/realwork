unit K213713120;
 {* [RequestLink:213713120] }

// ������: "w:\common\components\rtl\Garant\Daily\K213713120.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

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
 TK213713120 = class(TScrollTest)
  {* [RequestLink:213713120] }
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
 end;//TK213713120
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK213713120.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4C08A9F20321_var*
//#UC END# *4C07AC6F036D_4C08A9F20321_var*
begin
//#UC START# *4C07AC6F036D_4C08A9F20321_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C08A9F20321_impl*
end;//TK213713120.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK213713120.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4C08A9F20321_var*
//#UC END# *4C08CF700318_4C08A9F20321_var*
begin
//#UC START# *4C08CF700318_4C08A9F20321_impl*
 Result.X := 798;
 Result.Y := 440;
//#UC END# *4C08CF700318_4C08A9F20321_impl*
end;//TK213713120.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK213713120.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK213713120.GetFolder

function TK213713120.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C08A9F20321';
end;//TK213713120.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK213713120.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
