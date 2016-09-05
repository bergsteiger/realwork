unit OldNSRCFlagCnahge;
 {* �������� ���� "�������� � �������������" �� ���� �������� � ���������. }

// ������: "w:\common\components\gui\Garant\Daily\OldNSRCFlagCnahge.pas"
// ���������: "TestCase"
// ������� ������: "TOldNSRCFlagCnahge" MUID: (4C3FEBB500B2)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , ChangeAllTablesTest
 , evCustomEditor
;

type
 TOldNSRCFlagCnahge = {abstract} class(TChangeAllTablesTest)
  {* �������� ���� "�������� � �������������" �� ���� �������� � ���������. }
  protected
   procedure ApplyEditorTool(aEditor: TevCustomEditor); override;
    {* ����� ����������� �� ��������� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TOldNSRCFlagCnahge
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4C3FEBB500B2impl_uses*
 //#UC END# *4C3FEBB500B2impl_uses*
;

procedure TOldNSRCFlagCnahge.ApplyEditorTool(aEditor: TevCustomEditor);
 {* ����� ����������� �� ��������� }
//#UC START# *4C3FF0DB0072_4C3FEBB500B2_var*
//#UC END# *4C3FF0DB0072_4C3FEBB500B2_var*
begin
//#UC START# *4C3FF0DB0072_4C3FEBB500B2_impl*
 aEditor.SetOldNSRCFlag;
//#UC END# *4C3FF0DB0072_4C3FEBB500B2_impl*
end;//TOldNSRCFlagCnahge.ApplyEditorTool

function TOldNSRCFlagCnahge.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TOldNSRCFlagCnahge.GetFolder

function TOldNSRCFlagCnahge.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4C3FEBB500B2';
end;//TOldNSRCFlagCnahge.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
