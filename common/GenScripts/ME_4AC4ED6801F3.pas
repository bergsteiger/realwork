unit PrimGroupProperty_Form;
 {* �������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupProperty_Form.pas"
// ���������: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , AdminInterfaces
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtLabel
;

type
 TPrimGroupPropertyForm = class(TvcmEntityForm)
  {* �������� ������ }
  private
   f_edName: TnscEdit;
    {* ���� ��� �������� edName }
   f_Label1: TvtLabel;
    {* ���� ��� �������� Label1 }
  protected
   f_Data: IbsEditGroupName;
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: IbsEditGroupName): Result; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property edName: TnscEdit
    read f_edName;
   property Label1: TvtLabel
    read f_Label1;
    {* ��� ������ }
 end;//TPrimGroupPropertyForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3String
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ admCreateGroupLocalConstants }
 str_admCreateGroupCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admCreateGroupCaption'; rValue : '����� ������');
  {* ��������� ����������������� ���� "����� ������" }
 {* ������������ ������ admRenameGroupLocalConstants }
 str_admRenameGroupCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admRenameGroupCaption'; rValue : '������������� ������');
  {* ��������� ����������������� ���� "������������� ������" }

class function TPrimGroupPropertyForm.Make(const aData: IbsEditGroupName): Result;
var
 l_Inst : TPrimGroupPropertyForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimGroupPropertyForm.Make

{$If NOT Defined(NoVCM)}
procedure TPrimGroupPropertyForm.Cancel;
 {* ������ }
//#UC START# *4A8AD46D0226_4AC4ED6801F3_var*
//#UC END# *4A8AD46D0226_4AC4ED6801F3_var*
begin
//#UC START# *4A8AD46D0226_4AC4ED6801F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8AD46D0226_4AC4ED6801F3_impl*
end;//TPrimGroupPropertyForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimGroupPropertyForm.Ok;
 {* OK }
//#UC START# *4A97EBE702F8_4AC4ED6801F3_var*
//#UC END# *4A97EBE702F8_4AC4ED6801F3_var*
begin
//#UC START# *4A97EBE702F8_4AC4ED6801F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4AC4ED6801F3_impl*
end;//TPrimGroupPropertyForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimGroupPropertyForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4AC4ED6801F3_var*
//#UC END# *4C762A1501FC_4AC4ED6801F3_var*
begin
//#UC START# *4C762A1501FC_4AC4ED6801F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4AC4ED6801F3_impl*
end;//TPrimGroupPropertyForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimGroupPropertyForm.Cancel;
 {* ������ }
//#UC START# *4C762AB601E1_4AC4ED6801F3_var*
//#UC END# *4C762AB601E1_4AC4ED6801F3_var*
begin
//#UC START# *4C762AB601E1_4AC4ED6801F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4AC4ED6801F3_impl*
end;//TPrimGroupPropertyForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimGroupPropertyForm.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4AC4ED6801F3_var*
//#UC END# *479731C50290_4AC4ED6801F3_var*
begin
//#UC START# *479731C50290_4AC4ED6801F3_impl*
 f_Data := nil;
 inherited;
//#UC END# *479731C50290_4AC4ED6801F3_impl*
end;//TPrimGroupPropertyForm.Cleanup

{$If NOT Defined(NoVCM)}
procedure TPrimGroupPropertyForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4AC4ED6801F3_var*
//#UC END# *4A8E8F2E0195_4AC4ED6801F3_var*
begin
//#UC START# *4A8E8F2E0195_4AC4ED6801F3_impl*
 BorderIcons := [biSystemMenu];
 BorderStyle := bsDialog;
 ClientHeight := 39;
 ClientWidth := 279;
 ShowHint := True;

 with Label1 do
 begin
  Left := 8;
  Top := 12;
  AutoSize := False;
  Width := 105;
  Height := 16;
 end;

 with edName do
 begin
  Left := 120;
  Top := 8;
  Width := 153;
  Height := 21;
  TabOrder := 0;
  ParentShowHint := False;
  ShowHint := True;
 end;
//#UC END# *4A8E8F2E0195_4AC4ED6801F3_impl*
end;//TPrimGroupPropertyForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_admCreateGroupCaption.Init;
 {* ������������� str_admCreateGroupCaption }
 str_admRenameGroupCaption.Init;
 {* ������������� str_admRenameGroupCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimGroupPropertyForm);
 {* ����������� PrimGroupProperty }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
