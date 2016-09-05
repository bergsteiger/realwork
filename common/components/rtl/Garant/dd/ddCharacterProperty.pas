unit ddCharacterProperty;

interface

uses
  Classes,

  ddTypes,
  ddPropertyObject,

  k2Prim,
  k2Interfaces,
  l3Interfaces,

  RTfTypes,

  l3Types,
  l3Base
  ;

type
  TddCharacterProperty = class(TddPropertyObject)
  private
   f_FontName: AnsiString;
   f_LongProperties: Array[TddCharProperties] of Longint;
  private
   function IsDefaultValue(anIndex: TddCharProperties; aValue: LongInt): Boolean;
   function GetParam(Index: TddCharProperties): LongInt;
   procedure SetParam(Index: TddCharProperties; Value: LongInt);
  protected
   function GetBoolProperty(Index: TddCharProperties): Boolean;
   function GetCaps: TddCharCapsType;
   function GetFontName: AnsiString;
   function GetLongProperty(Index: TddCharProperties): LongInt;
   function GetPos: TCharPosition;
   function GetUnderline: TUnderline;
   procedure SetBoolProperty(Index: TddCharProperties; Value: Boolean);
   procedure SetCaps(Value: TddCharCapsType);
   procedure SetFontName(Value: AnsiString);
   procedure SetLongProperty(Index: TddCharProperties; Value: Longint);
   procedure SetPos(Value: TCharPosition);
   procedure SetUnderline(Value: TUnderline);
   property Param[Index: TddCharProperties]: LongInt read GetParam write
           SetParam;
  public
   constructor Create; override;
   procedure AssignFrom(ACHP: TddPropertyObject); override;
   procedure Clear; override;
   function SymbolFont: Boolean;
   function MonoTypeFont: Boolean;
   function OCompare(anObject: Tl3Base): Long; override;
   function Diff(P: TddPropertyObject; aForReader: Boolean): TddPropertyObject; override;
   function JoinWith(P: TObject): Long; override;
   procedure MergeWith(P: TddPropertyObject); override;
   procedure InheriteFrom(P: TddPropertyObject); override;
   procedure Reset; override;
   function HasDefaultValue(aProperty: TddCharProperties): Boolean;
   procedure Write2Generator(const Generator: Ik2TagGenerator); override;
   procedure ClearProp(aPropID: TddCharProperties);
   function IsFontColorWhite: Boolean;
   function IsHighlightColorWhite: Boolean;
   property BColor: LongInt index ddBColor read GetLongProperty write
           SetLongProperty;
   property BIndexColor: LongInt index ddBackColor read GetLongProperty write
           SetLongProperty;
   property Bold: Boolean index ddBold read GetBoolProperty write
           SetBoolProperty;
   property Caps: TddCharCapsType read GetCaps write SetCaps;
   property CharScale: LongInt index ddCharScale read GetLongProperty write
           SetLongProperty;
   property Deleted: Boolean index ddDeleted read GetBoolProperty write
           SetBoolProperty;
   property EvdStyle: LongInt index ddEvdStyle read GetLongProperty write
           SetLongProperty;
   property FColor: LongInt index ddFColor read GetLongProperty write
           SetLongProperty;
   property FIndexColor: LongInt index ddForeColor read GetLongProperty write
           SetLongProperty;
   property FontName: AnsiString read GetFontName write SetFontName;
   property FontNumber: LongInt index ddFontNumber read GetLongProperty write
           SetLongProperty;
   property FontCharSet: LongInt
     index ddFontCharSet
     read GetLongProperty
     write SetLongProperty;
   property FontSize: LongInt index ddFontSize read GetLongProperty write
           SetLongProperty;
   property PrintFontSize: LongInt index ddPrintFontSize read GetLongProperty write
           SetLongProperty;
   property Hidden: Boolean index ddHidden read GetBoolProperty write
           SetBoolProperty;
   property Highlight: LongInt index ddHighlight read GetLongProperty write
           SetLongProperty;
   property Italic: Boolean index ddItalic read GetBoolProperty write
           SetBoolProperty;
   property Language: LongInt index ddLanguage read GetLongProperty write
           SetLongProperty;
   property Pos: TCharPosition read GetPos write SetPos;
   property Strikeout: Boolean index ddStrikeout read GetBoolProperty write
           SetBoolProperty;
   property Style: LongInt index ddStyle read GetLongProperty write
           SetLongProperty;
   property Subpos: LongInt index ddSubPos read GetLongProperty write
           SetLongProperty;
   property Underline: TUnderline read GetUnderline write SetUnderline;
  end;

implementation

