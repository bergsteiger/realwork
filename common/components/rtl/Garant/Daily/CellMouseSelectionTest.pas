unit CellMouseSelectionTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/CellMouseSelectionTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TCellMouseSelectionTest
//
// ��������� ������ � ������� ����.
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
  HotSpotSelectionTest,
  nevTools,
  l3Units
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TCellMouseSelectionTest = {abstract} class(THotSpotSelectionTest)
  {* ��������� ������ � ������� ����. }
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
 end;//TCellMouseSelectionTest
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

// start class TCellMouseSelectionTest

function TCellMouseSelectionTest.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
//#UC START# *4BF4E6A00093_4CED2FCF0081_var*
//#UC END# *4BF4E6A00093_4CED2FCF0081_var*
begin
//#UC START# *4BF4E6A00093_4CED2FCF0081_impl*
 Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[0];
//#UC END# *4BF4E6A00093_4CED2FCF0081_impl*
end;//TCellMouseSelectionTest.GetInnerPara

function TCellMouseSelectionTest.GetPoint(const aMap: InevMap): Tl3Point;
//#UC START# *4C3C927B027E_4CED2FCF0081_var*
//#UC END# *4C3C927B027E_4CED2FCF0081_var*
begin
//#UC START# *4C3C927B027E_4CED2FCF0081_impl*
 Result := l3Point(aMap.Bounds.Left + 3 * evEpsilon, aMap.Outer.Bounds.Bottom - 2 * evEpsilon);
//#UC END# *4C3C927B027E_4CED2FCF0081_impl*
end;//TCellMouseSelectionTest.GetPoint

function TCellMouseSelectionTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TCellMouseSelectionTest.GetFolder

function TCellMouseSelectionTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CED2FCF0081';
end;//TCellMouseSelectionTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.