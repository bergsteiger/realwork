unit MouseMoveCellsSelectTest;
 {* ���� ��������� � ������� ���� ��������� �����. }

// ������: "w:\common\components\rtl\Garant\Daily\MouseMoveCellsSelectTest.pas"
// ���������: "TestCase"
// ������� ������: "TMouseMoveCellsSelectTest" MUID: (4D3D429001F4)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MouseMoveSelectionTest
 , nevTools
 , l3Units
;

type
 TMouseMoveCellsSelectTest = {abstract} class(TMouseMoveSelectionTest)
  {* ���� ��������� � ������� ���� ��������� �����. }
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
 end;//TMouseMoveCellsSelectTest
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
 //#UC START# *4D3D429001F4impl_uses*
 //#UC END# *4D3D429001F4impl_uses*
;

function TMouseMoveCellsSelectTest.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
//#UC START# *4BF4E6A00093_4D3D429001F4_var*
//#UC END# *4BF4E6A00093_4D3D429001F4_var*
begin
//#UC START# *4BF4E6A00093_4D3D429001F4_impl*
 if f_StartPoint then
  Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[2].AsList.Para[0].AsList.Para[0]
 else
  Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[2].AsList.Para[2].AsList.Para[0]
//#UC END# *4BF4E6A00093_4D3D429001F4_impl*
end;//TMouseMoveCellsSelectTest.GetInnerPara

function TMouseMoveCellsSelectTest.GetPoint(const aMap: InevMap): Tl3Point;
 {* ���������� �����, �� ������� ����� ������������������. }
//#UC START# *4C3C927B027E_4D3D429001F4_var*
//#UC END# *4C3C927B027E_4D3D429001F4_var*
begin
//#UC START# *4C3C927B027E_4D3D429001F4_impl*
 if f_StartPoint then
  Result := l3Point(aMap.Bounds.Left + 3 * evEpsilon, aMap.Bounds.Top + 3 * evEpsilon)
 else
  Result := l3Point(aMap.Bounds.Right - 3 * evEpsilon, aMap.Bounds.Top + 2 * evEpsilon)
//#UC END# *4C3C927B027E_4D3D429001F4_impl*
end;//TMouseMoveCellsSelectTest.GetPoint

function TMouseMoveCellsSelectTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TMouseMoveCellsSelectTest.GetFolder

function TMouseMoveCellsSelectTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D3D429001F4';
end;//TMouseMoveCellsSelectTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
