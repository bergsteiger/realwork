unit CmdListEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, vtGrids, vtCmdCenter;

type
  TvtCommandListEditor = class(TForm)
    CmdTable: TvtStringGrid;
    procedure CmdTableGetCellText(Sender: TObject; ACol, ARow: Integer;
      var Value: PChar);
  private
    { Private declarations }
    fBufStr : string[200];
    fComCenter : TvtCommandCenter;
  public
    function Execute(aComCenter : TvtCommandCenter) : boolean;
  end;

implementation

{$R *.DFM}

uses
 Consts;
{ TShortCut processing routines }

function ShortCut(Key: Word; Shift: TShiftState): TShortCut;
begin
  Result := 0;
  if WordRec(Key).Hi <> 0 then Exit;
  Result := Key;
  if ssShift in Shift then Inc(Result, scShift);
  if ssCtrl in Shift then Inc(Result, scCtrl);
  if ssAlt in Shift then Inc(Result, scAlt);
end;

procedure ShortCutToKey(ShortCut: TShortCut; var Key: Word; var Shift: TShiftState);
begin
  Key := ShortCut and not (scShift + scCtrl + scAlt);
  Shift := [];
  if ShortCut and scShift <> 0 then Include(Shift, ssShift);
  if ShortCut and scCtrl <> 0 then Include(Shift, ssCtrl);
  if ShortCut and scAlt <> 0 then Include(Shift, ssAlt);
end;

type
  TMenuKeyCap = (mkcBkSp, mkcTab, mkcEsc, mkcEnter, mkcSpace, mkcPgUp,
    mkcPgDn, mkcEnd, mkcHome, mkcLeft, mkcUp, mkcRight, mkcDown, mkcIns,
    mkcDel, mkcShift, mkcCtrl, mkcAlt);

var
  MenuKeyCaps: array[TMenuKeyCap] of string = (
    SmkcBkSp, SmkcTab, SmkcEsc, SmkcEnter, SmkcSpace, SmkcPgUp,
    SmkcPgDn, SmkcEnd, SmkcHome, SmkcLeft, SmkcUp, SmkcRight,
    SmkcDown, SmkcIns, SmkcDel, SmkcShift, SmkcCtrl, SmkcAlt);

function GetSpecialName(aKey : Byte): string;
var
  ScanCode: Integer;
  KeyName: array[0..255] of Char;
begin
  Result := '';
  ScanCode := MapVirtualKey(aKey, 0) shl 16;
  if ScanCode <> 0 then
  begin
    GetKeyNameText(ScanCode, KeyName, SizeOf(KeyName));
    Result := KeyName;
  end;
end;

function KeyToText(aKey : Byte): string;
begin
  case aKey of
    0       : Result := '';
    $08, $09: Result := MenuKeyCaps[TMenuKeyCap(Ord(mkcBkSp) + aKey - $08)];
    $0D:      Result := MenuKeyCaps[mkcEnter];
    $1B:      Result := MenuKeyCaps[mkcEsc];
    $20..$28: Result := MenuKeyCaps[TMenuKeyCap(Ord(mkcSpace) + aKey - $20)];
    $2D..$2E: Result := MenuKeyCaps[TMenuKeyCap(Ord(mkcIns) + aKey - $2D)];
    $30..$39: Result := Chr(aKey - $30 + Ord('0'));
    $41..$5A: Result := Chr(aKey - $41 + Ord('A'));
    $60..$69: Result := Chr(aKey - $60 + Ord('0'));
    $70..$87: Result := 'F' + IntToStr(aKey - $6F);
    else      Result := GetSpecialName(aKey);
  end;
end;

function ShortCutToText(ShortCut: TvtShortCut): string;
 var
  Name: string;
 begin
  Result := '';
  with ShortCut do
   begin
    If SS > 0 then
     begin
      Result := '';
      if SS and ss_Shift <> 0 then Result := Result + MenuKeyCaps[mkcShift];
      if SS and ss_Ctrl <> 0  then Result := Result + MenuKeyCaps[mkcCtrl];
      if SS and ss_Alt <> 0   then Result := Result + MenuKeyCaps[mkcAlt];
     end;
    If Key1 > 0 then Result := Result + KeyToText(Key1);
    If Key2 > 0 then
     begin
      If Key1 > 0 then Result := Result + '+';
      Result := Result + KeyToText(Key2);
     end; 
   end;
end;

{ This function is *very* slow.  Use sparingly.  Return 0 if no VK code was
  found for the text }

(*
function TextToShortCut(Text: string): TShortCut;

  { If the front of Text is equal to Front then remove the matching piece
    from Text and return True, otherwise return False }

  function CompareFront(var Text: string; const Front: string): Boolean;
  begin
    Result := False;
    if (Length(Text) >= Length(Front)) and
      (AnsiStrLIComp(PChar(Text), PChar(Front), Length(Front)) = 0) then
    begin
      Result := True;
      Delete(Text, 1, Length(Front));
    end;
  end;

var
  Key: TShortCut;
  Shift: TShortCut;
begin
  Result := 0;
  Shift := 0;
  while True do
  begin
    if CompareFront(Text, MenuKeyCaps[mkcShift]) then Shift := Shift or scShift
    else if CompareFront(Text, '^') then Shift := Shift or scCtrl
    else if CompareFront(Text, MenuKeyCaps[mkcCtrl]) then Shift := Shift or scCtrl
    else if CompareFront(Text, MenuKeyCaps[mkcAlt]) then Shift := Shift or scAlt
    else Break;
  end;
  if Text = '' then Exit;
  for Key := $08 to $255 do { Copy range from table in ShortCutToText }
    if AnsiCompareText(Text, ShortCutToText(Key)) = 0 then
    begin
      Result := Key or Shift;
      Exit;
    end;
end;
*)

function TvtCommandListEditor.Execute(aComCenter : TvtCommandCenter) : boolean;

 begin
  fComCenter := aComCenter;
  CmdTable.RowCount := Succ(fComCenter.CommandCount);

  Result := ShowModal = mrOK;
 end;

procedure TvtCommandListEditor.CmdTableGetCellText(Sender: TObject; aCol, aRow: Integer; var Value: PChar);
 begin
  If aRow = 0
   then
    Case aCol of
     0 : Value := 'InternalName';
     1 : Value := 'CmdGroup';
     2 : Value := 'CmdID';
     3 : Value := 'HotKey';
     4 : Value := 'UserName';
     5 : Value := 'Description';
    end
   else
    begin
     With fComCenter.Command[Pred(aRow)] do
      Case aCol of
       0 : fBufStr := Format('%s'#0,[InternalName]);
       1 : fBufStr := Format('%d'#0,[CmdID.CmdGroup]);
       2 : fBufStr := Format('%d'#0,[CmdID.CmdItem]);
       3 : fBufStr := Format('%s'#0,[ShortCutToText(ShortCut)]);
       4 : fBufStr := Format('%s'#0,[UserName]);
       5 : fBufStr := Format('%s'#0,[Description]);
      end;
     Value := @fBufStr[1];
    end;

 end;
end.
