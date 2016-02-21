unit ColumnResizeWithCtrl;
 {* ��������� ������� ������� � ������� Ctrl }

// ������: "w:\common\components\rtl\Garant\Daily\ColumnResizeWithCtrl.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ColumnResizeByMousePrimTest
 , Classes
;

type
 TColumnResizeWithCtrl = {abstract} class(TColumnResizeByMousePrimTest)
  {* ��������� ������� ������� � ������� Ctrl }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   function GetKeys: TShiftState; override;
 end;//TColumnResizeWithCtrl
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

function TColumnResizeWithCtrl.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TColumnResizeWithCtrl.GetFolder

function TColumnResizeWithCtrl.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D53D6AA0038';
end;//TColumnResizeWithCtrl.GetModelElementGUID

function TColumnResizeWithCtrl.GetKeys: TShiftState;
//#UC START# *4E32CA120170_4D53D6AA0038_var*
//#UC END# *4E32CA120170_4D53D6AA0038_var*
begin
//#UC START# *4E32CA120170_4D53D6AA0038_impl*
 Result := [ssCtrl];
//#UC END# *4E32CA120170_4D53D6AA0038_impl*
end;//TColumnResizeWithCtrl.GetKeys
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
