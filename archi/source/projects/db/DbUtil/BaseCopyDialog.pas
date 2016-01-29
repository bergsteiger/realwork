unit BaseCopyDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Mask, ToolEdit, daTypes,
  dt_AttrSchema, dt_Const, dt_Types;

type
  TBaseCopyDlg = class(TForm)
    dirDestFolder: TDirectoryEdit;
    Label1: TLabel;
    Label2: TLabel;
    cbBaseType: TComboBox;
    clbDictSet: TCheckListBox;
    Label3: TLabel;
    cbWithUsers: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    procedure cbBaseTypeChange(Sender: TObject);
    procedure clbDictSetClickCheck(Sender: TObject);
    procedure dirDestFolderChange(Sender: TObject);
  private
    procedure CheckAll(Checked: Boolean);
    procedure CheckReady;
    function DLType2Index(aDictID: TdaDictionaryType): Integer;
    function Index2DLType(aIndex: Integer): TdaDictionaryType;
    function pm_GetBaseFolder: string;
    function pm_GetDictSet: TDLTypeSet;
    function pm_GetWithUsers: Boolean;
    procedure pm_SetBaseFolder(const Value: string);
    procedure pm_SetDictSet(const Value: TDLTypeSet);
    procedure pm_SetWithUsers(const Value: Boolean);
    { Private declarations }
  public
    function Execute: Boolean;
    property BaseFolder: string read pm_GetBaseFolder write pm_SetBaseFolder;
    property DictSet: TDLTypeSet read pm_GetDictSet write pm_SetDictSet;
    property WithUsers: Boolean read pm_GetWithUsers write pm_SetWithUsers;
    { Public declarations }
  end;

var
  Form1: TBaseCopyDlg;

implementation

{$R *.dfm}

Uses
 dt_Dict;

const
 DLTypeArray : array [0..12] of TdaDictionaryType =
   (da_dlSources, da_dlTypes, da_dlClasses, da_dlKeyWords, da_dlBases, da_dlWarnings, da_dlCorSources,
    da_dlPrefixes, da_dlTerritories, da_dlNorms, da_dlAccGroups, da_dlAnnoClasses, da_dlServiceInfo);

 FullDicts = [da_dlSources, da_dlTypes, da_dlClasses, da_dlKeyWords, da_dlBases, da_dlWarnings, da_dlCorSources, da_dlPublisheds,
              da_dlPrefixes, da_dlTerritories, da_dlNorms, da_dlAccGroups, da_dlAnnoClasses, da_dlServiceInfo];


function TBaseCopyDlg.Execute: Boolean;
begin
 CheckReady;
 Result := ShowModal = mrOk;
end;

procedure TBaseCopyDlg.cbBaseTypeChange(Sender: TObject);
begin
 case cbBaseType.ItemIndex of
  0: CheckAll(True);
  1: CheckAll(False);
 end;
 CheckReady;
end;

procedure TBaseCopyDlg.CheckAll(Checked: Boolean);
var
 i: Integer;
begin
 for i:= 0 to Pred(clbDictSet.Items.Count) do
  clbDictSet.Checked[i]:= Checked;
end;

procedure TBaseCopyDlg.CheckReady;
begin
 Button1.Enabled := (cbBaseType.ItemIndex <> -1) and (dirDestFolder.Text <> '');
 dirDestFolder.Enabled := cbBaseType.ItemIndex <> -1;
 clbDictSet.Enabled := cbBaseType.ItemIndex <> -1;
 cbWithUsers.Enabled := cbBaseType.ItemIndex <> -1;
end;

function TBaseCopyDlg.DLType2Index(aDictID: TdaDictionaryType): Integer;
var
 i: Integer;
begin
 Result := -1;
 for i:= 0 to 13 do
  if DLTypeArray[i] = aDictID then
  begin
   Result := i;
   break;
  end;
end;

function TBaseCopyDlg.Index2DLType(aIndex: Integer): TdaDictionaryType;
begin
 Result := DLTypeArray[aIndex];
end;

function TBaseCopyDlg.pm_GetBaseFolder: string;
begin
 Result := dirDestFolder.Text;
end;

function TBaseCopyDlg.pm_GetDictSet: TDLTypeSet;
var
 i: Integer;
begin
 Result := [];
 for i:= 0 to Pred(clbDictSet.Items.Count) do
  if clbDictSet.Checked[i] then
   Include(Result, DLTypeArray[i]);
end;

function TBaseCopyDlg.pm_GetWithUsers: Boolean;
begin
 Result := cbWithUsers.Checked;
end;

procedure TBaseCopyDlg.pm_SetBaseFolder(const Value: string);
begin
 dirDestFolder.Text := Value;
end;

procedure TBaseCopyDlg.pm_SetDictSet(const Value: TDLTypeSet);
var
 i: Integer;
begin
 for i:= 0 to 13 do
  clbDictSet.Checked[i]:= DLTypeArray[i] in Value;
end;

procedure TBaseCopyDlg.pm_SetWithUsers(const Value: Boolean);
begin
 cbWithUsers.Checked:= Value;
end;


procedure TBaseCopyDlg.clbDictSetClickCheck(Sender: TObject);
begin
 cbBaseType.ItemIndex := 2;
end;

procedure TBaseCopyDlg.dirDestFolderChange(Sender: TObject);
begin
 CheckReady;
end;

end.