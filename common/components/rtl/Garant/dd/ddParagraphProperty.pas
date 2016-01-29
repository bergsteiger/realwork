unit ddParagraphProperty;

interface

uses
  Classes,

  ddTypes,
  ddBorder,
  ddPropertyObject,

  l3ProtoObjectRefList,

  rtfListTable,
  RTfTypes,

  l3Types,
  l3Base;

type
  TddParagraphProperty = class(TddPropertyObject)
  private
    f_Inherited: Boolean;
    f_Border: TddBorder;
    f_LongProperties: Array[TddParagraphProperties] of Longint;
    f_TabList: Tl3ProtoObjectRefList;
  private  
    function GetBooleanProperty(Index: TddParagraphProperties): Boolean;
    function GetJUST: Tjust;
    function GetLongProperty(Index: TddParagraphProperties): LongInt;
    function GetParam(Index: TddParagraphProperties): LongInt;
    procedure SetBooleanProperty(Index: TddParagraphProperties; Value: Boolean);
    procedure SetJUST(Value: Tjust);
    procedure SetLongProperty(Index: TddParagraphProperties; Value: Longint);
    procedure SetParam(Index: TddParagraphProperties; Value: LongInt);
    function IsDefaultValue(anIndex: TddParagraphProperties): Boolean;
  protected
    procedure Cleanup; override;
  public
    constructor Create; override;
    procedure AssignFrom(aSource: TddPropertyObject); override;
    function OCompare(anObject: Tl3Base): Long; override;
    procedure Clear; override;
    function Diff(P: TddPropertyObject): TddPropertyObject; override;
    function JoinWith(P: TObject): Long; override;
    procedure MergeWith(P: TddPropertyObject); override;
    procedure InheriteFrom(P: TddPropertyObject); override;
    property After: Integer index dd_After read GetLongProperty write
            SetLongProperty;
    property Before: Integer index dd_Before read GetLongProperty write
            SetLongProperty;
    property Between: Integer index dd_Between read GetLongProperty write
            SetLongProperty;
    property Border: TddBorder read f_Border write f_Border;
    property BreakBefore: Boolean index dd_BreakBefore read GetBooleanProperty
            write SetBooleanProperty;
    property Bullet: Integer index dd_Bullet read GetLongProperty write
            SetLongProperty;
    property Hyph: Boolean index dd_Hyph read GetBooleanProperty write
            SetBooleanProperty;
    property InTable: Boolean index dd_InTable read GetBooleanProperty write
            SetBooleanProperty;
    property JUST: Tjust read GetJUST write SetJUST;
    property Keep: Boolean index dd_Keep read GetBooleanProperty write
            SetBooleanProperty;
    property KeepWNext: Boolean index dd_KeepWNext read GetBooleanProperty
            write SetBooleanProperty;
    property LineSpaceExact: Boolean index dd_LineSpaceExact read
            GetBooleanProperty write SetBooleanProperty;
    property ListItem: Integer index dd_ListItem read GetLongProperty write
        SetLongProperty;
    property iLvl: Integer index dd_iLvl read GetLongProperty write
        SetLongProperty;
    property itap: Integer index dd_itap read GetLongProperty write
        SetLongProperty;
    property NoLine: Boolean index dd_NoLine read GetBooleanProperty write
            SetBooleanProperty;
    property Param[Index: TddParagraphProperties]: LongInt read GetParam write
        SetParam;
    property SideBSide: Boolean index dd_SideBSide read GetBooleanProperty
            write SetBooleanProperty;
    property Style: Integer index dd_Style read GetLongProperty write
            SetLongProperty;
    property TabList: Tl3ProtoObjectRefList read f_TabList write f_TabList;
    property TrimText: Boolean index dd_TrimText read GetBooleanProperty write SetBooleanProperty;
    property xaFirst: LongInt index dd_xaFirst read GetLongProperty write
            SetLongProperty;
    property xaLeft: LongInt index dd_xaLeft read GetLongProperty write
            SetLongProperty;
    property xaRight: LongInt index dd_xaRight read GetLongProperty write
            SetLongProperty;
    property PosX: LongInt index dd_posx read GetLongProperty write
            SetLongProperty;
    property PosY: LongInt index dd_posy read GetLongProperty write
            SetLongProperty;
    property AbsH: LongInt index dd_absh read GetLongProperty write
            SetLongProperty;
    property AbsW: LongInt index dd_absw read GetLongProperty write
            SetLongProperty;
    property anInherited: Boolean read f_Inherited write f_Inherited;
  end;

