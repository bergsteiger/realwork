{**************************************************************************************************}
{  WARNING:  JEDI preprocessor generated unit.  Do not edit.                                       }
{**************************************************************************************************}

{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL) extension                                                        }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JediInstallerMain.pas.                                                      }
{                                                                                                  }
{ The Initial Developer of the Original Code is Petr Vones. Portions created by Petr Vones are     }
{ Copyright (C) of Petr Vones. All Rights Reserved.                                                }
{                                                                                                  }
{ Contributor(s): Robert Rossmair (crossplatform & BCB support, refactoring)                       }
{                                                                                                  }
{**************************************************************************************************}

// $Id: JediInstallerMain.pas,v 1.1 2004/04/07 09:30:25 law Exp $

unit JediInstallerMain;

{$I jcl.inc}

interface

uses
  
  Windows, Messages,
  
  SysUtils, Classes,
  
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Menus, Buttons, ComCtrls, ImgList,
  ProductFrames, JediInstallIntf,
  
  JclBorlandTools;

const
  
  UM_CHECKUPDATES = WM_USER + $100;
  

type
  TMainForm = class(TForm, IJediInstallTool)
    InstallBtn: TBitBtn;
    QuitBtn: TBitBtn;
    JediImage: TImage;
    TitlePanel: TPanel;
    Title: TLabel;
    ProductsPageControl: TPageControl;
    StatusBevel: TBevel;
    StatusLabel: TLabel;
    Bevel1: TBevel;
    ProgressBar: TProgressBar;
    ImageList: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QuitBtnClick(Sender: TObject);
    procedure InstallBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure JediImageClick(Sender: TObject);
    procedure TreeViewCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeViewEnter(Sender: TObject);
    procedure TreeViewExit(Sender: TObject);
    procedure BplPathEditChange(Sender: TObject);
  private
    FBorRADToolInstallations: TJclBorRADToolInstallations;
    FJediInstall: IJediInstall;
    FInstallLog: TFileStream;
    FSystemPaths: TStringList;
    function ActiveView: TProductFrame;
    function CheckUpdatePack(Installation: TJclBorRADToolInstallation): Boolean;
    function CreateView(Installation: TJclBorRADToolInstallation): Boolean;
    function InfoFile(Node: TTreeNode): string;
    procedure InstallationStarted(Installation: TJclBorRADToolInstallation);
    procedure InstallationFinished(Installation: TJclBorRADToolInstallation);
    procedure InstallationProgress(Percent: Cardinal);
    procedure ReadSystemPaths;
    function View(Installation: TJclBorRADToolInstallation): TProductFrame; overload;
    function View(RADToolKind: TJclBorRADToolKind; Version: Integer): TProductFrame; overload;
    
    procedure UMCheckUpdates(var Message: TMessage); message UM_CHECKUPDATES;
    
    procedure UpdateFeatureInfo(Node: TTreeNode);
  protected
    
  public
    function CheckRunningInstances: Boolean;
    procedure Install;
    function PopulateTreeViews: Boolean;
    function SystemPathValid(const Path: string): Boolean;
    procedure UpdateButtons;
    // IJediInstallTool
    function BPLPath(Installation: TJclBorRADToolInstallation): string;
    function DCPPath(Installation: TJclBorRADToolInstallation): string;
    function FeatureChecked(FeatureID: Cardinal; Installation: TJclBorRADToolInstallation): Boolean;
    function GetBorRADToolInstallations: TJclBorRADToolInstallations;
    function MessageBox(const Text: string; DlgType: TMsgDlgType = mtInformation;
      Buttons: TMsgDlgButtons = [mbOK]): Integer;
    procedure UpdateInfo(Installation: TJclBorRADToolInstallation; const InfoText: String);
    procedure UpdateStatus(const Text: string);
    procedure WriteInstallLog(const Text: string);
    property BorRADToolInstallations: TJclBorRADToolInstallations read FBorRADToolInstallations;
  end;

var
  MainForm: TMainForm;

implementation


{$R *.dfm}


uses
  
  
  FileCtrl,
  JclDebug, JclShell,
  
  {$IFDEF JCLINSTALL}
  JclInstall,
  {$ENDIF JCLINSTALL}
  {$IFDEF JEDIINSTALL}
  JediPackInstall,
  {$ENDIF JEDIINSTALL}
  JclBase, JclFileUtils, JclStrings, JclSysInfo, JclSysUtils;

