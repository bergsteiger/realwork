unit frmFolderProp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ElBtnCtl, ElPopBtn, ElFrmPers, ElXPThemedControl,
  ExtCtrls, ElPanel, ElEdits;

type                 
  TFolderPropsForm = class(TForm)
    FormPers: TElFormPersist;
    ElPanel1: TElPanel;
    Label1: TLabel;
    SiteNameEdit: TElEdit;
    CancelBtn: TElPopupButton;
    OKBtn: TElPopupButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FolderPropsForm: TFolderPropsForm;

implementation

{$R *.DFM}

end.