implementation

uses
  Math,
  SysUtils;

const
 cnIlvlDefValue = 0;
 cnItapDefValue = 1;

{
***************************** TddParagraphProperty *****************************
}
constructor TddParagraphProperty.Create;
begin
  inherited Create;
  f_Border:= TddBorder.Create;
  f_Border.BorderOwner:= boPara;
  f_TabList:= Tl3ProtoObjectRefList.Make;
  Clear;
end;

procedure TddParagraphProperty.AssignFrom(aSource: TddPropertyObject);
var
  aPAP: TddParagraphProperty absolute aSource;
  index: TddParagraphProperties;
  i: Integer;
begin
  if (aSource Is TddParagraphProperty) then
  begin
   IsDefault:= aPAP.IsDefault;
   for index:= Low(TddParagraphProperties) to High(TddParagraphProperties) do
     f_LongProperties[index]:= aPAP.Param[index];

   f_Border.AssignFrom(APAP.Border);
   f_TabList.Clear;

   for i:= 0 to aPAP.TabList.Hi do
     f_TabList.Add(aPAP.TabList.Items[i]);

  end
  else
   inherited AssignFrom(aSource);
end;

procedure TddParagraphProperty.Clear;
var
 l_Index: TddParagraphProperties;
begin
 inherited Clear;
 f_Inherited := False;
 for l_Index := Low(TddParagraphProperties) to High(TddParagraphProperties) do
  f_LongProperties[l_Index] := propUndefined;
 f_Border.Clear;
 f_TabList.Clear;
 Style := 0;
 Hyph := true;
 InTable := False; // Почему-то было закомментировано
 ilvl := cnIlvlDefValue;
 itap := cnItapDefValue;
 IsDefault := True;
end;

function TddParagraphProperty.GetBooleanProperty(Index:
        TddParagraphProperties): Boolean;
begin
 if f_LongProperties[Index] <> propUndefined then
  Result:= LongBool(f_LongProperties[Index])
 else
  Result:= False;
end;

function TddParagraphProperty.GetJUST: TJust;
begin
 if InRange(f_LongProperties[dd_Just], Ord(justL), Ord(justP)) then
  Result:= TJust(f_LongProperties[dd_Just])
 else
  Result:= justNotDefined;
end;

function TddParagraphProperty.GetLongProperty(Index: TddParagraphProperties):
        LongInt;
begin
  Result:= f_LongProperties[Index];
end;

function TddParagraphProperty.GetParam(Index: TddParagraphProperties): LongInt;
begin
  Result:= f_LongProperties[Index]
end;

function TddParagraphProperty.JoinWith(P: TObject): Long;
var
 i       : Long;
 l_PAP   : TddParagraphProperty;
 l_Index : TddParagraphProperties;
begin
 if (P Is TddParagraphProperty) then
 begin
  Result := 0;
  l_PAP := P as TddParagraphProperty;
  IsDefault := l_PAP.IsDefault;
  for l_Index := Low(TddParagraphProperties) to High(TddParagraphProperties) do
   if IsDefaultValue(l_Index) then
    Param[l_Index] := l_PAP.Param[l_Index];
  f_Border.JoinWith(l_PAP.Border);

  f_TabList.Clear;
  for i := 0 to l_PAP.TabList.Hi do
   f_TabList.Add(l_PAP.TabList.Items[i]);
 end
 else
  Result := inherited JoinWith(P);
end;

procedure TddParagraphProperty.MergeWith(P: TddPropertyObject);
var
 i       : Integer;
 aPAP    : TddParagraphProperty absolute P;
 l_Index : TddParagraphProperties;
begin
 if (P Is TddParagraphProperty) then
 begin
  IsDefault := False;
  for l_Index := Low(TddParagraphProperties) to High(TddParagraphProperties) do
   if (aPAP.Param[l_Index] <> propUndefined) and (Param[l_Index] = propUndefined) then
    Param[l_Index] := aPAP.Param[l_Index];
  f_Border.MergeWith(aPAP.Border);
  f_TabList.Clear;
  for i := 0 to aPAP.TabList.Hi do
   f_TabList.Add(aPAP.TabList.Items[i]);
 end;
