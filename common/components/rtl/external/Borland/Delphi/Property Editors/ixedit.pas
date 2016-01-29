
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       IndexFileName Property Editor Dialog            }
{                                                       }
{   Copyright (c) 1997-2001 Borland Software Corp.      }
{                                                       }
{*******************************************************}

unit Ixedit;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBTables, LibHelp;

type
  TIndexFiles = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Add: TButton;
    Delete: TButton;
    Ok: TButton;
    Cancel: TButton;
    Help: TButton;
    Clear: TButton;
    OpenDialog: TOpenDialog;
    procedure ListBox1Click(Sender: TObject);
    procedure AddClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HelpClick(Sender: TObject);
  private
    FTable: TTable;
    FNoItems: Boolean;
    FEmpty: string;
    procedure AddEmpty;
    function IsDBaseTable: Boolean;
    procedure RemoveEmpty;
    procedure SetButtons;
  public
    property Table: TTable read FTable;
    property NoItems: Boolean read FNoItems;
  end;

function EditIndexFiles(ATable: TTable; List: TStrings): Boolean;

implementation

{$R *.dfm}

uses BDE, bdeconst, TypInfo, DBConsts;

function GetPath(const Path: string): string;
var
  Desc: DBDesc;
  SAliasName: array [0..DBIMAXNAMELEN - 1] of char;
begin
  if ExtractFileDir(Path) = '' then
  begin
    StrPLCopy(SAliasName, Path, SizeOf(SAliasName) - 1);
    AnsiToOem(SAliasName, SAliasName);
    if DbiGetDatabaseDesc(SAliasName, @Desc) = 0 then
      if StrPas(Desc.szDbType) = 'STANDARD' then
        Result := StrPas(Desc.szPhyName);
  end
  else Result := Path;
end;

function TIndexFiles.IsDBaseTable: Boolean;
begin
  Result := (Table.TableType = ttDBase) or
    (CompareText(ExtractFileExt(Table.TableName), '.DBF') = 0);
end;

function EditIndexFiles(ATable: TTable; List: TStrings): Boolean;
begin
  Session.Open;
  with TIndexFiles.Create(Application) do
    try
      FTable := ATable;
      Caption := Format(SIndexFilesEditor,
        [Table.Owner.Name, DotSep, Table.Name]);
      if IsDBaseTable then ListBox1.Items.Assign(List)
      else Add.Enabled := False;
      OpenDialog.InitialDir := GetPath(Table.DatabaseName);
      if ListBox1.Items.Count = 0 then AddEmpty;
      SetButtons;
      Result := ShowModal = mrOk;
      if Result then
      begin
        RemoveEmpty;
        List.Assign(ListBox1.Items);
      end;
    finally
      Free;
    end;
end;

procedure TIndexFiles.SetButtons;
var
  I: Integer;
begin
  if not IsDBaseTable then Exit;
  Clear.Enabled := not NoItems;
  if NoItems then Delete.Enabled := False
  else with ListBox1 do
  begin
    for I := Items.Count - 1 downto 0 do
      if Selected[I] then Break;
    Delete.Enabled := I <> -1;
  end;
end;

procedure TIndexFiles.ListBox1Click(Sender: TObject);
begin
  SetButtons;
end;

procedure TIndexFiles.AddClick(Sender: TObject);
begin
  with OpenDialog, ListBox1.Items do
    if Execute then
    begin
      if IndexOf(FileName) = -1 then
      begin
        RemoveEmpty;
        Add(ExtractFileName(FileName));
      end;
      SetButtons;
    end;
end;

procedure TIndexFiles.AddEmpty;
begin
  if not FNoItems then
  begin
    ListBox1.Items.Add(FEmpty);
    FNoItems := True;
  end;
end;

procedure TIndexFiles.RemoveEmpty;
begin
  if FNoItems then
  begin
    ListBox1.Items.Delete(0);
    FNoItems := False;
  end;
end;

procedure TIndexFiles.DeleteClick(Sender: TObject);
var
  I: Integer;
begin
  with ListBox1 do
  begin
    for I := Items.Count - 1 downto 0 do
      if Selected[I] then Items.Delete(I);
    if Items.Count = 0 then AddEmpty;
  end;
  SetButtons;
end;

procedure TIndexFiles.ClearClick(Sender: TObject);
begin
  with ListBox1 do
  begin
    Clear;
    AddEmpty;
  end;
  SetButtons;
end;

procedure TIndexFiles.FormCreate(Sender: TObject);
begin
  FEmpty := SNoIndexFiles;
  HelpContext := hcDTableIndexEditor;
end;

procedure TIndexFiles.HelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
