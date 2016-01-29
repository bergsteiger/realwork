unit ComplexScrollByLines;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// ������: "w:/common/components/gui/Garant/Daily/ComplexScrollByLines.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::ComplexScrollByLines
//
// ���� ���� - ���������� �� ��������� ����� ����, � ����� �� ��������� �����.
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
  TextEditorVisitor,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TComplexScrollByLines = {abstract} class(TTextEditorVisitor)
  {* ���� ���� - ���������� �� ��������� ����� ����, � ����� �� ��������� �����. }
 protected
 // realized methods
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* ���������� ����� }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 protected
 // protected methods
   function GetScrollLineCount2Down: Integer; virtual; abstract;
     {* ���������� ����� ��� ��������� ���� }
   function GetScrollLineCount2Up: Integer; virtual; abstract;
     {* ���������� ����� ��� ��������� ����� }
 end;//TComplexScrollByLines
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

// start class TComplexScrollByLines

procedure TComplexScrollByLines.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4C1B135F02B0_var*
//#UC END# *4BE419AF0217_4C1B135F02B0_var*
begin
//#UC START# *4BE419AF0217_4C1B135F02B0_impl*
 ScrollByLine(aForm, GetScrollLineCount2Down, False, False);
 ScrollByLine(aForm, GetScrollLineCount2Up, True, False);
 CheckTopAnchor(aForm.Text.View);
//#UC END# *4BE419AF0217_4C1B135F02B0_impl*
end;//TComplexScrollByLines.DoVisit

function TComplexScrollByLines.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TComplexScrollByLines.GetFolder

function TComplexScrollByLines.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C1B135F02B0';
end;//TComplexScrollByLines.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.