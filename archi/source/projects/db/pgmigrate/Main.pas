unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, vtSpin, Migrator, Buttons;

type
  TMainForm = class(TForm)
    MigrateBtn: TButton;
    ReportMemo: TMemo;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edLogin: TEdit;
    Label2: TLabel;
    edPassword: TEdit;
    Label3: TLabel;
    edServer: TEdit;
    Label4: TLabel;
    edPort: TvtSpinEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    edFamilyPath: TEdit;
    btnSelectDir: TSpeedButton;
    Label6: TLabel;
    edStoredProcPath: TEdit;
    SpeedButton1: TSpeedButton;
    procedure MigrateBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSelectDirClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    f_Migrator: TMigrator;
    procedure DoReportCallBack(const aStr: String; WriteToLog: Boolean);
    procedure SetupMigratorParams;
    procedure ReadBackMigratorParams;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
 FileCtrl,
 l3Base,
 l3IniFile,
 ncsDataAccessServices, daDataProviderParams;

{$R *.dfm}

procedure TMainForm.DoReportCallBack(const aStr: String; WriteToLog: Boolean);
const
 cMap: array [Boolean] of Byte = (10, 0);
begin
 ReportMemo.Lines.Add(aStr);
 l3System.Msg2Log(aStr, cMap[WriteToLog]);
 Application.ProcessMessages;
end;

procedure TMainForm.MigrateBtnClick(Sender: TObject);
begin
 ReportMemo.Lines.Clear;
 SetupMigratorParams;
 f_Migrator.Migrate;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 InitStationAndServerConfig;
 TncsDataAccessServices.Instance.InitClient;
 f_Migrator := TMigrator.Create;
 f_Migrator.ReportCallback := DoReportCallBack;
 ReadBackMigratorParams;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 FreeANdNil(f_Migrator);
end;

procedure TMainForm.SetupMigratorParams;
begin
 f_Migrator.PostrgesParams.Login := edLogin.Text;
 f_Migrator.PostrgesParams.Password := edPassword.Text;
 f_Migrator.PostrgesParams.DataServerHostName := edServer.Text;
 f_Migrator.PostrgesParams.DataServerPort := edPort.AsInteger;
 f_Migrator.PostrgesParams.DocStoragePath := edFamilyPath.Text;
 f_Migrator.StoredProcPath := edStoredProcPath.Text;
end;

procedure TMainForm.ReadBackMigratorParams;
begin
 edLogin.Text := f_Migrator.PostrgesParams.Login;
 edPassword.Text := f_Migrator.PostrgesParams.Password;
 edServer.Text := f_Migrator.PostrgesParams.DataServerHostName;
 edPort.AsInteger := f_Migrator.PostrgesParams.DataServerPort;
 edFamilyPath.Text := f_Migrator.PostrgesParams.DocStoragePath;
 edStoredProcPath.Text := f_Migrator.StoredProcPath;
end;

procedure TMainForm.btnSelectDirClick(Sender: TObject);
var
 l_Dir: String;
begin
 l_Dir := edFamilyPath.Text;
 if SelectDirectory('Database path', '', l_Dir) then
  edFamilyPath.Text := l_Dir;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
var
 l_Dir: String;
begin
 l_Dir := edStoredProcPath.Text;
 if SelectDirectory('Stored proc path', '', l_Dir) then
  edStoredProcPath.Text := l_Dir;
end;

end.
