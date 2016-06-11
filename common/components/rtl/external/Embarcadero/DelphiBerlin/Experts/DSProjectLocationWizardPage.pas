{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSProjectLocationWizardPage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WizardAPI, ActnList, StdActns, StdCtrls, ExpertsUIWizard,
  System.Actions;

type
  TDSProjectLocationWizardFrame = class(TFrame, IExpertsWizardPageFrame)
    Label1: TLabel;
    LocationEdit: TEdit;
    BrowseBtn: TButton;
    ActionList1: TActionList;
    BrowseForFolder1: TBrowseForFolder;
    procedure BrowseForFolder1Accept(Sender: TObject);
    procedure BrowseForFolder1BeforeExecute(Sender: TObject);
  private
    FPage: TCustomExpertsFrameWizardPage;
    procedure LocationEditChange(Sender: TObject);
    function LocationEditText: string;
    function GetLeftMargin: Integer;
    procedure SetLeftMargin(const Value: Integer);
    function ValidateFields: Boolean;
    function GetProjectLocation: string;
  protected
    { IExpertsWizardPageFrame }
    function ExpertsFrameValidatePage(ASender: TCustomExpertsWizardPage; var AHandled: Boolean): Boolean;
    procedure ExpertsFrameUpdateInfo(ASender: TCustomExpertsWizardPage; var AHandled: Boolean);
    procedure ExpertsFrameCreated(APage: TCustomExpertsFrameWizardPage);
    procedure ExpertsFrameEnterPage(APage: TCustomExpertsFrameWizardPage);
    { Private declarations }
    property LeftMargin: Integer read GetLeftMargin write SetLeftMargin;
  public
    { Public declarations }
    property ProjectLocation: string read GetProjectLocation;
  end;

implementation

{$R *.dfm}

uses DSCreators, DSServerDsnResStrs, ToolsAPI, System.UITypes;


function SlashSep(const Path, S: string): string;
begin
  if Path <> '' then
    Result := IncludeTrailingPathDelimiter(Path) + S
  else
    Result := S;
end;

procedure TDSProjectLocationWizardFrame.BrowseForFolder1Accept(Sender: TObject);
begin
  LocationEdit.Text := BrowseForFolder1.Folder;
  LocationEditChange(nil);
end;

procedure TDSProjectLocationWizardFrame.LocationEditChange(Sender: TObject);
//var
//  F: TSearchRec;
//  Dir: string;
//  SaveOnChange: TNotifyEvent;
begin
//  if LocationEdit.Canvas.TextWidth(LocationEditText) > LocationEdit.ClientWidth then
//    LocationEdit.Hint := LocationEditText
//  else
//    LocationEdit.Hint := '';
//  SaveOnChange := LocationEdit.OnChange;
//  LocationEdit.OnChange := nil;
//  try
//    if LocationEdit.Focused then
//    begin
//      if (Length(LocationEditText) > 0) and
//         (AnsiCompareText(LocationEditText, FOldValue) = 0) then exit;
//      Dir := IncludeTrailingPathDelimiter(LocationEditText);
//      if DirectoryExists(Dir) and (FindFirst(Dir + '*.*', faDirectory, F) = 0) then  // do not localize
//      begin
//        LocationEdit.ItemsEx.BeginUpdate;
//        try
//          LocationEdit.ItemsEx.Clear;
//          with LocationEdit.ItemsEx.Add do
//            Caption := LocationEditText;
//          repeat
//            if ((F.Attr and faDirectory) = faDirectory) and (F.Name <> '.') and
//               (F.Name <> '..') then
//              with LocationEdit.ItemsEx.Add do
//                Caption :=  SlashSep(LocationEditText, F.Name);
//          until FindNext(F) <> 0;
//          FindClose(F);
//        finally
//          LocationEdit.ItemsEx.EndUpdate;
//        end;
//      end;
//      FOldValue := LocationEditText;
//      LocationEdit.Height := 150;
//    end;
//  finally
//    LocationEdit.OnChange := SaveOnChange;
//  end;
end;

procedure TDSProjectLocationWizardFrame.BrowseForFolder1BeforeExecute(
  Sender: TObject);
var
  LBaseDirectory: string;
begin
  LBaseDirectory := ExtractFilePath(LocationEditText);
  if DirectoryExists(LocationEditText) then
    BrowseForFolder1.Folder := LocationEditText
  else if DirectoryExists(LBaseDirectory) then
    BrowseForFolder1.Folder := LBaseDirectory


//  // This isn't likely to browse to the right location since the project
//  // directory doesn't exist yet.  We should however default this location
//  // to the Borland projects directory or something reasonable...
//  if FileExists(SlashSep(LocationEditText, '*.*')) then  // do not localize
//    BrowseForFolder1.Folder := LocationEditText
//  else
//  begin
//    //BrowsForFolder1.Folder := IDEServices
//    // Try defaulting it to the path minus the AppName path
//    if (Pos(AppNameEdit.Text, LocationEditText) = Length(LocationEditText) - Length(AppNameEdit.Text) + 1) or
//       (Pos(AppNameEdit.Text + '\', LocationEditText) = Length(LocationEditText) - Length(AppNameEdit.Text) + 1) then
//    begin
//      Dir := LocationEditText;
//      Delete(Dir, Pos(AppNameEdit.Text, LocationEditText), MaxInt);
//      BrowseForFolder1.Folder := Dir;
//    end;
//  end;

end;

const
  sProjectDirTemplate = 'Project%d';
function DefaultProjectDirectory: string;
var
  LTemplate: string;
  I: Integer;
begin
  LTemplate := IncludeTrailingPathDelimiter((BorlandIDEServices as IOTAServices).GetStartupDirectory) +
    sProjectDirTemplate;
  I := 1;
  repeat
    Result := Format(LTemplate, [I]);
  Inc(I);
  until not DirectoryExists(Result);
end;

procedure TDSProjectLocationWizardFrame.ExpertsFrameCreated(
  APage: TCustomExpertsFrameWizardPage);
begin
  LocationEdit.Text := DefaultProjectDirectory;
  LeftMargin := ExpertsUIWizard.cExpertsLeftMargin;
  FPage := APage;
  FPage.Title := sLocationPageTitle;
  FPage.Description := sLocationPageDescription;
end;

procedure TDSProjectLocationWizardFrame.ExpertsFrameEnterPage(
  APage: TCustomExpertsFrameWizardPage);
begin

end;

procedure TDSProjectLocationWizardFrame.ExpertsFrameUpdateInfo(
  ASender: TCustomExpertsWizardPage; var AHandled: Boolean);
begin
  AHandled := True;
  ASender.WizardInfo := sLocationPageInfo;
end;

function TDSProjectLocationWizardFrame.ExpertsFrameValidatePage(
  ASender: TCustomExpertsWizardPage; var AHandled: Boolean): Boolean;
begin
  AHandled := True;
  Result := ValidateFields;
end;

function TDSProjectLocationWizardFrame.GetLeftMargin: Integer;
begin
  Result := LocationEdit.Left;
end;

function TDSProjectLocationWizardFrame.GetProjectLocation: string;
begin
  Result := LocationEdit.Text
end;

function TDSProjectLocationWizardFrame.LocationEditText: string;
begin
  Result := LocationEdit.Text;
  SetLength(Result, strlen(PChar(Result)));
end;

procedure TDSProjectLocationWizardFrame.SetLeftMargin(const Value: Integer);
begin
  LocationEdit.Width := LocationEdit.Width - (Value - LocationEdit.Left);
  LocationEdit.Left := Value;
  Label1.Left := Value;
end;

function DirContainsRESTProject(Path: string): Boolean;
var
  DirInfo: TSearchRec;
begin
  Path := IncludeTrailingPathDelimiter(Path);
  Result := DirectoryExists(Path) and
    ((FindFirst(Path + 'js\*.js', faAnyFile, DirInfo) = 0)or   { do not localize }
    (FindFirst(Path + 'cs\*.css', faAnyFile, DirInfo) = 0) or     { do not localize }
    (FindFirst(Path + 'template\*.html', FaAnyfile, DirInfo) = 0) );        { do not localize }
end;

function TDSProjectLocationWizardFrame.ValidateFields: Boolean;
var
  LPath: string;
begin
  Result := True;
  try
    LPath := Trim(Self.LocationEdit.Text);
    if LPath = '' then
      raise Exception.Create(sSpecifyDirectory);
    if DirContainsRESTProject(LPath) then
      raise Exception.CreateFmt(sDirectoryContainsAProject, [LPath]);
  except
    on E: Exception do
    begin
      Self.LocationEdit.SetFocus;
      MessageDlg(E.Message, mtError, [mbOK], 0);
      Result := False;
    end;
  end;
end;

end.

