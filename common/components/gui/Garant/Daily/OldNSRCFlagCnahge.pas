unit OldNSRCFlagCnahge;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// ������: "w:/common/components/gui/Garant/Daily/OldNSRCFlagCnahge.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TOldNSRCFlagCnahge
//
// �������� ���� "�������� � �������������" �� ���� �������� � ���������.
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
  ChangeAllTablesTest,
  evCustomEditor
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TOldNSRCFlagCnahge = {abstract} class(TChangeAllTablesTest)
  {* �������� ���� "�������� � �������������" �� ���� �������� � ���������. }
 protected
 // realized methods
   procedure ApplyEditorTool(aEditor: TevCustomEditor); override;
     {* ����� ����������� �� ��������� }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TOldNSRCFlagCnahge
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

// start class TOldNSRCFlagCnahge

procedure TOldNSRCFlagCnahge.ApplyEditorTool(aEditor: TevCustomEditor);
//#UC START# *4C3FF0DB0072_4C3FEBB500B2_var*
//#UC END# *4C3FF0DB0072_4C3FEBB500B2_var*
begin
//#UC START# *4C3FF0DB0072_4C3FEBB500B2_impl*
 aEditor.SetOldNSRCFlag;
//#UC END# *4C3FF0DB0072_4C3FEBB500B2_impl*
end;//TOldNSRCFlagCnahge.ApplyEditorTool

function TOldNSRCFlagCnahge.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TOldNSRCFlagCnahge.GetFolder

function TOldNSRCFlagCnahge.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3FEBB500B2';
end;//TOldNSRCFlagCnahge.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.