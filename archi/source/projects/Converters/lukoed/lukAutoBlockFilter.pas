unit lukAutoBlockFilter;

interface

uses
 evdBufferedFilter, k2Interfaces, evdLeafParaFilter, l3Types, Classes,
 l3LongintListPrim, k2TagGen, k2Types;

type
 TlukStructureEvent = procedure (const aText: String; aLevel: Integer) of object;
 TlukStructureFilter = class(TevdLeafParaFilter)
 private
  f_OnStructItem: TlukStructureEvent;
  f_baseIndent: Integer;
  f_DontAnalyze: Boolean;
  f_StructFound: Boolean;
  function CheckWord(const aStr : Tl3PCharLen; IsLast: Bool): Boolean;
  function ParaHasLinks(const aLeaf: Tl3Tag): Boolean;
 protected
  procedure DoWritePara(const aLeaf: Tl3Tag); override;
  procedure StructItem(const aText: String; aLevel: Integer);
 public
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure StartChild(TypeID: Long); override;
  property OnStructItem: TlukStructureEvent read f_OnStructItem write
      f_OnStructItem;
 end;

 TlukStructureCreator = class(TevdLeafParaFilter)
 private
  f_BlockName: TStrings;
  f_BlockStarted: Integer;
  f_CurrentLevel: Integer;
  f_BlockLevels: Tl3LongintListPrim;
  f_BlockNumber: Integer;
  procedure FinishBlock;
  procedure StartBlock;
 protected
  procedure Cleanup; override;
  procedure DoWritePara(const aLeaf: Tl3Tag); override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure CloseStructure(NeedUndo: Bool); override;
  procedure StartChild(TypeID: Long); override;
  procedure StructItem(const aText: String; aLevel: Integer);
 end;



implementation

uses
 Document_Const, nevTools, evTypes, evParaTools, l3String, k2Tags, dt_Types,
 StrUtils, Block_Const, SysUtils, k2Base, evdTypes;

procedure TlukStructureFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if CurrentType.InheritsFrom(k2_idDocument) and (AtomIndex = k2_tiType) and (Value.AsInteger = ord(dtRelText)) then
  f_DontAnalyze:= True;
 inherited;
end;

function TlukStructureFilter.CheckWord(const aStr : Tl3PCharLen; IsLast: Bool):
    Boolean;
var
 l_Text: String;
 l_Pos, l_Level: Integer;