uses
  Graphics,

  StrUtils,
  SysUtils,

  k2Tags,

  l3String,
  l3FontManager,

  ddRTFConst,

  Windows;

  { start class TddCharacterProperty }

{
***************************** TddCharacterProperty *****************************
}
constructor TddCharacterProperty.Create;
begin
  inherited Create;
  Clear;
end;

procedure TddCharacterProperty.AssignFrom(aCHP: TddPropertyObject);
var
 l_CHP  : TddCharacterProperty absolute aCHP;
 l_Index: TddCharProperties;
begin
  if (aCHP Is TddCharacterProperty) then
  begin
   for l_Index := Low(TddCharProperties) to High(TddCharProperties) do
     f_LongProperties[l_Index]:= l_CHP.Param[l_Index];

   f_FontName := l_CHP.FontName;
   IsDefault := l_CHP.IsDefault;
  end // if (aCHP Is TddCharacterProperty) then
  else
   inherited AssignFrom(aCHP);
end;

procedure TddCharacterProperty.Clear;
var
 l_Index: TddCharProperties;
begin
 inherited;
 for l_Index := Low(TddCharProperties) to High(TddCharProperties) do
  Param[l_Index] := propUndefined;
 FontName := '';
 IsDefault := True;
end;

function TddCharacterProperty.OCompare(anObject: Tl3Base): Long;
var
 l_Index: TddCharProperties;
begin
 if (anObject Is TddCharacterProperty) then
 begin
  Result := 1;
  if not AnsiSameText(FontName, TddCharacterProperty(anObject).FontName) then
   Exit;
  for l_Index := Low(TddCharProperties) to High(TDdCharProperties) do
   if TddCharacterProperty(anObject).Param[l_Index] <> Param[l_Index] then
    Exit;
  Result := 0;
 end
 else
  Result := inherited OCompare(anObject);
end;

function TddCharacterProperty.Diff(P: TddPropertyObject; aForReader: Boolean): TddPropertyObject;
var
 aCHP: TddCharacterProperty absolute P;
 index: TddCharProperties;
 l_IsDefault: Boolean;
begin
 if P = nil then
  Result := nil
 else
 if OCompare(p) = 0 then
  Result := nil
 else
 begin
  l_IsDefault := True;
  Result := TddCharacterProperty.Create;
  try
   if (P Is TddCharacterProperty) then
   begin
    for index := Low(TddCharProperties) to High(TddCharProperties) do
    begin
     if aCHP.Param[index] = Param[Index] then
      TddCharacterProperty(Result).Param[index] := propUndefined
     else
     if Param[index] = propUndefined then
      TddCharacterProperty(Result).Param[index] := aCHP.Param[index]
     else
     if aCHP.Param[index] <> propUndefined then
      TddCharacterProperty(Result).Param[index] := aCHP.Param[index]
     else
      if (index = ddBold) and (aCHP.Param[index] = propUndefined) and (Param[index] <> propUndefined) then // http://mdp.garant.ru/pages/viewpage.action?pageId=512253629
       TddCharacterProperty(Result).Param[index] := Param[index];
     if not TddCharacterProperty(Result).HasDefaultValue(index) then
      l_IsDefault := False;
    end; // for index
    // Имя шрифта
    if aCHP.Param[ddFontNumber] = Param[ddFontNumber] then
     TddCharacterProperty(Result).FontName := ''
    else
    if Param[ddFontNumber] = propUndefined then
     TddCharacterProperty(Result).FontName := aCHP.FontName
    else
     if aForReader and (aCHP.Param[ddFontNumber] = propUndefined) and (Param[ddFontNumber] <> propUndefined) then
     begin
      TddCharacterProperty(Result).FontNumber := FontNumber;
      TddCharacterProperty(Result).FontName := FontName;
      l_IsDefault := False;
     end // if (aCHP.Param[ddFontNumber] = propUndefined) and (Param[ddFontNumber] <> propUndefined) then
     else
      if aCHP.Param[ddFontNumber] <> propUndefined then
       TddCharacterProperty(Result).FontName := aCHP.FontName;
   end; // P Is TddCharacterProperty
   if l_IsDefault then
    FreeAndNil(Result)
   else
    Result.IsDefault := False;
  except
   FreeAndNil(Result);
  end;
 end;
end;

function TddCharacterProperty.GetBoolProperty(Index: TddCharProperties):
        Boolean;
begin
  if f_LongProperties[Index] <> propUndefined then
   Result:= LongBool(f_LongProperties[Index])
  else
   Result:= False;
end;

function TddCharacterProperty.GetCaps: TddCharCapsType;
begin
  if f_LongProperties[ddCaps] <> propUndefined then
   Result:= TddCharCapsType(f_LongProperties[ddCaps])
  else
   Result:= ccNone;
