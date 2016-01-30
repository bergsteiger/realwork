unit K252524358;
 {* [$252524358] }

// ������: "w:\common\components\rtl\Garant\Daily\K252524358.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Translate2TextTest
 , nevTools
;

type
 TK252524358 = class(TTranslate2TextTest)
  {* [$252524358] }
  protected
   function SelectTableWholly: Boolean; override;
    {* ������ ������� ������� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
    {* ���������� �������� � �������� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK252524358
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK252524358.SelectTableWholly: Boolean;
 {* ������ ������� ������� }
//#UC START# *4C34625E021F_4D51578F03E7_var*
//#UC END# *4C34625E021F_4D51578F03E7_var*
begin
//#UC START# *4C34625E021F_4D51578F03E7_impl*
 Result := True;
//#UC END# *4C34625E021F_4D51578F03E7_impl*
end;//TK252524358.SelectTableWholly

function TK252524358.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7';
end;//TK252524358.GetFolder

function TK252524358.GetTablePara(const aDocument: InevParaList): InevParaList;
 {* ���������� �������� � �������� }
//#UC START# *4CC818F4022D_4D51578F03E7_var*
//#UC END# *4CC818F4022D_4D51578F03E7_var*
begin
//#UC START# *4CC818F4022D_4D51578F03E7_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4CC818F4022D_4D51578F03E7_impl*
end;//TK252524358.GetTablePara

function TK252524358.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D51578F03E7';
end;//TK252524358.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK252524358.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