const
  {$IFNDEF COMPILER6_UP}
  PathSep = ';';
  {$ENDIF COMPILER6_UP}
  
  SupportURLs: array[TJclBorRADToolKind] of string = (
                'http://www.borland.com/devsupport/delphi/',
                'http://www.borland.com/devsupport/bcppbuilder/');
  
  
  DelphiJediURL     = 'http://delphi-jedi.org';
  VersionSignature  = 'D%d';
  BCBTag            = $10000;
  VersionMask       = $FFFF;

resourcestring
  RsCantFindFiles   = 'Can not find installation files, check your installation.';
  RsCloseRADTool    = 'Please close all running instances of Delphi/C++Builder IDE before the installation.';
  RsConfirmInstall  = 'Are you sure to install all selected features?';
  RsInstallSuccess  = 'Installation finished';
  RsNoInstall       = 'There is no Delphi/C++Builder installation on this machine. Installer will close.';
  RsUpdateNeeded    = 'You should install latest Update Pack #%d for %s.'#13#10 +
                      'Would you like to open Borland support web page?';

function Collapsable(Node: TTreeNode): Boolean;
begin
  Result := (Cardinal(Node.Data) and FID_Expandable) <> 0;
end;

function FeatureID(Node: TTreeNode): Cardinal;
begin
  Result := Cardinal(Node.Data) and FID_NumberMask;
end;

{ TMainForm }

function TMainForm.ActiveView: TProductFrame;
var
  Page: TTabSheet;
begin
  Page := ProductsPageControl.ActivePage;
  Result := Page.Controls[0] as TProductFrame;
end;

function TMainForm.InfoFile(Node: TTreeNode): string;
begin
  Result := FJediInstall.FeatureInfoFileName(FeatureID(Node));
end;

function TMainForm.CreateView(Installation: TJclBorRADToolInstallation): Boolean;
var
  Page: TTabSheet;
  ProductFrame: TProductFrame;
begin
  Result := True;
  if FJediInstall.Supports(Installation) then
  begin
    Page := TTabSheet.Create(Self);
    with Installation do
    begin
      Page.Name := Format('%s%dPage', [Prefixes[RADToolKind], VersionNumber]);
      Page.Caption := Name;
    end;
    Page.PageControl := ProductsPageControl;
    ProductFrame := TProductFrame.Create(Self);
    ProductFrame.Installation := Installation;
    ProductFrame.TreeView.Images := ImageList;
    ProductFrame.TreeView.OnChanging := TreeViewChanging;
    ProductFrame.TreeView.OnChange := TreeViewChange;
    ProductFrame.TreeView.OnCollapsing := TreeViewCollapsing;
    ProductFrame.TreeView.OnEnter := TreeViewEnter;
    ProductFrame.TreeView.OnExit := TreeViewExit;
    ProductFrame.Align := alClient;
    ProductFrame.Parent := Page;
  end;
end;

function TMainForm.CheckRunningInstances: Boolean;
begin
  Result := FBorRADToolInstallations.AnyInstanceRunning;
  if Result then
    MessageBox(RsCloseRADTool, mtWarning);
end;

function TMainForm.CheckUpdatePack(Installation: TJclBorRADToolInstallation): Boolean;
var
  Msg: string;
begin
  Result := True;
  with Installation do
    if UpdateNeeded then
    begin
      Msg := Format(RsUpdateNeeded, [LatestUpdatePack, Name]);
      if MessageBox(Msg, mtWarning, [mbYes, mbNo]) = mrYes then
      
        ShellExecEx(SupportURLs[RadToolKind]);
      
      
    end;
end;

procedure TMainForm.Install;
var
  Res: Boolean;
  LogFileName: string;
begin
  ProgressBar.Position := 0;
  ProgressBar.Visible := True;
  Screen.Cursor := crHourGlass;
  try
    LogFileName := ChangeFileExt(Application.ExeName, '.log');
    FInstallLog := TFileStream.Create(LogFileName, fmCreate);
    try
      Res := FJediInstall.Install;
    finally
      FreeAndNil(FInstallLog);
    end;
    Screen.Cursor := crDefault;
    if Res then
      MessageBox(RsInstallSuccess)
    else
      
      
      ShellExecEx(LogFileName);
      
  finally
    ProgressBar.Visible := False;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainForm.InstallationProgress(Percent: Cardinal);
