unit K252524333;
 {* [$252524333] }

// ������: "w:\common\components\rtl\Garant\Daily\K252524333.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ColumnResizeWithCtrl
;

type
 TK252524333 = class(TColumnResizeWithCtrl)
  {* [$252524333] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   procedure GetColumnAndRow(var aCol: Integer;
    var aRow: Integer); override;
   function GetDelta: Integer; override;
 end;//TK252524333
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

function TK252524333.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK252524333.GetFolder

function TK252524333.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D53D7020116';
end;//TK252524333.GetModelElementGUID

procedure TK252524333.GetColumnAndRow(var aCol: Integer;
 var aRow: Integer);
//#UC START# *4E32CA35008A_4D53D7020116_var*
//#UC END# *4E32CA35008A_4D53D7020116_var*
begin
//#UC START# *4E32CA35008A_4D53D7020116_impl*
 aCol := 2;
 aRow := 4;
//#UC END# *4E32CA35008A_4D53D7020116_impl*
end;//TK252524333.GetColumnAndRow

function TK252524333.GetDelta: Integer;
//#UC START# *4E32CA5E0115_4D53D7020116_var*
//#UC END# *4E32CA5E0115_4D53D7020116_var*
begin
//#UC START# *4E32CA5E0115_4D53D7020116_impl*
 Result := 250;
//#UC END# *4E32CA5E0115_4D53D7020116_impl*
end;//TK252524333.GetDelta

initialization
 TestFramework.RegisterTest(TK252524333.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
