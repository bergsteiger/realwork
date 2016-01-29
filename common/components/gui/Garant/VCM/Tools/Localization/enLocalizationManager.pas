unit enLocalizationManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, vtLabel;

type
  Ten_LocalizationManager = class(TForm)
    Label1: TLabel;
    SourceFileEdit: TEdit;
    SourceBrowseBtn: TButton;
    Label2: TLabel;
    TargetFileEdit: TEdit;
    TargetBrowseBtn: TButton;
    ModeRadioGroup: TRadioGroup;
    ProcessBtn: TButton;
    OpenDialog: TOpenDialog;
    vtLabel1: TvtLabel;
    procedure ProcessBtnClick(Sender: TObject);
    procedure SourceBrowseBtnClick(Sender: TObject);
    procedure TargetBrowseBtnClick(Sender: TObject);
    procedure ModeRadioGroupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure TextDifference(Sender: TObject; const aName, anOldText, aNewText,
     anOldTranslated: String; var aNewTranslated: String; var IsSameText: Boolean);
  public
    { Public declarations }
  end;

var
  en_LocalizationManager: Ten_LocalizationManager;

implementation

{$R *.dfm}

uses
 Registry,
 TypInfo,

 l3Base,

 vcmLocalizationManager,

 enDifference
 ;

procedure Ten_LocalizationManager.ProcessBtnClick(Sender: TObject);
var
 l_Mgr: TnsLocalizationManager;
 l_Reg: TRegistry;
begin
 try
  l_Mgr := TnsLocalizationManager.Create(SourceFileEdit.Text,TargetFileEdit.Text,
   TnsLocalizationManagerMode(ModeRadioGroup.ItemIndex),TextDifference);
  try
   l_Mgr.Execute;
   l_Reg := TRegistry.Create;
   try
    l_Reg.RootKey := HKEY_CURRENT_USER;
    if l_Reg.OpenKey('software\garant\Localization',True) then
    try
     l_Reg.WriteString(Format('%s.source',[GetEnumName(TypeInfo(TnsLocalizationManagerMode),ModeRadioGroup.ItemIndex)]),
      SourceFileEdit.Text);
     l_Reg.WriteString(Format('%s.target',[GetEnumName(TypeInfo(TnsLocalizationManagerMode),ModeRadioGroup.ItemIndex)]),
      TargetFileEdit.Text);
    finally
     l_Reg.CloseKey;
    end;
   finally
    l3Free(l_Reg);
   end;
  finally
   l3Free(l_Mgr);
  end;
  ShowMessage('Processed');
 except
  on E: EFileNotFound do ShowMessage('File '+E.Message+' not found');
  on E: EDuplicateName do  ShowMessage('Duplicate Key '+E.Message);
  on E: EEmptyTerm do  ShowMessage('Empty term after "'+E.Message+'" term');
  on E: EEmptySource do ShowMessage('Undefined source files for merge');
  on E: ESourceFileNotFound do ShowMessage('Source file for merge '+E.Message+' not found');
 end;
end;

procedure Ten_LocalizationManager.SourceBrowseBtnClick(Sender: TObject);
begin
 OpenDialog.Title := 'Select source file name';
 If OpenDialog.Execute then
  SourceFileEdit.Text := OpenDialog.FileName;
end;

procedure Ten_LocalizationManager.TargetBrowseBtnClick(Sender: TObject);
begin
 OpenDialog.Title := 'Select target file name';
 If OpenDialog.Execute then
  TargetFileEdit.Text := OpenDialog.FileName;
end;

procedure Ten_LocalizationManager.TextDifference(Sender: TObject;
  const aName, anOldText, aNewText, anOldTranslated: String; var aNewTranslated: String; var IsSameText: Boolean);
begin
 IsSameText := en_Difference.Execute(aName, anOldText, aNewText, anOldTranslated, aNewTranslated);
end;

procedure Ten_LocalizationManager.ModeRadioGroupClick(Sender: TObject);
var
 l_Reg: TRegistry;
begin
 l_Reg := TRegistry.Create;
 try
  l_Reg.RootKey := HKEY_CURRENT_USER;
  if l_Reg.OpenKey('software\garant\Localization',True) then
  try
   SourceFileEdit.Text := l_Reg.ReadString(Format('%s.source',[GetEnumName(TypeInfo(TnsLocalizationManagerMode),ModeRadioGroup.ItemIndex)]));
   TargetFileEdit.Text := l_Reg.ReadString(Format('%s.target',[GetEnumName(TypeInfo(TnsLocalizationManagerMode),ModeRadioGroup.ItemIndex)]));
  finally
   l_Reg.CloseKey;
  end;
 finally
  l3Free(l_Reg);
 end;
end;

procedure Ten_LocalizationManager.FormCreate(Sender: TObject);
begin
 ModeRadioGroupClick(nil)
end;

end.
