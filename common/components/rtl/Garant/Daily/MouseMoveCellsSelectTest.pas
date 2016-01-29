unit MouseMoveCellsSelectTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/MouseMoveCellsSelectTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TMouseMoveCellsSelectTest
//
// ���� ��������� � ������� ���� ��������� �����.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  MouseMoveSelectionTest,
  nevTools,
  l3Units
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TMouseMoveCellsSelectTest = {abstract} class(TMouseMoveSelectionTest)
  {* ���� ��������� � ������� ���� ��������� �����. }
 protected
 // overridden protected methods
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
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evConst,
  TestFrameWork,
  l3Base,
  evOp,
  l3InternalInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TMouseMoveCellsSelectTest

function TMouseMoveCellsSelectTest.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
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
 {-}
begin
 Result := 'EditorTests';
end;//TMouseMoveCellsSelectTest.GetFolder

function TMouseMoveCellsSelectTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D3D429001F4';
end;//TMouseMoveCellsSelectTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.