unit imrconsolemain;

interface

uses
  SysUtils, Types, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, orb_int, imr, imr_int, ComCtrls;

type
  TfmMain = class(TForm)
    edIMRLocation: TEdit;
    lIMRLocation: TLabel;
    btConnect: TButton;
    lvImplementationList: TListView;
    procedure btConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure SaveLayout;
    procedure LoadLayout;
    procedure Connect;
    procedure Refresh;
    function GetPOAMediator: IPOAMediator;
    function GetImplementationDef(const AServer: AnsiString): IImplementationDef;
    //admin functions
    procedure IMRList;
    procedure StopServer(const AServer: AnsiString);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  dorb: IORB;

implementation

{$R *.xfm}

uses IniFiles;

var
  imrVar: IImplRepository;

{ TForm1 }

procedure TfmMain.Connect;
var
  obj: IORBObject;
begin
  obj := dorb.corbaloc_to_object(AnsiString(edIMRLocation.Text));
  imrVar := TImplRepository._narrow(obj);
  dorb.register_initial_reference('ImplementationRepository', obj);
end;

procedure TfmMain.btConnectClick(Sender: TObject);
begin
  Connect;
  IMRList;
end;

procedure TfmMain.IMRList;
var
  impls: TImplDefSeq;
  i: integer;
begin
  impls := imrVar.find_all;
  for i := 0 to Length(impls) - 1 do
    lvImplementationList.Items.Add.Caption := String(impls[i].name);
end;

procedure TfmMain.Refresh;
begin
  lvImplementationList.Items.Clear;
  IMRList;
end;

procedure TfmMain.LoadLayout;
begin
  with TIniFile.Create('IMRConsole.config') do begin
    edIMRLocation.Text := ReadString('ORB', 'ImplementationRepository', 'corbaloc::localhost:10000/ImplementationRepository');
  end; { with }
end;

procedure TfmMain.SaveLayout;
begin
  with TIniFile.Create('IMRConsole.config') do begin
    WriteString('ORB', 'ImplementationRepository', edIMRLocation.Text);
  end; { with }
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  LoadLayout;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  SaveLayout;
end;

function TfmMain.GetPOAMediator: IPOAMediator;
begin

end;

procedure TfmMain.StopServer(const AServer: AnsiString);
begin
  if not GetPOAMediator.stop(GetImplementationDef(AServer)) then
    MessageDlg('Cannot stop server ' + String(AServer), mtError, [mbOk], 0);
end;

function TfmMain.GetImplementationDef(
  const AServer: AnsiString): IImplementationDef;
var
  impls: TImplDefSeq;
begin
  impls := imrVar.find_by_name(AServer);
  if Length(impls) = 0 then
    raise Exception.Create('No such server: ' + String(AServer));
end;

end.
