unit K233014754;
 {* [$233014754] }

// ������: "w:\common\components\rtl\Garant\Daily\K233014754.pas"
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
 TK233014754 = class(TScrollTest)
  {* [$233014754] }
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
 end;//TK233014754
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK233014754.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4C6CDC7B00F2_var*
//#UC END# *4C07AC6F036D_4C6CDC7B00F2_var*
begin
//#UC START# *4C07AC6F036D_4C6CDC7B00F2_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C6CDC7B00F2_impl*
end;//TK233014754.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK233014754.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4C6CDC7B00F2_var*
//#UC END# *4C08CF700318_4C6CDC7B00F2_var*
begin
//#UC START# *4C08CF700318_4C6CDC7B00F2_impl*
 Result.X := 768;
 Result.Y := 400;
//#UC END# *4C08CF700318_4C6CDC7B00F2_impl*
end;//TK233014754.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK233014754.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.6';
end;//TK233014754.GetFolder

function TK233014754.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C6CDC7B00F2';
end;//TK233014754.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK233014754.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
