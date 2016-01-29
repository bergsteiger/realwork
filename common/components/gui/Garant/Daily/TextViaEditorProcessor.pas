unit TextViaEditorProcessor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// ������: "w:/common/components/gui/Garant/Daily/TextViaEditorProcessor.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TTextViaEditorProcessor
//
// ���������� ������ ����� ��������
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
 TTextViaEditorProcessor = {abstract} class(TTextEditorVisitor)
  {* ���������� ������ ����� �������� }
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
   function EtalonFileExtension: AnsiString; virtual;
     {* ���������� ���������� ����� }
   function HeaderBegin: AnsiChar; virtual;
   procedure Process(aForm: TPrimTextLoadForm); virtual; abstract;
     {* ���������� ������� ��������� ������ }
 end;//TTextViaEditorProcessor
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

// start class TTextViaEditorProcessor

function TTextViaEditorProcessor.EtalonFileExtension: AnsiString;
//#UC START# *4D0769150130_4BE111D30229_var*
//#UC END# *4D0769150130_4BE111D30229_var*
begin
//#UC START# *4D0769150130_4BE111D30229_impl*
 Result := 'evd';
//#UC END# *4D0769150130_4BE111D30229_impl*
end;//TTextViaEditorProcessor.EtalonFileExtension

function TTextViaEditorProcessor.HeaderBegin: AnsiChar;
//#UC START# *4D07693F0262_4BE111D30229_var*
//#UC END# *4D07693F0262_4BE111D30229_var*
begin
//#UC START# *4D07693F0262_4BE111D30229_impl*
 Result := '%';
//#UC END# *4D07693F0262_4BE111D30229_impl*
end;//TTextViaEditorProcessor.HeaderBegin

procedure TTextViaEditorProcessor.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4BE111D30229_var*
//#UC END# *4BE419AF0217_4BE111D30229_var*
begin
//#UC START# *4BE419AF0217_4BE111D30229_impl*
 Process(aForm);
 Save(aForm);
 CheckOutputWithInput(KPage + EtalonSuffix + '.' + EtalonFileExtension, HeaderBegin);
//#UC END# *4BE419AF0217_4BE111D30229_impl*
end;//TTextViaEditorProcessor.DoVisit

function TTextViaEditorProcessor.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TTextViaEditorProcessor.GetFolder

function TTextViaEditorProcessor.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BE111D30229';
end;//TTextViaEditorProcessor.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.