end;

procedure TddParagraphProperty.Cleanup;
begin
  FreeAndNil(f_TabList);
  FreeAndNil(f_Border);
  f_Inherited := False;
  inherited;
end;

function TddParagraphProperty.OCompare(anObject: Tl3Base): Long;
var
 l_Index : TddParagraphProperties;
begin
 if (anObject Is TddParagraphProperty) then
 begin
  Result := 1;
  for l_Index := Low(TddParagraphProperties) to High(TDdParagraphProperties) do
   if TddParagraphProperty(anObject).Param[l_Index] <> Param[l_Index] then Exit;
  Result := 0;
 end // if (anObject Is TddParagraphProperty) then
 else
  Result := inherited OCompare(anObject);
end;

function TddParagraphProperty.Diff(P: TddPropertyObject): TddPropertyObject;
var
  aPAP: TddParagraphProperty absolute P;
  index: TddParagraphProperties;
begin
 if OCompare(p) = 0 then
   Result:= nil
 else
 begin
  Result:= TddParagraphProperty.Create;
  try
   if (P Is TddParagraphProperty) then
   begin
    for index:= Low(TddParagraphProperties) to High(TddParagraphProperties) do
    begin
      if aPAP.Param[index] = Param[Index] then
       TddParagraphProperty(Result).Param[index]:= propUndefined
      else
      if Param[index] = propUndefined then
       TddParagraphProperty(Result).Param[index]:= propUndefined
      else
       TddParagraphProperty(Result).Param[index]:= Param[index];
      //TddParagraphProperty(Result).Param[index]:= ifThen(Param[index] = propUndefined,
      //                                                  aPAP.Param[index], Param[index]);
    end; // for Index
    { TODO -oДудко Дмитрий -cРазвитие : Получить разницу рамок }
   end; // P Is TddParagraphProperty
  except
   FreeAndNil(Result);
   {$IFDEF nsTest}
   raise;
   {$ENDIF nsTest}
  end; // try..except
 end; // OCompare(p) <> 0
end;

procedure TddParagraphProperty.InheriteFrom(P: TddPropertyObject);
var
 i       : Integer;
 l_PAP   : TddParagraphProperty absolute P;
 l_Index : TddParagraphProperties;
begin
 if (P Is TddParagraphProperty) then
 begin
  IsDefault := False;
  for l_Index := Low(TddParagraphProperties) to High(TddParagraphProperties) do
   if (l_PAP.Param[l_Index] <> propUndefined) and (Param[l_Index] <> propUndefined) then
    Param[l_Index] := l_PAP.Param[l_Index];

  f_Border.InheriteFrom(l_PAP.Border);
  f_TabList.Clear;

  for i := 0 to l_PAP.TabList.Hi do
   f_TabList.Add(l_PAP.TabList.Items[i]);
 end // if (P Is TddParagraphProperty) then
 else
  inherited AssignFrom(P);
end;

procedure TddParagraphProperty.SetBooleanProperty(Index: TddParagraphProperties;
        Value: Boolean);
begin
 LongBool(f_LongProperties[Index]):= Value;
 if Index <> dd_InTable then
  IsDefault:= False;
end;

procedure TddParagraphProperty.SetJUST(Value: Tjust);
  { justification  }
begin
  if Value <> Just then
  begin
    f_LongProperties[dd_Just]:= Ord(Value);
    IsDefault:= False;
  end;
end;

procedure TddParagraphProperty.SetLongProperty(Index: TddParagraphProperties;
        Value: Longint);
begin
 if f_LongProperties[Index] <> Value then
 begin
  f_LongProperties[Index]:= Value;
  if Index = dd_Style then
   anInherited := False
  else
   IsDefault := False;
 end;
end;

procedure TddParagraphProperty.SetParam(Index: TddParagraphProperties; Value:
        LongInt);
begin
  f_LongProperties[Index]:= Value;
end;

function TddParagraphProperty.IsDefaultValue(
  anIndex: TddParagraphProperties): Boolean;
begin
 if anIndex = dd_itap then
  Result := GetParam(anIndex) = cnItapDefValue
 else
  if anIndex = dd_iLvl then
   Result := GetParam(anIndex) = cnIlvlDefValue
  else
   Result := GetParam(anIndex) = propUndefined;
end;

end.