begin
  ProgressBar.Position := Percent;
end;

function TMainForm.View(RADToolKind: TJclBorRADToolKind; Version: Integer): TProductFrame;
begin
  Result := FindComponent(Format('%s%dProduct', [Prefixes[RADToolKind], Version])) as TProductFrame;
end;

function TMainForm.View(Installation: TJclBorRADToolInstallation): TProductFrame;
begin
  with Installation do
    Result := View(RADToolKind, VersionNumber);
end;

function TMainForm.PopulateTreeViews: Boolean;
var
  I: Integer;
  Page, ActivePage: TTabSheet;
  TreeView: TTreeView;
  ProductFrame: TProductFrame;
begin
  Result := False;
  ActivePage := nil;
  for I := 0 to ProductsPageControl.PageCount - 1 do
  begin
    Page := ProductsPageControl.Pages[I];
    ProductFrame := Page.Controls[0] as TProductFrame;
    TreeView := ProductFrame.TreeView;
    if FJediInstall.PopulateTreeView(ProductFrame.Installation, TreeView.Items) then
    begin
      Result := True;
      ActivePage := Page;
    end
    else
      Page.TabVisible := False;
  end;
  ProductsPageControl.ActivePage := ActivePage;
end;

procedure TMainForm.ReadSystemPaths;
var
  PathVar: string;
  I: Integer;
begin
  if GetEnvironmentVar('PATH', PathVar, False) then
  begin
    StrToStrings(PathVar, PathSep, FSystemPaths, False);
    for I := 0 to FSystemPaths.Count - 1 do
    begin
      PathVar := StrTrimQuotes(FSystemPaths[I]);
      ExpandEnvironmentVar(PathVar);
      
      PathVar := AnsiUpperCase(PathRemoveSeparator(PathGetLongName2(PathVar)));
      
      FSystemPaths[I] := PathVar;
    end;
    FSystemPaths.Sorted := True;
  end;
end;

function TMainForm.SystemPathValid(const Path: string): Boolean;
begin
  Result := FSystemPaths.IndexOf(AnsiUpperCase(Path)) <> -1;
end;

procedure TMainForm.UpdateButtons;
begin
end;

procedure TMainForm.UpdateInfo(Installation: TJclBorRADToolInstallation; const InfoText: String);
var
  P: TProductFrame;
begin
  P := View(Installation);
  if Assigned(P) then
  begin
    P.InfoDisplay.Text := InfoText;
  end;
end;

procedure TMainForm.UpdateStatus(const Text: string);
begin
  if Text = '' then
  begin
    StatusBevel.Visible := False;
    StatusLabel.Visible := False;
  end
  else
  begin
    StatusLabel.Caption := Text;
    StatusBevel.Visible := True;
    StatusLabel.Visible := True;
  end;
  Application.ProcessMessages;  //Update;
end;

procedure TMainForm.WriteInstallLog(const Text: string);
var
  TextLine: string;
begin
  TextLine := Text + AnsiLineBreak;
  FInstallLog.WriteBuffer(Pointer(TextLine)^, Length(TextLine));
end;

function TMainForm.BPLPath(Installation: TJclBorRADToolInstallation): string;
var
  Path: string;
begin
  with Installation do
    Path := View(Installation).BplPathEdit.Text;
  Result := PathRemoveSeparator(Installation.SubstitutePath(Path));
end;

function TMainForm.DCPPath(Installation: TJclBorRADToolInstallation): string;
var
  Path: string;
begin
  with Installation do
    Path := View(Installation).DcpPathEdit.Text;
  Result := PathRemoveSeparator(Installation.SubstitutePath(Path));
end;

procedure TMainForm.BplPathEditChange(Sender: TObject);
begin
  with (Sender as TEdit) do
    if SystemPathValid(Text) then
      Font.Color := clWindowText
    else
      Font.Color := clRed;
end;

