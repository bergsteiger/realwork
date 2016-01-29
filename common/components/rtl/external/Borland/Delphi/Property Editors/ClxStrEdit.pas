{ ********************************************************************** }
{                                                                        }
{ Delphi and Kylix Cross-Platform Visual Component Library               }
{ Component and Property Editor Source                                   }
{                                                                        }
{ Copyright (C) 1999, 2001 Borland Software Corporation                  }
{                                                                        }
{ All Rights Reserved.                                                   }
{                                                                        }
{ ********************************************************************** }


unit ClxStrEdit;

interface

uses
  Qt, Classes, QGraphics, QForms, QControls, QButtons, QDialogs, DesignIntf,
  DesignEditors, QStdCtrls, QExtCtrls, QComCtrls, QMenus, QTypes;

type
  TClxStrEditDlg = class(TForm)
    LineCount: TLabel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    HelpButton: TButton;
    OKButton: TButton;
    CancelButton: TButton;
    Memo: TMemo;
    PopupMenu1: TPopupMenu;
    Load1: TMenuItem;
    Save1: TMenuItem;
    Clear1: TMenuItem;
    procedure FileOpen(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure UpdateStatus(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure CodeWndBtnClick(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
  private
    SingleLine: string;
    MultipleLines: string;
    FModified: Boolean;
  end;

type
  TStringListProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

implementation

{$R *.xfm}

uses SysUtils, DesignConst, ToolsAPI, StFilSys, TypInfo;

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
  Result := False;
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

{ TClxStrEditDlg }

procedure TClxStrEditDlg.FileOpen(Sender: TObject);
begin
  with OpenDialog do
    if Execute then Memo.Lines.LoadFromFile(FileName);
end;

procedure TClxStrEditDlg.FileSave(Sender: TObject);
begin
  SaveDialog.FileName := OpenDialog.FileName;
  with SaveDialog do
    if Execute then Memo.Lines.SaveToFile(FileName);
end;

procedure TClxStrEditDlg.UpdateStatus(Sender: TObject);
var
  Count: Integer;
  LineText: string;
begin
  if Sender = Memo then FModified := True;
  Count := Memo.Lines.Count;
  if Count = 1 then LineText := SingleLine
  else LineText := MultipleLines;
  LineCount.Caption := Format('%d %s', [Count, LineText]);
end;

{ TStringListProperty }

function TStringListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
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
    (Component.Owner = Self.Designer.GetRoot) then
  begin
    Ident := Self.Designer.GetRoot.Name + DotSep +
      Component.Name + DotSep + GetName;
    Module := ModuleServices.FindModule(Ident);
  end else Module := nil;
  if (Module <> nil) and (Module.GetModuleFileCount > 0) then
    Module.GetModuleFileEditor(0).Show
  else with TClxStrEditDlg.Create(Application) do
  try
    Memo.Lines := TStrings(GetOrdValue);
    UpdateStatus(nil);
    FModified := False;
    ActiveControl := Memo;
//    CodeEditorItem.Enabled := Ident <> '';
//    CodeWndBtn.Enabled := Ident <> '';
    case ShowModal of
      mrOk: SetOrdValue(Longint(Memo.Lines));
      mrYes:
        begin
          // this used to be done in LibMain's TLibrary.Create but now its done here
          //  the unregister is done over in ComponentDesigner's finalization
          // StFilSys.Register;
          Stream := TStringStream.Create('');
          Memo.Lines.SaveToStream(Stream);
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

procedure TClxStrEditDlg.FormCreate(Sender: TObject);
begin
  SingleLine := srLine;
  MultipleLines := srLines;
end;

procedure TClxStrEditDlg.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Key_Escape then CancelButton.Click;
end;

procedure TClxStrEditDlg.HelpButtonClick(Sender: TObject);
begin
  Application.ContextHelp(HelpContext);
end;

procedure TClxStrEditDlg.CodeWndBtnClick(Sender: TObject);
begin
  ModalResult := mrYes;
end;

procedure TClxStrEditDlg.Clear1Click(Sender: TObject);
begin
  Memo.Lines.Clear;
end;

end.
