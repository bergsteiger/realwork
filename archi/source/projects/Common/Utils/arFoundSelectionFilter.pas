unit arFoundSelectionFilter;

{ $Id: arFoundSelectionFilter.pas,v 1.1 2016/08/30 14:11:46 lukyanets Exp $ }

{$Include evDefine.inc }

interface

uses
 l3Types,

 m3DocumentAddress,

 m4DocumentAddress,

 k2Types,
 k2Base,
 k2TagGen,
 k2TagFilter;

type
 TarFoundSelectionFilter = class(Tk2TagFilter)
 private
  f_Addresses        : Tm4Addresses;
  f_CurrentAddressID : Long;
  f_CurrentPara      : Long;
 private
  // internal "local" fields
  f_Text             : Tl3PCharLen;
  f_CurrentWord      : Long;
  f_CurrentAddress   : Tm3DocumentAddress;
 protected
  procedure BeforeClosePara;
    {-}
  function DoWord(const aWord : Tl3PCharLen;
                  IsLast      : Bool): Bool;
    {-}
  procedure DoStartChild(TypeID: Tk2Type);
    override;
    {-}
  procedure DoCloseStructure(NeedUndo: Boolean);
    override;
    {-}
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
    override;
    {-}
 public
  class function SetTo(var theGenerator : Tk2TagGenerator;
                       const aAddresses : Tm4Addresses): Pointer;
     overload;
    {-}
 end;

implementation

uses
 l3Interfaces,
 
 k2Tags,
 k2Interfaces,

 nevTools,

 evdTypes,
 evdStyles,

 l3String,
 l3CustomString,

 TextPara_Const,
 SegmentsLayer_Const,
 TextSegment_Const
 ;

{ TarFoundSelectionFilter }

procedure TarFoundSelectionFilter.BeforeClosePara;
var
 l_Delta : Long;
begin
 if f_Text.SLen > 0 then
 begin
  if (f_Addresses <> nil) then
  begin
   if (f_CurrentAddressID < f_Addresses.Count) then
   begin
    // - не исчерпали все адреса?
    while (f_CurrentAddressID < f_Addresses.Count) do
    begin
     f_CurrentAddress := f_Addresses[f_CurrentAddressID];
     l_Delta := (f_CurrentPara - f_CurrentAddress.rPara);
     if (l_Delta = 0) then
     begin
      // - нашли параграф - надо его красить
      f_CurrentWord := 0;
      l3ParseWords(f_Text, DoWord);
      Break; // - не забыть выйти из цикла !!!
     end
     else
      if (l_Delta < 0) then
       Break; // - адрес уже от старшего параграфа - на этом выделения нету
     Inc(f_CurrentAddressID);
    end;//while true
    Inc(f_CurrentPara);
   end;//f_CurrentAddress < f_Addresses.Count
  end;//f_Addresses <> nil
 end; //if f_Text.SLen > 0 then
end;

procedure TarFoundSelectionFilter.DoAddAtomEx(AtomIndex: Long;
  const Value: Tk2Variant);
begin
 inherited;
 if (AtomIndex = k2_tiText) then
  if Value.AsString.Empty then
   f_Text := l3PCharLen('')
  else
   Tl3WString(f_Text) := Value.AsString.AsWStr;
end;

procedure TarFoundSelectionFilter.DoCloseStructure(NeedUndo: Boolean);
begin
 if CurrentType.IsKindOf(k2_typTextPara) then
  BeforeClosePara;
 inherited;
end;

procedure TarFoundSelectionFilter.DoStartChild(TypeID: Tk2Type);
begin
 inherited;
 if TypeID = k2_typTextPara then
  f_Text := l3PCharLen('');
end;

function TarFoundSelectionFilter.DoWord(const aWord: Tl3PCharLen;
  IsLast: Bool): Bool;
var
 l_Delta   : Long;
 l_BegPos  : Long;
 l_Para    : InevTextPara;
begin
 Result := True;
 while True do
 begin
  l_Delta := (f_CurrentWord - f_CurrentAddress.rWord);
  if (l_Delta = 0) then
  begin
   // - нашли слово - надо его красить
   Generator.StartTag(k2_tiSegments);
   try
    Generator.StartChild(k2_typSegmentsLayer);
    try
     Generator.AddIntegerAtom(k2_tiHandle, Ord(ev_slFoundWords));
     Generator.StartChild(k2_typTextSegment);
     try
      l_BegPos := Succ(aWord.S - f_Text.S);
      Generator.AddIntegerAtom(k2_tiStart, l_BegPos);
      Generator.AddIntegerAtom(k2_tiFinish, l_BegPos + aWord.SLen - 1);
      Generator.AddIntegerAtom(k2_tiStyle, ev_saFoundWords);
     finally
      Generator.Finish; //Generator.StartChild(k2_idTextSegment);
     end;
    finally
     Generator.Finish; //Generator.StartChild(k2_idSegmentsLayer);
    end;
   finally
    Generator.Finish; //Generator.StartTag(k2_tiSegments);
   end;
   Break; // - не забыть выйти из цикла !!!
  end
  else
   if (l_Delta < 0) then
    Break; // - адрес уже от старшего слова - на этом выделения нету
  Inc(f_CurrentAddressID);
  if (f_CurrentAddressID >= f_Addresses.Count) then
  begin
   Result := False;
   Break;
  end;//f_CurrentAddressID >= f_Addresses.Count
  f_CurrentAddress := f_Addresses[f_CurrentAddressID];
  if (f_CurrentAddress.rPara > f_CurrentPara) then
  begin
   // - это уже не наш параграф - пора отваливать
   Result := False;
   Break; 
  end;//f_CurrentAddress.rPara > f_CurrentPara
 end;//while true
 Inc(f_CurrentWord); // - следующий кандидат
end;

class function TarFoundSelectionFilter.SetTo(var theGenerator: Tk2TagGenerator;
  const aAddresses: Tm4Addresses): Pointer;
begin
 Result := inherited SetTo(theGenerator);
 (theGenerator as TarFoundSelectionFilter).f_Addresses := aAddresses;
end;

end.

