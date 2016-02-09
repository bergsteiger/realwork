unit K217681540;
 {* [RequestLink:217681540] }

// ������: "w:\common\components\rtl\Garant\Daily\K217681540.pas"
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
 TK217681540 = class(TScrollTest)
  {* [RequestLink:217681540] }
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
 end;//TK217681540
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
function TK217681540.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4C09139A00FE_var*
//#UC END# *4C07AC6F036D_4C09139A00FE_var*
begin
//#UC START# *4C07AC6F036D_4C09139A00FE_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C09139A00FE_impl*
end;//TK217681540.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK217681540.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4C09139A00FE_var*
//#UC END# *4C08CF700318_4C09139A00FE_var*
begin
//#UC START# *4C08CF700318_4C09139A00FE_impl*
 Result.X := 798;
 Result.Y := 465;
//#UC END# *4C08CF700318_4C09139A00FE_impl*
end;//TK217681540.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK217681540.SendKey: Boolean;
 {* ��������� �� ����� �������� ���������� ������� ������, � �� ������ ������� ��������� }
//#UC START# *4C091B9A0305_4C09139A00FE_var*
//#UC END# *4C091B9A0305_4C09139A00FE_var*
begin
//#UC START# *4C091B9A0305_4C09139A00FE_impl*
 Result := true;
//#UC END# *4C091B9A0305_4C09139A00FE_impl*
end;//TK217681540.SendKey
{$IfEnd} // NOT Defined(NoVCM)

function TK217681540.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK217681540.GetFolder

function TK217681540.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C09139A00FE';
end;//TK217681540.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217681540.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