begin
 Result := True;
 if aStr.SLen > 0 then
 begin
  l_Text:= l3PCharLen2String(aStr);
  l_Pos:= 0;
  while (Succ(l_Pos) <= aStr.SLen) and (l_Text[Succ(l_Pos)] = #160) do
   Inc(l_Pos);
  l_level:= l_Pos div f_BaseIndent;
  if l_Level > 0 then
  begin
   { TODO : Не добавлять пустые строки }
   StructItem(Copy(l_Text, Succ(l_Pos), Length(l_Text)), l_Level);
  end;
 end;
end;

procedure TlukStructureFilter.DoWritePara(const aLeaf: Tl3Tag);
var
 i: Integer;
 l_Level: Integer;
 l_Text: String;
begin
 // Первый абзац - это оглавление, разбитое #10 на строки кол-во пробелов означает уровень блока
 // В абзаце обязательно должны быть ссылки!
 if not f_DontAnalyze and not f_StructFound and aLeaf.Attr[k2_tiText].IsValid then
 begin
  if ParaHasLinks(aLeaf) then
  begin
   f_BaseIndent:= 0;
   while (Succ(f_baseIndent) <= Length(aLeaf.Attr[k2_tiText].AsString)) and (aLeaf.Attr[k2_tiText].AsString[Succ(f_BaseIndent)] = #160) do
    Inc(f_BaseIndent);
   if f_BaseIndent < 4 then
   begin
    f_BaseIndent:= 100;
    inherited
   end
   else
    l3ParseWordsEx(aLeaf.Attr[k2_tiText].AsPCharLen, CheckWord, [#10]);
  end // ParaHasLinks(aLeaf)
  else
   inherited;
  f_StructFound:= True;
 end // not f_StructFound and aLeaf.Attr[k2_tiText].IsValid
 else
  inherited;
end;

function TlukStructureFilter.ParaHasLinks(const aLeaf: Tl3Tag): Boolean;
var
 l_hasLinks: Boolean;
  function lp_CheckSegments(const aLayer: Tl3Tag; anIndex: Integer): Boolean;
  begin
   Result := True;
   if aLayer.Attr[k2_tiHandle].IsValid and (aLayer.IntA[k2_tiHandle] = ev_slHyperlinks) then
   begin
    l_HasLinks:= True;
    Result:= False;
   end;
  end; // lp_CheckSegments

begin
 l_HasLinks := False;
  if aLeaf.Attr[k2_tiSegments].IsValid then
   aLeaf.Attr[k2_tiSegments].IterateChildrenF(k2l2tia(@lp_CheckSegments));
 Result:= l_HasLinks;
end;

procedure TlukStructureFilter.StartChild(TypeID: Long);
begin
 inherited;
 if CurrentType.InheritsFrom(k2_idDocument) then
 begin
  f_BaseIndent:= 0;
  f_StructFound:= False;
  f_DontAnalyze:= False;
 end;
end;

procedure TlukStructureFilter.StructItem(const aText: String; aLevel: Integer);
begin
 if Assigned(f_OnStructItem) then f_OnStructItem(aText, aLevel);
end;

// start class TlukStructureCreator  

constructor TlukStructureCreator.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_BlockLevels:= Tl3LongintListPrim.Make;
 f_BlockName:= TStringList.Create;
end;

procedure TlukStructureCreator.Cleanup;
begin
 FreeAndNil(f_BlockLevels);
 FreeAndNil(f_BlockName);
 inherited;
end;

procedure TlukStructureCreator.CloseStructure(NeedUndo: Bool);
begin
 if CurrentType.InheritsFrom(k2_idDocument) then
  while f_BlockStarted > 0 do
   FinishBlock;
 inherited;
end;

procedure TlukStructureCreator.DoWritePara(const aLeaf: Tl3Tag);
begin
 if aLeaf.Attr[k2_tiText].IsValid and (f_BlockName.Count > 0) then
 begin
  if AnsiStartsText(f_BlockName[0], l3ReplaceNonReadable(Trim(aLeaf.Attr[k2_tiText].AsString))) then
  begin
   if f_BlockLevels[0] <= f_CurrentLevel then
    FinishBlock;
   StartBlock;
  end; // AnsiStartsText(f_BlockName[0], Trim(aLeaf.Attr[k2_tiText].AsString))
 end; // not f_StructFound and aLeaf.Attr[k2_tiText].IsValid
 inherited;
end;

procedure TlukStructureCreator.FinishBlock;
begin
 Generator.Finish;
 Dec(f_BlockStarted);
end;

procedure TlukStructureCreator.StartBlock;
begin
 Generator.StartChild(k2_idBlock);
 Generator.AddStringAtom(k2_tiShortName, f_BlockName[0]);
 Generator.AddIntegerAtom(k2_tiHandle, f_BlockNumber);
 Generator.AddIntegerAtom(k2_tiContentsLevel6, 4);
 Inc(f_BlockNumber);
 f_CurrentLevel:= f_BlockLevels[0];
 f_BlockLevels.Delete(0);
 f_BlockName.Delete(0);
 Inc(f_BlockStarted);
end;

procedure TlukStructureCreator.StartChild(TypeID: Long);
begin
 inherited;
 if CurrentType.InheritsFrom(k2_idDocument) then
 begin
  f_CurrentLevel:= 0;
  f_BlockName.Clear;
  f_BlockLevels.Clear;
  f_BlockStarted:= 0;
  f_BlockNumber:= 1000;
 end;
end;

procedure TlukStructureCreator.StructItem(const aText: String; aLevel: Integer);
begin
 f_BlockName.Add(Trim(aText));
 f_BlockLevels.Add(aLevel);
end;

end.
