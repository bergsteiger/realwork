unit d_DeliveryProvile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RBtnDlg, ComCtrls, StdCtrls, Buttons, ExtCtrls, TabRBtnDlg;

type
  TDeliveryProvileDlg = class(TRBtnDlg)
    edSourceFolder: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    edTargetFolder: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
   function Execute : Boolean; override;
   function SourceFolder: String;
   function TargetFolder: String;
  end;

var
  DeliveryProvileDlg: TDeliveryProvileDlg;

implementation

{$R *.dfm}

uses
 l3IniFile,
 ArchiUserRequestManager;

{ TDeliveryProvileDlg }

function TDeliveryProvileDlg.Execute: Boolean;
begin
 UserConfig.Section := 'Export';
 edTargetFolder.Text := UserConfig.ReadParamStrDef ('ExpDir','');
 Result := inherited Execute;
end;

function TDeliveryProvileDlg.SourceFolder: String;
begin
 Result := edSourceFolder.Text;
end;

function TDeliveryProvileDlg.TargetFolder: String;
begin
 Result := edTargetFolder.Text;
end;

end.
