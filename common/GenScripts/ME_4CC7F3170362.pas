unit DrawTest;
 {* ���� ����: ���������� � �������� � ��������. }

// ������: "w:\common\components\rtl\Garant\Daily\DrawTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , DrawTestPrim
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TDrawTest = {abstract} class(TDrawTestPrim)
  {* ���� ����: ���������� � �������� � ��������. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); override;
    {* ���������� �����-������ �������� ����� ����������. }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$If NOT Defined(NoVCM)}
   function UseFormExtentAsClientSize: Boolean; override;
    {* ������������ �������� ������� ����� ��� ������� ���������� ������� - ������� ����� ��������������� ������������ ���� �����������. }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TDrawTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
procedure TDrawTest.DoBeforeDrawing(aForm: TPrimTextLoadForm);
 {* ���������� �����-������ �������� ����� ����������. }
//#UC START# *4CAC45AE011E_4CC7F3170362_var*
//#UC END# *4CAC45AE011E_4CC7F3170362_var*
begin
//#UC START# *4CAC45AE011E_4CC7F3170362_impl*
 // ��� ���� ������ ��� �������� ���������, ������� ������ �� ������. 
//#UC END# *4CAC45AE011E_4CC7F3170362_impl*
end;//TDrawTest.DoBeforeDrawing
{$IfEnd} // NOT Defined(NoVCM)

function TDrawTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TDrawTest.GetFolder

{$If NOT Defined(NoVCM)}
function TDrawTest.UseFormExtentAsClientSize: Boolean;
 {* ������������ �������� ������� ����� ��� ������� ���������� ������� - ������� ����� ��������������� ������������ ���� �����������. }
//#UC START# *4DA2F7900393_4CC7F3170362_var*
//#UC END# *4DA2F7900393_4CC7F3170362_var*
begin
//#UC START# *4DA2F7900393_4CC7F3170362_impl*
 Result := True;
//#UC END# *4DA2F7900393_4CC7F3170362_impl*
end;//TDrawTest.UseFormExtentAsClientSize
{$IfEnd} // NOT Defined(NoVCM)

function TDrawTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CC7F3170362';
end;//TDrawTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