end;

function TddCharacterProperty.GetFontName: AnsiString;
begin
  Result:= f_FontName;
end;

function TddCharacterProperty.GetLongProperty(Index: TddCharProperties):
        LongInt;
begin
  Result:= f_LongProperties[Index];
end;

function TddCharacterProperty.GetParam(Index: TddCharProperties): LongInt;
begin
  Result:= f_LongProperties[Index];
end;

function TddCharacterProperty.GetPos: TCharPosition;
begin
  if f_LongProperties[ddCharPosition] <> propUndefined then
   Result:= TCharPosition(f_LongProperties[ddCharPosition])
  else
   Result:= cpNotDefined;
end;

function TddCharacterProperty.GetUnderline: TUnderline;
begin
  if f_LongProperties[ddUnderline] <> propUndefined then
   Result:= TUnderline(f_LongProperties[ddUnderline])
  else
   Result:= utNotDefined;
end;

function TddCharacterProperty.JoinWith(P: TObject): Long;
var
 aCHP  : TddCharacterProperty absolute P;
 index : TddCharProperties;
begin
 if (P Is TddCharacterProperty) then
 begin
  Result := 0;
  IsDefault := IsDefault and aCHP.IsDefault;
  if FontName = '' then
   FontName := aCHP.FontName;

  for index := Low(TddCharProperties) to High(TddCharProperties) do
   if Param[Index] = propUndefined then // transparent
    Param[index] := aCHP.Param[Index]
 end // if (P Is TddCharacterProperty) then
 else
  Result := -1;
end;

procedure TddCharacterProperty.MergeWith(P: TddPropertyObject);
var
 aCHP: TddCharacterProperty absolute P;
 Index: TddCharProperties;
begin
 if (P Is TddCharacterProperty) then
 begin
  IsDefault := False;
  for index  := Low(TddCharProperties) to High(TddCharProperties) do
   if (aCHP.Param[Index] <> propUndefined) and (Param[Index] = propUndefined) then
    Param[index] := aCHP.Param[Index];
 end;
end;

procedure TddCharacterProperty.InheriteFrom(P: TddPropertyObject);
var
 aCHP    : TddCharacterProperty absolute P;
 l_Index : TddCharProperties;
begin
 if (P Is TddCharacterProperty) then
 begin
  IsDefault := False;
  for l_Index := Low(TddCharProperties) to High(TddCharProperties) do
   if (aCHP.Param[l_Index] <> propUndefined) and (Param[l_Index] <> propUndefined) then
    Param[l_Index] := aCHP.Param[l_Index];
 end;
end;

procedure TddCharacterProperty.Reset;
begin
  Clear;
  f_FontName:= '';
end;

procedure TddCharacterProperty.SetBoolProperty(Index: TddCharProperties; Value:
        Boolean);
begin
  if (f_LongProperties[Index] = propUndefined) or
     ((f_LongProperties[Index] <> propUndefined) and
       LongBool(f_LongProperties[Index]) <> Value) then
  begin
    f_LongProperties[Index]:= Ord(Value);
    IsDefault:= False;
  end;
end;

procedure TddCharacterProperty.SetCaps(Value: TddCharCapsType);
begin
  if Value <> Caps then
  begin
    IsDefault:= False;
    f_LongProperties[ddCaps]:= Ord(Value);
  end;
end;

procedure TddCharacterProperty.SetFontName(Value: AnsiString);
begin
  if f_FontName <> Value then
  begin
    f_FontName:= Value;
    IsDefault:= False;
  end;
end;

procedure TddCharacterProperty.SetLongProperty(Index: TddCharProperties; Value:
        Longint);
begin
 if (f_LongProperties[Index] <> Value) and not IsDefaultValue(Index, Value) then
 begin
  f_LongProperties[Index] := Value;
  if Index <> ddStyle then
   IsDefault := False;
 end // if f_LongProperties[Index] <> Value then
 else
  if IsDefaultValue(Index, Value) and not IsDefaultValue(Index, f_LongProperties[Index]) then
   ClearProp(Index)
end;

procedure TddCharacterProperty.SetParam(Index: TddCharProperties; Value:
        LongInt);
begin
 f_LongProperties[Index] := Value;
end;

procedure TddCharacterProperty.SetPos(Value: TCharPosition);
begin
 if Value <> Pos then
 begin
  if IsDefaultValue(ddCharPosition, Ord(Value)) then
   f_LongProperties[ddCharPosition] := propUndefined
  else
  begin
   f_LongProperties[ddCharPosition] := Ord(Value);
   IsDefault := False;
  end; 
 end;
end;

