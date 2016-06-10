unit MissTypesList;

interface

uses 
  Windows, 
  Classes, 
  Graphics, 
  Forms, 
  Controls, 
  Menus,
  Dialogs, 
  StdCtrls, 
  Buttons, 
  ExtCtrls, 
  ComCtrls, 
  ImgList, 
  StdActns,
  ActnList, 
  ToolWin, 
  
  OvcBase,  

  vtlister, 
  vtStatusBar, 
  vtStringLister,

  afwControl, 
  afwInputControl, afwControlPrim, afwBaseControl;

type
  TMissTypesListForm = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ToolBar1: TToolBar;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    ToolButton3: TToolButton;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileOpen1: TAction;
    FileSave1: TAction;
    FileSaveAs1: TAction;
    FileExit1: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    HelpAbout1: TAction;
    ImageList1: TImageList;
    VLister1: TvtStringlister;
    PerenosButton: TSpeedButton;
    SokrachButton: TSpeedButton;
    FamilyButton: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    NormaButton: TSpeedButton;
    AbbrevButton: TSpeedButton;
    ErrorButton: TSpeedButton;
    ToolButton4: TToolButton;
    FindButton: TToolButton;
    ToolButton6: TToolButton;
    StatusBar: TvtStatusBar;
    procedure FileOpen1Execute(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure vlister1CountChanged(Sender: TObject; NewCount: Integer);
    procedure vlister1CurrentChanged(Sender: TObject; NewCurrent, OldCurrent: Integer);
    procedure PerenosButtonClick(Sender: TObject);
    procedure NormaButtonClick(Sender: TObject);
    procedure AbbrevButtonClick(Sender: TObject);
    procedure FamilyButtonClick(Sender: TObject);
    procedure SokrachButtonClick(Sender: TObject);
    procedure ErrorButtonClick(Sender: TObject);
    procedure DeleteOver30Click(Sender: TObject);
    procedure DeleteByFile(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure vlister1ActionElement(Sender: TObject; Index: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    OutFileName_O    : string;
    OutFileName_Norm : string;
    OutFileName_Abbr : string;
    OutFileName_Fam  : string;
    OutFileName_Socr : string;
    OutFileName_Bugs : string;
    OutFileName_30   : string;
    f_Filename       : string;
    function DelandLogItemEntries(aInd           : Integer; 
                                  const aOutFile : string;
                                  aOutEach       : Boolean = False)  : Integer;
  public
    { Public declarations }
  end;

var
  MissTypesListForm: TMissTypesListForm;

implementation

uses 
 SysUtils,

 vtLogFile, 
 vtDialogs,

 l3Base, 
 l3FileUtils, 
 l3String,
 l3StringList,

 Dt_err,

 TypeShop,
 IniShop, 
 Main;
 
{$R *.dfm}

procedure TMissTypesListForm.FileOpen1Execute(Sender: TObject);

 function ReplaceStr(aStr, aSearchStr, aReplaceStr: string): string;
 var
  I, L: Integer;
 begin
  Result := aStr;
  I := Pos(aSearchStr, Result);
  L := Length(aSearchStr);
  while I > 0 do
  begin
   Result := Copy(Result, 1, I - 1) + aReplaceStr + Copy(Result, I + L, MaxInt);
   I := Pos(aSearchStr, Result);
  end;
 end;               

var
 l_Str  : string;
 l_Path : string;
 l_File : TextFile;
begin
 if IniRec.ExecuteOpenDialog(OpenDialog) then
 begin
  f_Filename := OpenDialog.FileName;
  AssignFile(l_File, f_Filename);
  Reset(l_File);
  VLister1.Items.Clear;
  VLister1.BeginUpdate;
  try
   while not EOF(l_File) do
   begin
    Readln(l_File, l_Str);
    l_Str := ReplaceStr(l_Str, #9#9, #9);
    VLister1.Items.Add(l_Str);
   end;
  finally
   VLister1.EndUpdate;
   CloseFile(l_File);
  end;
  //VLister1.Items.LoadFromFile(f_Filename);
  l_Path := ExtractFilePath(f_Filename);   
  OutFileName_O    := l_Path + 'dict_o.lst';
  OutFileName_Norm := l_Path + 'dict_norm.lst';
  OutFileName_Abbr := l_Path + 'dict_Abbr.lst';
  OutFileName_Fam  := l_Path + 'dict_Fam.lst';
  OutFileName_Socr := l_Path + 'dict_Socr.lst';
  OutFileName_Bugs := l_Path + 'dict_Bugs.lst';
  OutFileName_30   := l_Path + 'dict_Hyp.lst';
end;
end;

procedure TMissTypesListForm.FileSave1Execute(Sender: TObject);
begin
 if IniRec.ExecuteSaveDialog(SaveDialog) then
  VLister1.items.SaveToFile(SaveDialog.FileName);
end;

procedure TMissTypesListForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TMissTypesListForm.vlister1CountChanged(Sender: TObject;
  NewCount: Integer);
begin
  StatusBar.Panels[0].Text:= format('%d/%d',[VLister1.Current,NewCount]);
end;

procedure TMissTypesListForm.vlister1CurrentChanged(Sender: TObject;
  NewCurrent, OldCurrent: Integer);
begin
 StatusBar.Panels[0].Text:= format('%d/%d',[NewCurrent,VLister1.Total]);
end;

function TMissTypesListForm.DelandLogItemEntries(aInd           : Integer; 
                                                 const aOutFile : string;
                                                 aOutEach       : Boolean = False) : Integer;
var
 I               : Integer;
 l_Str           : PChar;
 l_Str2          : PChar;
 l_FindStr       : string;
 l_FindLen       : Integer;
 l_ListItem      : string;
 l_FirstListItem : string;
begin
 if aInd > -1 then
 begin
  l_ListItem := VLister1.items[aInd];
  l_FirstListItem := l_ListItem;
  if aOutEach then
   AppendToLogLN(aOutFile, l_ListItem);

  l_Str:= StrScan(@l_ListItem[1], #9) + 1;
  l_Str2 := StrPos(l_Str, #9);
  if (l_Str2 = nil) then 
   l_Str2 := StrEnd(l_Str);
  l_FindLen := Integer(l_Str2) - Integer(l_Str);
  SetString(l_FindStr, l_Str, l_FindLen);
  VLister1.Items.Delete(AInd);
  Result := 1;
  I := AInd;
  VLister1.ChangeNotifyOff;
  try
   while I < VLister1.items.Count do
   begin
    l_ListItem := VLister1.items[I];
    If length(l_ListItem) = 0 then 
    begin 
     Inc(I); 
     Continue; 
    end;
    l_Str := StrScan(@l_ListItem[1], #9);
    if (l_Str = nil) or (l_Str[0] = #0) or (l_Str[1] = #0) then 
    begin 
     Inc(I); 
     Continue; 
    end;
    l_Str := l_Str + 1;
    if CompareMem(l_Str, @l_FindStr[1], l_FindLen) then
    begin
     If aOutEach then
      AppendToLogLN(aOutFile, l_ListItem);

     VLister1.Items.Delete(I); Inc(Result);
    end
    else
     Inc(I);

    if (I mod 10000) = 0 then
     begin
      StatusBar.Panels[1].Text:= Format('%d/%d',[Result, I]);
      StatusBar.Repaint;
     end;
   end;
  finally
   VLister1.ChangeNotifyOn;
  end;

  if not aOutEach then
   AppendToLog(aOutFile, Format('%s'#9'(%d)'#13#10, [l_FirstListItem, Result]));
 end;
end;

procedure TMissTypesListForm.PerenosButtonClick(Sender: TObject);
begin
 DelandLogItemEntries(VLister1.Current, OutFileName_O);
end;

procedure TMissTypesListForm.NormaButtonClick(Sender: TObject);
begin
 DelandLogItemEntries(VLister1.Current, OutFileName_Norm);
end;

procedure TMissTypesListForm.AbbrevButtonClick(Sender: TObject);
begin
 DelandLogItemEntries(VLister1.Current, OutFileName_Abbr);
end;

procedure TMissTypesListForm.FamilyButtonClick(Sender: TObject);
begin
 DelandLogItemEntries(VLister1.Current, OutFileName_Fam);
end;

procedure TMissTypesListForm.SokrachButtonClick(Sender: TObject);
begin
 DelandLogItemEntries(VLister1.Current, OutFileName_Socr);
end;

procedure TMissTypesListForm.ErrorButtonClick(Sender: TObject);
begin
 DelandLogItemEntries(VLister1.Current, OutFileName_Bugs, True);
end;

procedure TMissTypesListForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if f_Filename <> '' then
 begin
  RenametoBack(f_Filename);
  VLister1.items.SaveToFile(f_Filename);
 end;
 CanClose := True;
end;

procedure TMissTypesListForm.FormClose(Sender: TObject;var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TMissTypesListForm.DeleteOver30Click(Sender: TObject);
var
 l_Str           : PChar;
 l_FindStr       : string;
 l_FindLen       : Integer;
 l_ListItem      : string;
 l_FirstListItem : string;
 I               : Integer;
 l_Ind           : Integer;
 l_Result        : Integer;
begin
 l_Ind := 0;
 while l_Ind < VLister1.items.Count do
 begin
  l_ListItem := VLister1.items[l_Ind];
  l_FirstListItem := l_ListItem;

  l_Str:= StrScan(@l_ListItem[1], #9)+1;
  l_FindLen := Integer(StrPos(l_Str, #9)) - Integer(l_Str);
  SetString(l_FindStr, l_Str, l_FindLen);

  l_Result := 0;
  I := l_Ind;
  VLister1.ChangeNotifyOff;
  try
   while I < VLister1.items.Count do
   begin
    l_ListItem := VLister1.items[I];
    l_Str:= StrScan(@l_ListItem[1], #9)+1;
    if CompareMem(l_Str, @l_FindStr[1], l_FindLen) then 
     Inc(l_Result);
    Inc(I);
   end;

   if l_Result > 30 then
   begin
    I := l_Ind;
    while I < VLister1.items.Count do
    begin
     l_ListItem := VLister1.items[I];
     l_Str:= StrScan(@l_ListItem[1], #9)+1;
     if CompareMem(l_Str, @l_FindStr[1], l_FindLen) then
      VLister1.items.Delete(I)
     else
      Inc(I);
    end;
    AppendToLog(OutFileName_30, Format('%s'#9'(%d)'#13#10, [l_FirstListItem, l_Result]));
   end
   else
    Inc(l_Ind);
  finally
   VLister1.ChangeNotifyOn;
  end;
 end;
end;


procedure TMissTypesListForm.DeleteByFile(Sender: TObject);
var
 l_Str           : PChar;
 l_FindStr       : string;
 l_FindLen       : Integer;
 l_ListItem      : string;
 l_FirstListItem : string;
 I               : Integer; 
 l_Ind           : Integer;
 l_Result        : Integer;
 l_List          : Tl3StringList;
 l_TempIndex     : Longint;
begin
 l_List := Tl3StringList.MakeSorted;
 try
  l_List.LoadFromFile('D:\#WORK#.PAS\CHECKER\hyphen.log');

  l_Ind := 0;
  while l_Ind < VLister1.items.Count do
  begin
   l_ListItem := VLister1.items[l_Ind];
   l_FirstListItem := l_ListItem;

   l_Str := StrScan(@l_ListItem[1], #9) + 1;
   l_FindLen := Integer(StrPos(l_Str, #9)) - Integer(l_Str);
   SetString(l_FindStr, l_Str, l_FindLen);

   l_Result := 0;
   I := l_Ind;
   VLister1.ChangeNotifyOff;
   try
    if l_List.FindData(l_FindStr, l_TempIndex) then

    (*while I < VLister1.items.Count do
    begin
     l_ListItem := VLister1.items[I];
     l_Str := StrScan(@l_ListItem[1], #9)+1;
     If CompareMem(l_Str, @l_FindStr[1], l_FindLen) then Inc(l_Result);
     Inc(I);
    end;

    if l_Result > 30 then*)
    begin
     I := l_Ind;
     While I < VLister1.items.Count do
     begin
      l_ListItem := VLister1.items[I];
      l_Str:= StrScan(@l_ListItem[1], #9)+1;
      If CompareMem(l_Str, @l_FindStr[1], l_FindLen) then
       VLister1.Items.Delete(I)
      else
       Inc(I);
     end;
     AppendToLog(OutFileName_30, Format('%s'#9'(%d)'#13#10, [l_FirstListItem, l_Result]));
    end
    else
     Inc(l_Ind);
   finally
    VLister1.ChangeNotifyOn;
   end;
  end;
 finally
  l3Free(l_List); 
 end;
end;

procedure TMissTypesListForm.FindButtonClick(Sender: TObject);
var
 l_FindLen  : Integer;
 l_FindStr  : string;
 l_FindSStr : ShortString;
 l_DocID    : Integer;
 l_Str      : PChar;
 l_ListItem : string;
begin
 if VLister1.Current > -1 then
 begin
  l_ListItem := VLister1.Items[VLister1.Current];

  l_Str := StrScan(@l_ListItem[1], #9) + 1;
  l_FindLen := Integer(l_Str) - Integer(@l_ListItem[1]);
  l_DocID := StrToInt(Trim(Copy(l_ListItem, 0, l_FindLen)));

  l_FindLen := Integer(StrPos(l_Str, #9));
  if l_FindLen = 0 then
   l_FindLen := Integer(StrEnd(l_Str));

  l_FindLen := l_FindLen - Integer(l_Str);
  SetString(l_FindStr, l_Str, l_FindLen);
  l_FindSStr := '>' + l_FindStr + '<';
  try
   MainForm.RunTextEditor(1, l_DocID, False, MakeDocJumpData(djTextSearch, l_FindSStr, True), False {IsJump}, False {IsExternalDocID});
  except
   on E: EHtErrors do
    if E.ErrorValue = ecNotFound then
     vtMessageDlg(l3Fmt('Документ с номером %d не найден', [l_DocID]))
    else
     raise;
  end;
 end
 else
  vtMessageDlg(l3CStr('Ни один пункт не выбран!'));
end;

procedure TMissTypesListForm.vlister1ActionElement(Sender: TObject; Index: Integer);
begin
 FindButtonClick(Self);
end;          

end.


