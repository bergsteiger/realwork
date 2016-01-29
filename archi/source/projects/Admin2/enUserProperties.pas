unit enUserProperties;

{ $Id: enUserProperties.pas,v 1.5 2009/01/29 14:22:48 fireton Exp $}

// $Log: enUserProperties.pas,v $
// Revision 1.5  2009/01/29 14:22:48  fireton
// - пересборка под обновленный VCM
//
// Revision 1.4  2007/05/14 12:29:37  fireton
// - проверка подтверждения пароля пользователя уехала с БО на формы
//
// Revision 1.3  2005/11/28 14:12:49  fireton
// - промежуточный коммит
//
// Revision 1.2  2005/08/23 13:58:29  fireton
// - промежуточный коммит (реализация сохранения + bug fix)
//
// Revision 1.1  2005/08/20 11:05:32  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vcmInterfaces, vcmBase, vcmEntityForm, vcmEntities,
  vcmComponent, vcmBaseEntities, StdCtrls, ExtCtrls, Buttons,

  a2Interfaces, l3InterfacedComponent;

type
  TenUserPropertiesForm = class(TvcmEntityForm)
    Entities : TvcmEntities;
    lblID: TLabel;
    edName: TLabeledEdit;
    edLogin: TLabeledEdit;
    btnPassword: TBitBtn;
    cbIsAdmin: TCheckBox;
    cbIsActive: TCheckBox;
    procedure vcmEntityFormChangedDataSource(aSender: TObject; const aOld,
      aNew: IvcmFormDataSource; const aFromHistory : Boolean);
    procedure btnPasswordClick(Sender: TObject);
    procedure edNameChange(Sender: TObject);
    procedure edLoginChange(Sender: TObject);
    procedure cbIsAdminClick(Sender: TObject);
    procedure cbIsActiveClick(Sender: TObject);
    private
      { Private declarations }
      f_DS         : Ia2dsUserProfile;
    protected
     procedure Cleanup; override;
    public
      { Public declarations }
  end;

implementation
uses
 l3Base,

 a2ChangePasswordDlg;

{$R *.DFM}

procedure TenUserPropertiesForm.Cleanup;
begin
 f_DS := nil;
 inherited;
end;

procedure TenUserPropertiesForm.vcmEntityFormChangedDataSource(aSender: TObject; const aOld,
  aNew: IvcmFormDataSource; const aFromHistory : Boolean);
begin
 if Supports(aNew, Ia2dsUserProfile, f_DS) then
 begin
  lblID.Caption := 'ID: '+IntToStr(f_DS.UserProfile.ID);
  edName.Text := f_DS.UserProfile.Name;
  edLogin.Text := f_DS.UserProfile.Login;
  cbIsAdmin.Checked := f_DS.UserProfile.IsAdmin;
  cbIsActive.Checked := f_DS.UserProfile.IsActive;
 end
 else
  f_DS := nil;
end;

procedure TenUserPropertiesForm.btnPasswordClick(Sender: TObject);
var
 Dlg: TChangePasswordDlg;
begin
 Dlg := TChangePasswordDlg.Create(Self);
 try
  if Dlg.ShowModal = mrOK then
  begin
   f_DS.UserProfile.SetPassword(Dlg.Password);
  end;
 finally
  l3Free(Dlg);
 end;
end;

procedure TenUserPropertiesForm.edNameChange(Sender: TObject);
begin
 f_DS.UserProfile.Name := Trim(edName.Text);
end;

procedure TenUserPropertiesForm.edLoginChange(Sender: TObject);
begin
 f_DS.UserProfile.Login := UpperCase(Trim(edLogin.Text));
end;

procedure TenUserPropertiesForm.cbIsAdminClick(Sender: TObject);
begin
 f_DS.UserProfile.IsAdmin := cbIsAdmin.Checked;
end;

procedure TenUserPropertiesForm.cbIsActiveClick(Sender: TObject);
begin
 f_DS.UserProfile.IsActive := cbIsActive.Checked;
end;

end.