procedure TddCharacterProperty.SetUnderline(Value: TUnderline);
begin
  if Value <> Underline then
  begin
    IsDefault:= False;
    f_LongProperties[ddUnderline]:= Ord(Value);
  end;
end;

procedure TddCharacterProperty.Write2Generator(const Generator: Ik2TagGenerator);
var
  l_CharSet  : Long;
  l_LogFont  : Tl3LogFont;
  l_Underline: Boolean;
begin
  // пока не учитывается переданное оформление
 if Hidden then
  Generator.AddBoolAtom(k2_tiVisible, ByteBool(False));
 Generator.StartTag(k2_tiFont);
 try
  if Bold then
   Generator.AddBoolAtom(k2_tiBold, ByteBool(Bold));
  if Italic then
   Generator.AddBoolAtom(k2_tiItalic, ByteBool(Italic));
  if StrikeOut then
   Generator.AddBoolAtom(k2_tiStrikeout, ByteBool(Strikeout));
  if (Language = langRussian) and (FontName <> '') and
      ((Length(FontName) < 4) OR (l3Compare(PAnsiChar(FontName) + Length(FontName) - 4,
                                            ' CYR', l3_siCaseUnsensitive) <> 0)) then
  begin
   l_LogFont := l3FontManager.Fonts.DRByName[FontName];
   if (l_LogFont <> nil) then
    l_CharSet := l_LogFont.LogFont.elfLogFont.lfCharSet
   else
    l_CharSet := DEFAULT_CHARSET;
   if not (l_CharSet in [SYMBOL_CHARSET, RUSSIAN_CHARSET]) then
    FontName := FontName + ' CYR';
  end;
  if FontName <> '' then
   Generator.AddStringAtom(k2_tiName, FontName);

  if (FontSize <> propUndefined) then
   Generator.AddIntegerAtom(k2_tiSize, FontSize div 2);
  if fColor <> propUndefined then
   Generator.AddIntegerAtom(k2_tiForeColor, FColor);
  if bColor <> propUndefined then
   Generator.AddIntegerAtom(k2_tiBackColor, BColor);
  if Highlight <> propUndefined then
   Generator.AddIntegerAtom(k2_tiBackColor, Highlight);

  case Pos of
   cpSuperScript: Generator.AddIntegerAtom(k2_tiIndex, ord(l3_fiSuper));
   cpSubScript: Generator.AddIntegerAtom(k2_tiIndex, ord(l3_fiSub));
  end; // pos
  if (Underline <> utNotDefined) then
  begin
   l_Underline := (Underline <> utNone) and (Underline <> utNotDefined);
   if l_Underline then
    Generator.AddBoolAtom(k2_tiUnderline, l_Underline);
  end;
 finally
   Generator.Finish;
 end;
end;

procedure TddCharacterProperty.ClearProp(aPropID: TddCharProperties);
begin
 Param[aPropID] := propUndefined;
end;

function TddCharacterProperty.IsDefaultValue(anIndex: TddCharProperties;
  aValue: Integer): Boolean;
begin
 Result := aValue = propUndefined;
 if not Result then
  case anIndex of
   ddFColor: Result := (aValue = clBlack);
   ddCharPosition: Result := (aValue = Ord(cpNone)) or (aValue = Ord(cpNotDefined));
  end;
end;

function TddCharacterProperty.SymbolFont: Boolean;
var
 l_CharSet: Long;
 l_LogFont: Tl3LogFont;
begin
 Result := False;
 if (FontName <> '') then
 begin
  l_LogFont := l3FontManager.Fonts.DRByName[FontName];
  if (l_LogFont <> nil) then
  begin
   l_CharSet := l_LogFont.LogFont.elfLogFont.lfCharSet;
   Result := l_CharSet = SYMBOL_CHARSET;
  end; // if (l_LogFont <> nil) then
 end; // if (FontName <> '') then
end;

function TddCharacterProperty.MonoTypeFont: Boolean;
var
 l_CharSet: Long;
 l_LogFont: Tl3LogFont;
begin
 Result := False;
 if (FontName <> '') then
 begin
  l_LogFont := l3FontManager.Fonts.DRByName[FontName];
  if (l_LogFont <> nil) then
   Result := l_LogFont.IsFixed;
 end; // if (FontName <> '') then
end;

function TddCharacterProperty.HasDefaultValue(
  aProperty: TddCharProperties): Boolean;
begin
 Result := IsDefaultValue(aProperty, f_LongProperties[aProperty]);
end;

function TddCharacterProperty.IsFontColorWhite: Boolean;
begin
 Result := FColor = clWhite
end;

function TddCharacterProperty.IsHighlightColorWhite: Boolean;
begin
 Result := Highlight = clWhite
end;

end.