function TMainForm.FeatureChecked(FeatureID: Cardinal; Installation: TJclBorRADToolInstallation): Boolean;
begin
  Result := View(Installation).FeatureChecked(FeatureID);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FBorRADToolInstallations := TJclBorRADToolInstallations.Create;
  FSystemPaths := TStringList.Create;
  JediImage.Hint := DelphiJediURL;
  FJediInstall := CreateJediInstall;
  FJediInstall.SetOnProgress(InstallationProgress);
  FJediInstall.SetOnStarting(InstallationStarted);
  FJediInstall.SetOnEnding(InstallationFinished);
  FBorRADToolInstallations.Iterate(CreateView);
  FJediInstall.SetTool(Self);
  UpdateStatus('');
  if not FJediInstall.InitInformation(Application.ExeName) then
  begin
    MessageBox(RsCantFindFiles, mtError);
    Application.ShowMainForm := False;
    Application.Terminate;
  end
  else
  if not PopulateTreeViews then
  begin
    MessageBox(RsNoInstall);
    Application.ShowMainForm := False;
    Application.Terminate;
  end;
  ReadSystemPaths;
  
  TitlePanel.DoubleBuffered := True;
  
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FBorRADToolInstallations);
  FreeAndNil(FSystemPaths);
end;


procedure TMainForm.UMCheckUpdates(var Message: TMessage);
begin
  BorRADToolInstallations.Iterate(CheckUpdatePack);
  Message.Result := 0;
end;

procedure TMainForm.QuitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.InstallBtnClick(Sender: TObject);
begin
  if ( IsDebuggerAttached or  not CheckRunningInstances) and
    (MessageBox(RsConfirmInstall, mtConfirmation, [mbYes, mbNo]) = mrYes) then
  begin
    Install;
    QuitBtn.SetFocus;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  
  PostMessage(Handle, UM_CHECKUPDATES, 0, 0);
  
end;

procedure TMainForm.JediImageClick(Sender: TObject);
begin
  { TODO : implement for Unix }
  
  ShellExecEx(DelphiJediURL);
  
end;

procedure TMainForm.TreeViewCollapsing(Sender: TObject; Node: TTreeNode;
  var AllowCollapse: Boolean);
begin
  AllowCollapse := Collapsable(Node);
end;

function TMainForm.GetBorRADToolInstallations: TJclBorRADToolInstallations;
begin
  Result := FBorRADToolInstallations;
end;

procedure TMainForm.InstallationStarted(Installation: TJclBorRADToolInstallation);
begin
end;

procedure TMainForm.InstallationFinished(Installation: TJclBorRADToolInstallation);
begin
end;

function TMainForm.MessageBox(const Text: string; DlgType: TMsgDlgType = mtInformation;
  Buttons: TMsgDlgButtons = [mbOK]): Integer;
begin
  Result := MessageDlg(Text, DlgType, Buttons, 0);
end;

procedure TMainForm.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  UpdateFeatureInfo(Node);
  FJediInstall.SelectedNodeChanged(Node);
end;

procedure TMainForm.TreeViewChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
begin
  
  with ActiveView do
    if InfoDisplay.Modified then
    begin
      InfoDisplay.Lines.SaveToFile(InfoFile(TreeView.Selected));
      InfoDisplay.Modified := False;
    end;
  
  //FJediInstall.SelectedNodeChanging(Node);
end;

procedure TMainForm.TreeViewEnter(Sender: TObject);
begin
  with ActiveView  do
    if InfoDisplay.ReadOnly then
      UpdateFeatureInfo(TreeView.Selected);
end;

procedure TMainForm.TreeViewExit(Sender: TObject);
begin
  with ActiveView.InfoDisplay do
  begin
    
    if ReadOnly then
      Lines.LoadFromFile(FJediInstall.ReadmeFileName);
    
  end;
end;

procedure TMainForm.UpdateFeatureInfo(Node: TTreeNode);
const
  SFileNotFound = '%s: File not found';
var
  FileName: string;
begin
  with ActiveView do
  begin
    if Assigned(Node) then
      FileName := InfoFile(Node);
    
    if FileExists(FileName) then
    begin
      InfoDisplay.Font.Color := clBlack;
      InfoDisplay.Lines.LoadFromFile(FileName)
    end
    else
    begin
      InfoDisplay.Lines.Clear;
      InfoDisplay.Font.Color := clRed;
      InfoDisplay.Lines.Add(Format(SFileNotFound, [FileName]));
      InfoDisplay.Modified := False;
    end;
    
  end;
end;

end.
