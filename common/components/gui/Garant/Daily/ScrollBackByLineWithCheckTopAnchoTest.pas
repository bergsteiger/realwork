unit ScrollBackByLineWithCheckTopAnchoTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// ������: "w:/common/components/gui/Garant/Daily/ScrollBackByLineWithCheckTopAnchoTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TScrollBackByLineWithCheckTopAnchoTest
//
// ���� ��������� ��������� ����� � ��������� TopAnchor
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  nevTools,
  ScrollBackByLineTest
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TScrollBackByLineWithCheckTopAnchoTest = {abstract} class(TScrollBackByLineTest)
  {* ���� ��������� ��������� ����� � ��������� TopAnchor }
 private
 // private fields
   f_PrevTopAnchor : InevBasePoint;
 protected
 // overridden protected methods
   procedure Cleanup; override;
   procedure CheckTopAnchor(const aView: InevInputView); override;
     {* ��������� ����� ������ ��������� ����� ��������� ��������� }
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TScrollBackByLineWithCheckTopAnchoTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TScrollBackByLineWithCheckTopAnchoTest

procedure TScrollBackByLineWithCheckTopAnchoTest.Cleanup;
//#UC START# *4B2F40FD0088_4C46BB2A02BD_var*
//#UC END# *4B2F40FD0088_4C46BB2A02BD_var*
begin
//#UC START# *4B2F40FD0088_4C46BB2A02BD_impl*
 f_PrevTopAnchor := nil;
 inherited;
//#UC END# *4B2F40FD0088_4C46BB2A02BD_impl*
end;//TScrollBackByLineWithCheckTopAnchoTest.Cleanup

procedure TScrollBackByLineWithCheckTopAnchoTest.CheckTopAnchor(const aView: InevInputView);
//#UC START# *4C1F0A260192_4C46BB2A02BD_var*
//#UC END# *4C1F0A260192_4C46BB2A02BD_var*
begin
//#UC START# *4C1F0A260192_4C46BB2A02BD_impl*
 if f_PrevTopAnchor = nil then
 begin
  f_PrevTopAnchor := aView.TopAnchor.ClonePoint(aView);
  Exit;
 end; // if f_PrevTopAnchor then
 CheckFalse(aView.TopAnchor.Diff(aView, f_PrevTopAnchor, aView.RootFormatInfo) = 0, '������������ ��������� TopAnchor!');
 f_PrevTopAnchor := aView.TopAnchor.ClonePoint(aView)
//#UC END# *4C1F0A260192_4C46BB2A02BD_impl*
end;//TScrollBackByLineWithCheckTopAnchoTest.CheckTopAnchor

function TScrollBackByLineWithCheckTopAnchoTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TScrollBackByLineWithCheckTopAnchoTest.GetFolder

function TScrollBackByLineWithCheckTopAnchoTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C46BB2A02BD';
end;//TScrollBackByLineWithCheckTopAnchoTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.