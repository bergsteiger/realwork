unit D_GetNum;

{ $Id: D_GETNUM.PAS,v 1.21 2016/03/03 14:00:23 voba Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
     StdCtrls, 
     HelpCnst,
     vtForm, ActnList,
     AddrSup;

type
  TGetNumberDlg = class(TvtForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Label1: TLabel;
    chkRenum: TCheckBox;
    edNumber: TComboBox;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    procedure HelpBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure edNumberSelect(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    //procedure edNumberKeyPress(Sender: TObject; var Key: Char);
  private
    f_ListChanged: Boolean;
    f_NeedSubs: Boolean;
    f_MRUListSrc: TStringList;
    function  DecompileSrcLine(aSrc: string; var theNumber: string; var theExt: Boolean): Boolean;
    procedure FillComboWithMRU;
    function  FormToString: string;
    function  GetNumber : Longint;
    procedure PasteListItemToTheForm(aIdx: Integer);
    procedure pm_SetNeedSubs(const Value: Boolean);
    procedure ReadMRUList;
    procedure SaveMRUList;
    procedure StrToForm(aString: string);
    procedure IncrementNum(aInc : Integer);
  protected
    procedure Cleanup; override;
    function  DefaultCloseAction : TCloseAction; override;
  public
    constructor Create(Owner: TComponent); override;
    property NeedSubs: Boolean read f_NeedSubs write pm_SetNeedSubs;
    Property Number : Longint Read GetNumber;
  end;

function GetIDNumber(Var Value : Longint; Var Renum : Boolean; aWinCaption : String; aHelpContext : Integer): Boolean;
    overload;
function GetIDNumber(Var Value : Longint; var Sub: Integer; Var Renum : Boolean; aWinCaption : String; aHelpContext : Integer): Boolean; overload;

implementation

uses
 l3Base,
 l3IniFile,
 l3String,

 SysUtils,

 Dt_Types,
 IniShop;

{$R *.DFM}

const
 cDocIDMRUList     = 'DocIDMRUList';
 cMaxMRUEntryCount = 20;

function lTrim(aStr : String) : String;
var
 lB, lE : Integer;
const
 cLegalCharSet = ['0'..'9', '.'];
begin
 lB := 0;
 while (lB < Length(aStr)) and not (aStr[Succ(lB)] in cLegalCharSet) do
  inc(lB);

 lE := lB;
 while (lE < Length(aStr)) and (aStr[Succ(lE)] in cLegalCharSet) do
  inc(lE);

 Result := Copy(aStr, Succ(lB), lE - lB);
end;

constructor TGetNumberDlg.Create(Owner: TComponent);
begin
 inherited;
 f_MRUListSrc := TStringList.Create;
 ReadMRUList;
 FillComboWithMRU;
end;

function TGetNumberDlg.GetNumber : Longint;
begin
 Result:=StrToIntDef(edNumber.Text, 0);
end;

procedure TGetNumberDlg.HelpBtnClick(Sender: TObject);
begin
 Application.HelpContext(HelpContext);
end;

procedure TGetNumberDlg.CancelBtnClick(Sender: TObject);
begin
 //Application.HelpContext(HelpContext);
end;

procedure TGetNumberDlg.Cleanup;
begin
 if f_ListChanged then
  SaveMRUList;
 l3Free(f_MRUListSrc);
 inherited;
end;

function TGetNumberDlg.FormToString: string;
begin
 Result := lTrim(edNumber.Text)+':';
 if chkRenum.Checked then
  Result := Result + '1'
 else
  Result := Result + '0';
end;

procedure TGetNumberDlg.pm_SetNeedSubs(const Value: Boolean);
begin
 if f_NeedSubs <> Value then
 begin
  f_NeedSubs := Value;
  FillComboWithMRU;
 end;
end;

procedure TGetNumberDlg.ReadMRUList;
var
 l_Tmp: Pointer;
begin
 if UserConfig <> nil then
 begin
  f_MRUListSrc.Clear;
  UserConfig[cDocIDMRUList].ReadParamList('Entry', f_MRUListSrc);
 end;
end;

procedure TGetNumberDlg.SaveMRUList;
begin
 UserConfig[cDocIDMRUList].WriteParamList('Entry', f_MRUListSrc, cMaxMRUEntryCount);
end;

procedure TGetNumberDlg.StrToForm(aString: string);
var
 l_Num: string;
 l_Ext: Boolean;
begin
 DecompileSrcLine(aString, l_Num, l_Ext);
 edNumber.Text := l_Num;
 chkRenum.Checked := l_Ext;
end;

function GetIDNumberPrim(var aDocID : TDocID; var aSubID: TSubID; var Renum : Boolean; aWinCaption : String;
    aHelpContext: Integer; aNeedSub: Boolean): Boolean;
var
 l_NumStr : string;
 l_SubStr : string;
 l_X      : Integer;
begin
 with TGetNumberDlg.Create(Nil) do
 begin
  NeedSubs := aNeedSub;
  Caption := aWinCaption;
  HelpContext := aHelpContext;

  Result := ShowModal = mrOk;

  if Result then
  begin
   l_NumStr := lTrim(edNumber.Text);
   StrToDocAddr(l_NumStr, aDocID, aSubID);
   if aDocID < 0 then aDocID := 0;
   if aSubID < 0 then aSubID := 0;
   Renum  := chkRenum.Checked;
  end;
  Free;
 end;
end;

function GetIDNumber(Var Value : Longint; var Sub: Integer; Var Renum : Boolean; aWinCaption : String; aHelpContext :
    Integer): Boolean;
begin
 Result := GetIDNumberPrim(Value, Sub, Renum, aWinCaption, aHelpContext, True);
end;

function GetIDNumber(Var Value : Longint; Var Renum : Boolean; aWinCaption : String; aHelpContext : Integer): Boolean;
    overload;
var
 l_Sub: Integer;
begin
 Result := GetIDNumberPrim(Value, l_Sub, Renum, aWinCaption, aHelpContext, False);
end;

function TGetNumberDlg.DecompileSrcLine(aSrc: string; var theNumber: string; var theExt: Boolean) : boolean;
var
 l_Num: string;
 l_Ext: Char;
 l_X: Integer;
begin
 try
  l_Num := '';
  l_Ext := '0';
  l_X := Pos(':', aSrc);
  if l_X > 0 then
  begin
   l_Ext := aSrc[l_X+1];
   aSrc := System.Copy(aSrc, 1, l_X-1);
  end;
  if not NeedSubs then
  begin
   l_X := Pos('.', aSrc);
   if l_X > 0 then
    aSrc := System.Copy(aSrc, 1, l_X-1); // отрезаем саб, он не нужен
  end;
  theNumber := aSrc;
  theExt := l_Ext = '1';
  Result := True;
 except
  Result := False;
 end;
end;

procedure TGetNumberDlg.edNumberSelect(Sender: TObject);
begin
 PasteListItemToTheForm({Integer(edNumber.Items.Objects[}edNumber.ItemIndex{])});
end;

procedure TGetNumberDlg.FillComboWithMRU;
var
 I: Integer;
 l_Num: string;
 l_Ext: Boolean;
begin
 edNumber.Items.Clear;
 for I := 0 to Pred(f_MRUListSrc.Count) do
 begin
  if DecompileSrcLine(f_MRUListSrc.Strings[I], l_Num, l_Ext) then
   if edNumber.Items.IndexOf(l_Num) < 0 then
    edNumber.Items.AddObject(l_Num, TObject(I));
 end;
 if edNumber.Items.Count > 0 then
  PasteListItemToTheForm(0);
end;

procedure TGetNumberDlg.OKBtnClick(Sender: TObject);
var
 l_NewEntry: string;
 l_Idx: Integer;
begin
 if edNumber.Text <> '' then
 begin
  l_NewEntry := FormToString;
  l_Idx := f_MRUListSrc.IndexOf(l_NewEntry);
  if l_Idx < 0 then
   f_MRUListSrc.Insert(0, l_NewEntry)
  else
   f_MRUListSrc.Move(l_Idx, 0);
  f_ListChanged := True;
 end;
 ModalResult := mrOK;
end;

procedure TGetNumberDlg.PasteListItemToTheForm(aIdx: Integer);
begin
 aIdx := Integer(edNumber.Items.Objects[aIdx]);
 StrToForm(f_MRUListSrc.Strings[aIdx]);
end;

//procedure TGetNumberDlg.edNumberKeyPress(Sender: TObject; var Key: Char);
//begin
 //if not (Key in ['0'..'9','.', #8, #13, #27]) then
 // Key := #0;
//end;

procedure TGetNumberDlg.IncrementNum(aInc : Integer);
var
 l_NumStr: string;
 l_SubStr: string;
 l_Num   : Integer;
 l_Sub   : Integer;
 l_X     : Integer;
begin
 l_NumStr := lTrim(edNumber.Text);
 l_X := Pos('.', l_NumStr);
 if l_X > 0 then
 begin
  l_SubStr := System.Copy(l_NumStr, l_X+1, MaxInt);
  l_NumStr := System.Copy(l_NumStr, 1, l_X-1);
 end;

 l_Num := StrToIntDef(l_NumStr, 0);
 l_Sub := StrToIntDef(l_SubStr, 0);

 if l_Sub > 0 then
 begin
  Inc(l_Sub, aInc);
  edNumber.Text := Format('%d.%d', [l_Num, l_Sub]);
 end
 else
 begin
  Inc(l_Num, aInc);
  edNumber.Text := Format('%d', [l_Num]);
 end;
end;

procedure TGetNumberDlg.Action1Execute(Sender: TObject);
begin
 IncrementNum(1);
end;

procedure TGetNumberDlg.Action2Execute(Sender: TObject);
begin
 IncrementNum(-1);
end;

function TGetNumberDlg.DefaultCloseAction: TCloseAction;
begin
 Result := caHide; 
end;

end.
