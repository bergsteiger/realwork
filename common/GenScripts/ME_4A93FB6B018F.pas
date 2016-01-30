unit PrimEULA_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimEULA_Form.pas"
// ���������: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , vtLabel
 , vtButton
 , eeMemoWithEditOperations
 , l3StringIDEx
;

type
 TPrimEULAForm = class(TvcmEntityForm)
  private
   f_ShellCaptionLabel: TvtLabel;
    {* ���� ��� �������� ShellCaptionLabel }
   f_OkButton: TvtButton;
    {* ���� ��� �������� OkButton }
   f_eeMemoWithEditOperations1: TeeMemoWithEditOperations;
    {* ���� ��� �������� eeMemoWithEditOperations1 }
  private
   procedure OkButtonClick(Sender: TObject);
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* ������������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property ShellCaptionLabel: TvtLabel
    read f_ShellCaptionLabel;
    {* �������� ����������� }
   property OkButton: TvtButton
    read f_OkButton;
    {* �� }
   property eeMemoWithEditOperations1: TeeMemoWithEditOperations
    read f_eeMemoWithEditOperations1;
 end;//TPrimEULAForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ EULA Local Const }
 str_EULAText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EULAText'; rValue : '����������� �������� ����������� ������ ������������ �������������� ����������� ' +
'"������� ������" �������� ������ �� ��������� � �� �������� �������� � ������, ' +
'���������� �� ����� www.garant.ru'#13#10#13#10'��������! ������������ ' +
'���������� ���� ������� �������� ���������� ���������������� ���������� ' +
'��������� � ������������ �� ������.');
  {* '����������� �������� ����������� ������ ������������ �������������� ����������� ' +
'"������� ������" �������� ������ �� ��������� � �� �������� �������� � ������, ' +
'���������� �� ����� www.garant.ru'#13#10#13#10'��������! ������������ ' +
'���������� ���� ������� �������� ���������� ���������������� ���������� ' +
'��������� � ������������ �� ������.' }

procedure TPrimEULAForm.OkButtonClick(Sender: TObject);
//#UC START# *51BAD500014C_4A93FB6B018F_var*
//#UC END# *51BAD500014C_4A93FB6B018F_var*
begin
//#UC START# *51BAD500014C_4A93FB6B018F_impl*
 ModalResult := mrOk;
//#UC END# *51BAD500014C_4A93FB6B018F_impl*
end;//TPrimEULAForm.OkButtonClick

{$If NOT Defined(NoVCM)}
procedure TPrimEULAForm.DoInit(aFromHistory: Boolean);
 {* ������������� �����. ��� ���������� � �������� }
//#UC START# *49803F5503AA_4A93FB6B018F_var*
//#UC END# *49803F5503AA_4A93FB6B018F_var*
begin
//#UC START# *49803F5503AA_4A93FB6B018F_impl*
 inherited;
 Position := poScreenCenter;
//#UC END# *49803F5503AA_4A93FB6B018F_impl*
end;//TPrimEULAForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimEULAForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4A93FB6B018F_var*
//#UC END# *4A8E8F2E0195_4A93FB6B018F_var*
begin
//#UC START# *4A8E8F2E0195_4A93FB6B018F_impl*
 inherited;
 BorderStyle := bsSingle;
 BorderIcons := [biSystemMenu];
 ClientHeight := 250;
 ClientWidth := 386;

 with ShellCaptionLabel do
 begin
  Left := 10;
  Top := 8;
  Caption := '�������� �����������';
  Transparent := True;
 end;

 with OkButton do
 begin
  Left := 161;
  Top := 216;
  Width := 75;
  Height := 25;
  Cancel := True;
  Caption := '��';
  Default := True;
  OnClick := OkButtonClick;
 end;

 with eeMemoWithEditOperations1 do
 begin
  Left := 12;
  Top := 28;
  Width := 361;
  Height := 175;
  Text := str_EULAText.AsStr;
  TextSource.ReadOnly := True;
  BevelInner := bvLowered;
  BorderStyle := bsSingle;
  ParentColor := True;
  ReadOnly := True;
  TabStop := True;
 end;
//#UC END# *4A8E8F2E0195_4A93FB6B018F_impl*
end;//TPrimEULAForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_EULAText.Init;
 {* ������������� str_EULAText }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimEULAForm);
 {* ����������� PrimEULA }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
