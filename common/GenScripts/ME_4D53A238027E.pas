unit K253664689;
 {* [$253664689] }

// ������: "w:\common\components\rtl\Garant\Daily\K253664689.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MergeCellsTest
 , nevTools
;

type
 TK253664689 = class(TMergeCellsTest)
  {* [$253664689] }
  protected
   function SelectTableWholly: Boolean; override;
    {* ������ ������� ������� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
    {* ���������� �������� � �������� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK253664689
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK253664689.SelectTableWholly: Boolean;
 {* ������ ������� ������� }
//#UC START# *4C34625E021F_4D53A238027E_var*
//#UC END# *4C34625E021F_4D53A238027E_var*
begin
//#UC START# *4C34625E021F_4D53A238027E_impl*
 Result := True;
//#UC END# *4C34625E021F_4D53A238027E_impl*
end;//TK253664689.SelectTableWholly

function TK253664689.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK253664689.GetFolder

function TK253664689.GetTablePara(const aDocument: InevParaList): InevParaList;
 {* ���������� �������� � �������� }
//#UC START# *4CC818F4022D_4D53A238027E_var*
//#UC END# *4CC818F4022D_4D53A238027E_var*
begin
//#UC START# *4CC818F4022D_4D53A238027E_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4CC818F4022D_4D53A238027E_impl*
end;//TK253664689.GetTablePara

function TK253664689.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D53A238027E';
end;//TK253664689.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK253664689.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
