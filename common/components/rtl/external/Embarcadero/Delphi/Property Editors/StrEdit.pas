{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{       TStrings property editor dialog                 }
{*******************************************************}

unit StrEdit;

interface

uses Winapi.Windows, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls, Vcl.Buttons, Vcl.Dialogs, DesignEditors,
  DesignIntf, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus, Vcl.ActnPopup, System.WideStrings,
  Vcl.PlatformDefaultStyleActnCtrls;

type
  TStrEditDlg = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    StringEditorMenu: TPopupActionBar;
    LoadItem: TMenuItem;
    SaveItem: TMenuItem;
    CodeEditorItem: TMenuItem;
    CodeWndBtn: TButton;
    OKButton: TButton;
    CancelButton: TButton;
    HelpButton: TButton;
    procedure FileOpen(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure CodeWndBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  protected
    FModified: Boolean;
    function GetLines: TStrings; virtual; abstract;
    procedure SetLines(const Value: TStrings); virtual; abstract;
    function GetLinesControl: TWinControl; virtual; abstract;
  public
    property Lines: TStrings read GetLines write SetLines;
  end;

  TStringListProperty = class(TClassProperty)
  protected
    function EditDialog: TStrEditDlg; virtual;
    function GetStrings: TStrings; virtual;
    procedure SetStrings(const Value: TStrings); virtual;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TValueListProperty = class(TStringListProperty)
  protected
    function EditDialog: TStrEditDlg; override;
  end;

  TWideStringListProperty = class(TStringListProperty)
  private
    FStrings: TStrings;
  protected
    function GetStrings: TStrings; override;
    procedure SetStrings(const Value: TStrings); override;
  public
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

uses Winapi.ActiveX, System.SysUtils, DesignConst, ToolsAPI, IStreams,
  StFilSys, System.TypInfo, StringsEdit, ValueEdit;

type
  TStringsModuleCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
  private
    FFileName: string;
    FStream: TStringStream;
    FAge: TDateTime;
  public
    constructor Create(const FileName: string; Stream: TStringStream; Age: TDateTime);
    destructor Destroy; override;
    { IOTACreator }
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    { IOTAModuleCreator }
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  end;

  TOTAFile = class(TInterfacedObject, IOTAFile)
  private
    FSource: string;
    FAge: TDateTime;
  public
    constructor Create(const ASource: string; AAge: TDateTime);
    { IOTAFile }
    function GetSource: string;
    function GetAge: TDateTime;
  end;

{ TOTAFile }

constructor TOTAFile.Create(const ASource: string; AAge: TDateTime);
begin
  inherited Create;
  FSource := ASource;
  FAge := AAge;
end;

function TOTAFile.GetAge: TDateTime;
begin
  Result := FAge;
end;

function TOTAFile.GetSource: string;
begin
  Result := FSource;
end;

{ TStringsModuleCreator }

constructor TStringsModuleCreator.Create(const FileName: string; Stream: TStringStream;
  Age: TDateTime);
begin
  inherited Create;
  FFileName := FileName;
  FStream := Stream;
  FAge := Age;
end;

destructor TStringsModuleCreator.Destroy;
begin
  FStream.Free;
  inherited;
end;

procedure TStringsModuleCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin
  { Nothing to do }
end;

function TStringsModuleCreator.GetAncestorName: string;
begin
  Result := '';
end;

function TStringsModuleCreator.GetCreatorType: string;
begin
  Result := sText;
end;

function TStringsModuleCreator.GetExisting: Boolean;
begin
  Result := True;
end;

function TStringsModuleCreator.GetFileSystem: string;
begin
  Result := sTStringsFileSystem;
end;

function TStringsModuleCreator.GetFormName: string;
begin
  Result := '';
end;

function TStringsModuleCreator.GetImplFileName: string;
begin
  Result := FFileName;
end;

function TStringsModuleCreator.GetIntfFileName: string;
begin
  Result := '';
end;

function TStringsModuleCreator.GetMainForm: Boolean;
begin
  Result := False;
end;

function TStringsModuleCreator.GetOwner: IOTAModule;
begin
  Result := nil;
end;

function TStringsModuleCreator.GetShowForm: Boolean;
begin
  Result := False;
end;

function TStringsModuleCreator.GetShowSource: Boolean;
begin
  Result := True;
end;

function TStringsModuleCreator.GetUnnamed: Boolean;
begin
  Result := False;
end;

function TStringsModuleCreator.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TStringsModuleCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := TOTAFile.Create(FStream.DataString, FAge);
end;

function TStringsModuleCreator.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

{ TStrEditDlg }

procedure TStrEditDlg.FileOpen(Sender: TObject);
begin
  with OpenDialog do
    if Execute then Lines.LoadFromFile(FileName);
end;

procedure TStrEditDlg.FileSave(Sender: TObject);
begin
  SaveDialog.FileName := OpenDialog.FileName;
  with SaveDialog do
    if Execute then Lines.SaveToFile(FileName);
end;

//Temp fix for opening the strings in the editor.
const
  DotSep = '.';



{ TStringListProperty }

function TStringListProperty.EditDialog: TStrEditDlg;
begin
  Result := TStringsEditDlg.Create(Application);
end;

function TStringListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;

function TStringListProperty.GetStrings: TStrings;
begin
  Result := TStrings(GetOrdValue);
end;

procedure TStringListProperty.SetStrings(const Value: TStrings);
begin
  SetOrdValue(Longint(Value));
end;

procedure TStringListProperty.Edit;
var
  Ident: string;
  Component: TComponent;
  Module: IOTAModule;
  Editor: IOTAEditor;
  ModuleServices: IOTAModuleServices;
  Stream: TStringStream;
  Age: TDateTime;
begin
  Component := TComponent(GetComponent(0));
  ModuleServices := BorlandIDEServices as IOTAModuleServices;
  if (TObject(Component) is TComponent) and
    (Component.Owner = Self.Designer.GetRoot) and
    (Self.Designer.GetRoot.Name <> '') then
  begin
    Ident := Self.Designer.GetDesignerExtension + DotSep + Self.Designer.GetRoot.Name + DotSep +
      Component.Name + DotSep + GetName;
    Module := ModuleServices.FindModule(Ident);
  end else Module := nil;
  if (Module <> nil) and (Module.GetModuleFileCount > 0) then
    Module.GetModuleFileEditor(0).Show
  else
  with EditDialog do
  try
    Lines := GetStrings;
//    UpdateStatus(nil);
    FModified := False;
    ActiveControl := GetLinesControl;
    CodeEditorItem.Enabled := Ident <> '';
    CodeWndBtn.Enabled := Ident <> '';
    case ShowModal of
      mrOk: SetStrings(Lines);
      mrYes:
        begin
          // this used to be done in LibMain's TLibrary.Create but now its done here
          //  the unregister is done over in ComponentDesigner's finalization
          //StFilSys.Register;
          Stream := TStringStream.Create(AnsiToUTF8(Lines.Text));
          Stream.Position := 0;
          Age := Now;
          Module := ModuleServices.CreateModule(
            TStringsModuleCreator.Create(Ident, Stream, Age));
          if Module <> nil then
          begin
            with StringsFileSystem.GetTStringsProperty(Ident, Component, GetName) do
              DiskAge := DateTimeToFileDate(Age);
            Editor := Module.GetModuleFileEditor(0);
            if FModified then
              Editor.MarkModified;
            Editor.Show;
          end;
        end;
    end;
  finally
    Free;
  end;
end;

procedure TStrEditDlg.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TStrEditDlg.CodeWndBtnClick(Sender: TObject);
begin
  ModalResult := mrYes;
end;

{ TValueListProperty }

function TValueListProperty.EditDialog: TStrEditDlg;
begin
  Result := TValueEditDlg.Create(Application);
end;

var
  StoredWidth, StoredHeight, StoredLeft, StoredTop: Integer;

procedure TStrEditDlg.FormDestroy(Sender: TObject);
begin
  StoredWidth := Width;
  StoredHeight := Height;
  StoredLeft := Left;
  StoredTop := Top;
end;

procedure TStrEditDlg.FormShow(Sender: TObject);
begin
  if StoredWidth <> 0 then
    Width := StoredWidth;
  if StoredHeight <> 0 then
    Height := StoredHeight;
  if StoredLeft <> 0 then
    Left := StoredLeft
  else
    Left := (Screen.Width - Width) div 2;
  if StoredTop <> 0 then
    Top := StoredTop
  else
    Top := (Screen.Height - Height) div 2;
end;

{ TWideStringListProperty }

destructor TWideStringListProperty.Destroy;
begin
  FreeAndNil(FStrings);
  inherited;
end;

function TWideStringListProperty.GetStrings: TStrings;
var
  WideStrings: TWideStrings;
begin
  WideStrings := TWideStrings(GetOrdValue);
  if FStrings = nil then
    FStrings := TStringList.Create;
  FStrings.Text := WideStrings.Text;
  Result := FStrings;
end;

procedure TWideStringListProperty.SetStrings(const Value: TStrings);
var
  WideStrings: TWideStrings;
begin
  WideStrings := TWideStrings(GetOrdValue);
  WideStrings.Text := Value.Text;
  SetOrdValue(Longint(WideStrings));
end;

end.
