unit CellMouseSelectionTest;
 {* ��������� ������ � ������� ����. }

// ������: "w:\common\components\rtl\Garant\Daily\CellMouseSelectionTest.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HotSpotSelectionTest
 , nevTools
 , l3Units
;

type
 TCellMouseSelectionTest = {abstract} class(THotSpotSelectionTest)
  {* ��������� ������ � ������� ����. }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* ���������� �����, �� ������� ����� ������������������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TCellMouseSelectionTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evConst
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

function TCellMouseSelectionTest.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
//#UC START# *4BF4E6A00093_4CED2FCF0081_var*
//#UC END# *4BF4E6A00093_4CED2FCF0081_var*
begin
//#UC START# *4BF4E6A00093_4CED2FCF0081_impl*
 Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[0];
//#UC END# *4BF4E6A00093_4CED2FCF0081_impl*
end;//TCellMouseSelectionTest.GetInnerPara

function TCellMouseSelectionTest.GetPoint(const aMap: InevMap): Tl3Point;
 {* ���������� �����, �� ������� ����� ������������������. }
//#UC START# *4C3C927B027E_4CED2FCF0081_var*
//#UC END# *4C3C927B027E_4CED2FCF0081_var*
begin
//#UC START# *4C3C927B027E_4CED2FCF0081_impl*
 Result := l3Point(aMap.Bounds.Left + 3 * evEpsilon, aMap.Outer.Bounds.Bottom - 2 * evEpsilon);
//#UC END# *4C3C927B027E_4CED2FCF0081_impl*
end;//TCellMouseSelectionTest.GetPoint

function TCellMouseSelectionTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TCellMouseSelectionTest.GetFolder

function TCellMouseSelectionTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CED2FCF0081';
end;//TCellMouseSelectionTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
