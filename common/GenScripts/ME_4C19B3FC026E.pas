unit K217691824;
 {* [$217691824] }

// ������: "w:\common\components\rtl\Garant\Daily\K217691824.pas"
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
 TK217691824 = class(TScrollTest)
  {* [$217691824] }
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
   {$If NOT Defined(NoVCM)}
   function MaxHeight: Integer; override;
    {* ���� ������������ �� 0, �� ����� ����������� ���� ������� ������ �� FormExtent.Y �� MaxHeight }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK217691824
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK217691824.GetNormalFontSize: Integer;
 {* ���������� ������ ������ ����� "����������". 0 - ��-��������� }
//#UC START# *4C07AC6F036D_4C19B3FC026E_var*
//#UC END# *4C07AC6F036D_4C19B3FC026E_var*
begin
//#UC START# *4C07AC6F036D_4C19B3FC026E_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C19B3FC026E_impl*
end;//TK217691824.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK217691824.FormExtent: TPoint;
 {* ������� ����� }
//#UC START# *4C08CF700318_4C19B3FC026E_var*
//#UC END# *4C08CF700318_4C19B3FC026E_var*
begin
//#UC START# *4C08CF700318_4C19B3FC026E_impl*
 Result.X := 1024;
 Result.Y := 603;
//#UC END# *4C08CF700318_4C19B3FC026E_impl*
end;//TK217691824.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK217691824.SendKey: Boolean;
 {* ��������� �� ����� �������� ���������� ������� ������, � �� ������ ������� ��������� }
//#UC START# *4C091B9A0305_4C19B3FC026E_var*
//#UC END# *4C091B9A0305_4C19B3FC026E_var*
begin
//#UC START# *4C091B9A0305_4C19B3FC026E_impl*
 Result := True;
//#UC END# *4C091B9A0305_4C19B3FC026E_impl*
end;//TK217691824.SendKey
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK217691824.MaxHeight: Integer;
 {* ���� ������������ �� 0, �� ����� ����������� ���� ������� ������ �� FormExtent.Y �� MaxHeight }
//#UC START# *4C0E56F000A4_4C19B3FC026E_var*
//#UC END# *4C0E56F000A4_4C19B3FC026E_var*
begin
//#UC START# *4C0E56F000A4_4C19B3FC026E_impl*
 Result := 0{768};
//#UC END# *4C0E56F000A4_4C19B3FC026E_impl*
end;//TK217691824.MaxHeight
{$IfEnd} // NOT Defined(NoVCM)

function TK217691824.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.5';
end;//TK217691824.GetFolder

function TK217691824.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C19B3FC026E';
end;//TK217691824.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217691824.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
