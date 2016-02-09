unit ScrollByLineBackAndSelectPt;

// ������: "w:\common\components\rtl\Garant\Daily\ScrollByLineBackAndSelectPt.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollAndSelectPtTest
 , nevTools
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TScrollByLineBackAndSelectPt = {abstract} class(TScrollAndSelectPtTest)
  private
   f_PrevAnchor: InevBasePoint;
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* ���������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure CheckAfterScroll(const aView: InevInputView); override;
    {* �������� ����� ��������� }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   function NeedScrollUp: Boolean; override;
   function NeedScrollByLine: Boolean; override;
 end;//TScrollByLineBackAndSelectPt
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
procedure TScrollByLineBackAndSelectPt.DoVisit(aForm: TPrimTextLoadForm);
 {* ���������� ����� }
//#UC START# *4BE419AF0217_4E44C60E0060_var*
//#UC END# *4BE419AF0217_4E44C60E0060_var*
begin
//#UC START# *4BE419AF0217_4E44C60E0060_impl*
 inherited DoVisit(aForm);
 Check(aForm.Text.View.TopAnchor.Diff(aForm.Text.View, f_PrevAnchor, aForm.Text.View.RootFormatInfo) < 0, '�� ���������� ����� ��� ��������� �������!');
 f_PrevAnchor := nil;
//#UC END# *4BE419AF0217_4E44C60E0060_impl*
end;//TScrollByLineBackAndSelectPt.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

procedure TScrollByLineBackAndSelectPt.CheckAfterScroll(const aView: InevInputView);
 {* �������� ����� ��������� }
//#UC START# *4C3C80AF002D_4E44C60E0060_var*
//#UC END# *4C3C80AF002D_4E44C60E0060_var*
begin
//#UC START# *4C3C80AF002D_4E44C60E0060_impl*
 f_PrevAnchor := aView.TopAnchor.ClonePoint(aView);
//#UC END# *4C3C80AF002D_4E44C60E0060_impl*
end;//TScrollByLineBackAndSelectPt.CheckAfterScroll

function TScrollByLineBackAndSelectPt.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'EditorTests';
end;//TScrollByLineBackAndSelectPt.GetFolder

function TScrollByLineBackAndSelectPt.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E44C60E0060';
end;//TScrollByLineBackAndSelectPt.GetModelElementGUID

function TScrollByLineBackAndSelectPt.NeedScrollUp: Boolean;
//#UC START# *4E44C98700AE_4E44C60E0060_var*
//#UC END# *4E44C98700AE_4E44C60E0060_var*
begin
//#UC START# *4E44C98700AE_4E44C60E0060_impl*
 Result := True;
//#UC END# *4E44C98700AE_4E44C60E0060_impl*
end;//TScrollByLineBackAndSelectPt.NeedScrollUp

function TScrollByLineBackAndSelectPt.NeedScrollByLine: Boolean;
//#UC START# *4E44C9B00324_4E44C60E0060_var*
//#UC END# *4E44C9B00324_4E44C60E0060_var*
begin
//#UC START# *4E44C9B00324_4E44C60E0060_impl*
 Result := True;
//#UC END# *4E44C9B00324_4E44C60E0060_impl*
end;//TScrollByLineBackAndSelectPt.NeedScrollByLine
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
