unit D_config;

{ $Id: D_config.pas,v 1.35 2016/01/11 11:28:33 lukyanets Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, vtSpin, OvcBase, OvcNbk, Buttons, ExtCtrls,
  BottomBtnDlg, ComCtrls, vtlister, TabBBtnDlg,  Mask, ToolEdit,
  vtCombo, vtDateEdit, afwControl, afwInputControl, afwControlPrim,
  afwBaseControl, ddAppConfig;

type
  TConfigDlg = class(TTabBBtnDlg)
    TabSheet4: TTabSheet;                       
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    cbxAutoSave: TCheckBox;
    edtAutoSaveInterval: TvtSpinEdit;
    Label1: TLabel;
    lstVisUserAttr: TvtDStringlister;
    chbGarantStyleQuery: TCheckBox;
    edtDocOnDiskDir: TDirectoryEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cbxShowHRuller: TCheckBox;
    edtNextVersion: TvtDateEdit;
    Label9: TLabel;
    chbSychroNameWSpr: TCheckBox;
    cbxCheckScanImage: TCheckBox;
    cbVDFromServer: TCheckBox;
    TabSheet1: TTabSheet;
    cbOrphoSkipThreeLetterWords: TCheckBox;
    cbOrphoDotIsSeparator: TCheckBox;
    Label4: TLabel;
    edtAnounceDate: TvtDateEdit;
    cbADFromServer: TCheckBox;
    tsTech: TTabSheet;
    edtMsgLevel: TvtSpinEdit;
    Label5: TLabel;
    chbMailNotifyByModalDialog: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure cbVDFromServerClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    f_DataConfig: TddAppConfiguration;
  public
    function Execute: Boolean; override;
  end;

implementation

{$R *.DFM}

uses IniShop,
     l3Base, l3IniFile,
     HelpCnst,
     ncsServiceProviderParamsFactory,
     daDataProviderSuperFactory,
     ddClientBaseEngine,
     ddAppConfigTypes,
     //DictsSup,
     DocAttrUtils,
     Main;

function TConfigDlg.Execute: Boolean;
var
 l_Node: TddBaseConfigItem;
 l_Height: Integer;
 l_Width: Integer;
 begin
  cbxAutoSave.Checked           := IniRec.AutoSave;
  edtAutoSaveInterval.AsInteger := IniRec.AutoSaveInterval;
  chbGarantStyleQuery.Checked   := IniRec.GarantStyleQuery;
  //chbNewDocOnly.Checked         := IniRec.CreateNewDocOnly;
  chbMailNotifyByModalDialog.Checked := IniRec.MailNotifyByModalDialog;

  edtDocOnDiskDir.Text          := IniRec.DocOnDiskDir;
  cbxShowHRuller.Checked        := IniRec.ShowHRuller;
  cbxCheckScanImage.Checked     := IniRec.CheckScanImage;
  chbSychroNameWSpr.Checked     := IniRec.SychroNameWSpr;

  if g_BaseEngine.ServiceParams.StandAlone then
  begin
   cbVDFromServer.Enabled := False;
   cbVDFromServer.Checked := False;
  end
  else
   cbVDFromServer.Checked        := IniRec.NVDFromServer;

  edtNextVersion.Date           := IniRec.NextVersionDate;
  edtAnounceDate.Date           := IniRec.AnouncedDate;
  cbOrphoSkipThreeLetterWords.Checked := IniRec.DontCheckThreeLetterWords;
  cbOrphoDotIsSeparator.Checked := IniRec.OrphoDotIsSeparator;
  if f_DataConfig.HasValue('Common', l_Node) then
  begin
   Assert(l_Node is TddAppConfigNode);
   IddConfigNode(TddAppConfigNode(l_Node)).CreateFrame(TabSHeet6, 0);
   IddConfigNode(TddAppConfigNode(l_Node)).SetControlValues(False);
   IddConfigNode(TddAppConfigNode(l_Node)).FrameSize(TabSHeet6, l_Height, l_Width);
   if l_Height > TabSheet6.Height then
    Height := Height + l_Height - TabSheet6.Height;
   if l_Width > TabSheet6.Width then
    Width := Width + l_Width - TabSheet6.Width;
  end
  else
   Assert(False);

//  edtMainFamilyPath .Text := NormalizedPath(GlobalHTServer.CurTblPath);
//  edtHomeDirPath    .Text := NormalizedPath(GlobalDataProvider.CurHomePath);

  GetUserAttrList(lstVisUserAttr.Items);
  SetHiddenAttr(lstVisUserAttr.Items);
  edtMsgLevel.AsInteger := l3System.MessageLevel;


  Result := ShowModal = mrOK;
  if not Result then Exit;

  GetHiddenAttr(lstVisUserAttr.Items);

  IniRec.AutoSave := cbxAutoSave.Checked;
  IniRec.AutoSaveInterval := edtAutoSaveInterval.AsInteger;
  IniRec.GarantStyleQuery := chbGarantStyleQuery.Checked;
  //IniRec.CreateNewDocOnly := chbNewDocOnly.Checked;
  IniRec.SychroNameWSpr   := chbSychroNameWSpr.Checked;
  IniRec.DocOnDiskDir     := edtDocOnDiskDir.Text;
  IniRec.MailNotifyByModalDialog := chbMailNotifyByModalDialog.Checked;


  if not g_BaseEngine.ServiceParams.StandAlone then
   IniRec.NVDFromServer    := cbVDFromServer.Checked;

  IniRec.NextVersionDate  := edtNextVersion.Date;

  IniRec.ShowHRuller      := cbxShowHRuller.Checked;
  IniRec.CheckScanImage   := cbxCheckScanImage.Checked;

  IniRec.DontCheckThreeLetterWords := cbOrphoSkipThreeLetterWords.Checked;
  IniRec.OrphoDotIsSeparator := cbOrphoDotIsSeparator.Checked;

  l3System.MessageLevel := edtMsgLevel.AsInteger;
 end;

procedure TConfigDlg.FormCreate(Sender: TObject);
begin
  inherited;
  HelpContext := hcTuning;
  edtNextVersion.RestrictInvalidDate := True;
  f_DataConfig := TddAppConfiguration.Create;
  f_DataConfig.SetReadOnly(True);
  TncsServiceProviderParamsFactory.Instance.BuildConfig(f_DataConfig, TdaDataProviderSuperFactory.Instance.BuildConfig, g_BaseEngine.DataParams.ParamsKey, True);
  TdaDataProviderSuperFactory.Instance.FillInConfig(f_DataConfig, g_BaseEngine.DataParams, True);
  TncsServiceProviderParamsFactory.Instance.FillInConfig(f_DataConfig, g_BaseEngine.ServiceParams, True);
end;

procedure TConfigDlg.cbVDFromServerClick(Sender: TObject);
begin
 edtNextVersion.Enabled := not cbVDFromServer.Checked;
end;

procedure TConfigDlg.FormDestroy(Sender: TObject);
begin
  FreeAndNil(f_DataConfig);
  inherited;
end;

end.
