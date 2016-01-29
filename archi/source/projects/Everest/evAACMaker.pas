unit evAACMaker;

interface

uses
 k2Prim,
 k2Interfaces,

 dt_Types,

 ddCSV,

 Classes,

 nevBase,

 evEditor,

 l3ProtoObject;

type
 TaacListType = (aacTypeDoc, aacOrgan, aacParticipants);

 TevAACMaker = class(Tl3ProtoObject)
 private
  f_SourceFileName : string;
   {-}
  f_Source         : TddCSV;
   {-}
  f_WasInit        : Boolean;
   {-}
  f_DocDate        : TDateTime;
   {-}
  f_Number         : string;
   {-}
  f_LawCaseNumber  : string;
   {-}
  f_PartTypes      : TStrings;
   {-}
  f_PartNames      : TStrings;
   {-}
  f_Court          : string;
   {-}
  f_Type           : string;
   {-}
  f_Editor         : TevEditor;
   {-}
 private
  function Get_Source: TddCSV;
   {-}
  procedure AddDateNumbers(aDocument: Tl3Variant; const anOp: InevOp);
   {-}
  procedure AddParticipants(const aDocument: Tl3Variant; const anOp: InevOp);
   {-}
  procedure AddSource(const aDocument: Tl3Variant; const anOp: InevOp);
   {-}
  procedure AddType(const aDocument: Tl3Variant; const anOp: InevOp);
   {-}
  function GetPartType(aParticipant: Integer): TlcParticipantType;
   {-}
  procedure AddData(aDocument: Tl3Variant; const anOp: InevOp);
   {* - Сгенерировать информацию о постановлениях AAC. }
  procedure ReadTypeAndSource(const aDocument: Tl3Variant);
   {-}
  procedure ReadDateNumbers(const aDocument: Tl3Variant);
   {-}
  procedure ReadParticipants(const aDocument: Tl3Variant);
   {-}
  procedure ReadData(const aDocument: Tl3Variant);
   {* - Считать данные для карточки. }
 protected
  procedure CleanUp; override;
   {-}
 public
  constructor Create; reintroduce;
   {-}
  procedure InitList(const aList: TStrings; aListType: TaacListType; var aDefaultIndex: Integer);
   {-}
  procedure CheckAndApply;
   {* - Проверка данных. }
  function InitData(const anEditor: TevEditor): Boolean;
   {* - Загрузить данные. }
 public
  property DocType: string read f_Type write f_Type;
   {-}
  property Court: string read f_Court write f_Court;
   {-}
  property DocDate : TDateTime read f_DocDate write f_DocDate;
   {-}
  property Number : string read f_Number write f_Number;
   {-}
  property LawCaseNumber : string read f_LawCaseNumber write f_LawCaseNumber;
   {-}
  property PartTypes : TStrings read f_PartTypes write f_PartTypes;
   {-}
  property PartNames : TStrings read f_PartNames write f_PartNames;
   {-}
 end;

implementation

uses
 k2Tags,
 k2Base,

 l3Base,
 l3Date,
 l3Chars,
 l3String,
 l3Interfaces,

 Dialogs,
 Forms,
 Controls,

 evNative_Schema,
 evdNative_Schema,

 Document_Const,
 NumANDDate_Const,
 Participant_Const,
 DictItem_Const,

 ddAAC,
 ddParticipantsConst,
 ddParticipantsUtils,

 SysUtils, Grids;

const
 cnForDisplay = 0;
 cnForStorage = 1; 

{ TevAACMaker }

procedure TevAACMaker.AddData(aDocument: Tl3Variant; const anOp: InevOp);
begin
 AddType(aDocument, anOp);
 AddSource(aDocument, anOp);
 AddDateNumbers(aDocument, anOp);
 AddParticipants(aDocument, anOp);
 anOp.MarkModified(aDocument);
end;

procedure TevAACMaker.AddDateNumbers(aDocument: Tl3Variant; const anOp: InevOp);
var
 l_NumAndDates : Tl3Variant;
 l_NumANDDate  : Tl3Variant;
begin
 l_NumAndDates := aDocument.cAtom(k2_tiNumAndDates);
 if l_NumAndDates.ChildrenCount = 0 then
 begin
  l_NumANDDate := k2_typNumANDDate.MakeTag.AsObject;
  l_NumAndDates.AddChild(l_NumANDDate);
 end // if l_NumAndDates.ChildrenCount = 0 then
 else
  l_NumANDDate := l_NumAndDates.Child[0];
 l_NumANDDate.IntW[k2_tiType, anOp] := Ord(dnLawCaseNum);
 l_NumANDDate.StrW[k2_tiNumber, anOp] := f_LawCaseNumber;

 if l_NumAndDates.ChildrenCount = 1 then
 begin
  l_NumANDDate := k2_typNumANDDate.MakeTag.AsObject;
  l_NumAndDates.AddChild(l_NumANDDate);
 end // if l_NumAndDates.ChildrenCount = 1 then
 else
  l_NumANDDate := l_NumAndDates.Child[1];
 l_NumANDDate.IntW[k2_tiType, anOp] := Ord(dnPublish);
 l_NumANDDate.IntW[k2_tiStart, anOp] := DateTimeToStDate(f_DocDate);
 l_NumANDDate.StrW[k2_tiNumber, anOp] := f_Number;
end;

procedure TevAACMaker.AddParticipants(const aDocument: Tl3Variant; const anOp: InevOp);
var
 i              : Integer;
 l_ParticItem   : Tl3Variant;
 l_Participants : Tl3Variant;
begin
 aDocument.AttrW[k2_tiCaseDocParticipants, anOp] := nil;
 l_Participants := aDocument.cAtom(k2_tiCaseDocParticipants);
 for i := 0 to f_PartTypes.Count - 1 do
 begin
  l_ParticItem := k2_typParticipant.MakeTag.AsObject;
  l_Participants.AddChild(l_ParticItem);
  l_ParticItem.StrW[k2_tiName, anOp] := f_PartNames.Strings[i];
  l_ParticItem.IntW[k2_tiType, anOp] := Ord(GetPartType(i));
 end; // for i:= 0 to f_PartTypes.Count - 1 do
end;

procedure TevAACMaker.AddSource(const aDocument: Tl3Variant; const anOp: InevOp);
var
 i          : Integer;
 l_Index    : Integer;
 l_Source   : Tl3Variant;
 l_DictItem : Tl3Variant;
begin
 l_Source := aDocument.cAtom(k2_tiSources);
 if l_Source.ChildrenCount = 0 then
 begin
  l_DictItem := k2_typDictItem.MakeTag.AsObject;
  l_Source.AddChild(l_DictItem);
 end
 else
  l_DictItem := l_Source.Child[0];

 for i := 0 to f_Source.RowCount - 1 do
  if f_Source.AsString(i, cnForDisplay, CP_DefaultValue) = f_Court then
  begin
   l_Index := i;
   Break;
  end;  
 Assert(l_Index > -1);
 l_DictItem.StrW[k2_tiName, anOp] := f_Source.AsString(l_Index, cnForStorage, CP_DefaultValue);
end;

procedure TevAACMaker.AddType(const aDocument: Tl3Variant; const anOp: InevOp);
var
 l_Types    : Tl3Variant;
 l_DictItem : Tl3Variant;
begin
 l_Types := aDocument.cAtom(k2_tiTypes);
 if l_Types.ChildrenCount = 0 then
 begin
  l_DictItem := k2_typDictItem.MakeTag.AsObject;
  l_Types.AddChild(l_DictItem);
 end
 else
  l_DictItem := l_Types.Child[0];
 l_DictItem.StrW[k2_tiName, anOp] := f_Type;
end;

procedure TevAACMaker.CheckAndApply;
var
 l_Op : InevOp;
begin
 l_Op := f_Editor.TextSource.StartOp;
 try
  AddData(f_Editor.Document.AsObject, l_Op);
 finally
  l_Op := nil;
 end;
end;

procedure TevAACMaker.CleanUp;
begin
 f_Editor := nil;
 l3Free(f_Source);
 l3Free(f_PartNames);
 l3Free(f_PartTypes);
 f_WasInit := False;
 inherited;
end;

constructor TevAACMaker.Create;
begin
 f_SourceFileName := ExtractFilePath(Application.ExeName) + 'source.csv';
 f_WasInit := False;
 f_PartNames := TStringList.Create;
 f_PartTypes := TStringList.Create;
end;

function TevAACMaker.GetPartType(
  aParticipant: Integer): TlcParticipantType;
begin
 Result:= StrToParticipantType(f_PartTypes.Strings[aParticipant]);
end;

function TevAACMaker.Get_Source: TddCSV;
begin
 if f_Source = nil then
  f_Source := TddCSV.Create(2);
 Result := f_Source;
end;

function TevAACMaker.InitData(const anEditor: TevEditor): Boolean;
begin
 if not FileExists(f_SourceFileName) then
 begin
  ShowMessage('Файл "source.csv" не найден! Работа с постановлениями невозможна!');
  Result := False;
  Exit;
 end; // if not FileExists(f_SourceFileName) then
 f_Editor := anEditor;
 Get_Source.Load(f_SourceFileName);
 f_WasInit := True;
 ReadData(f_Editor.Document.AsObject);
 Result := True;
end;

procedure TevAACMaker.InitList(const aList: TStrings;
  aListType: TaacListType; var aDefaultIndex: Integer);
var
 i           : Integer;
 l_IndexPars : TlcParticipantType;
begin
 Assert(f_WasInit);
 aDefaultIndex := -1;
 aList.Clear;
 case aListType of
  aacTypeDoc: begin
   aList.Add('Постановление');
   aList.Add('Определение');
   aDefaultIndex := 0;
  end;
  aacOrgan: begin
   for i := 0 to f_Source.RowCount - 1 do
    aList.Add(f_Source.AsString(i, cnForDisplay, CP_DefaultValue));
  end;
  aacParticipants:
   for l_IndexPars := Low(TlcParticipantType) to High(TlcParticipantType) do
    aList.Add(cParticipants[l_IndexPars]);
 end; // case aListType of
end;

procedure TevAACMaker.ReadData(const aDocument: Tl3Variant);
begin
 ReadTypeAndSource(aDocument);
 ReadDateNumbers(aDocument);
 ReadParticipants(aDocument);
end;

procedure TevAACMaker.ReadDateNumbers(const aDocument: Tl3Variant);
var
 i             : Integer;
 l_NumAndDates : Tl3Variant;
 l_NumANDDate  : Tl3Variant;
begin
 f_DocDate := Date;
 f_Number := '';
 f_LawCaseNumber := '';
 l_NumAndDates := aDocument.Attr[k2_tiNumAndDates];
 if l_NumAndDates.IsValid then
 begin
  if l_NumAndDates.ChildrenCount > 0 then
  begin
   for i := 0 to l_NumAndDates.ChildrenCount - 1 do
   begin
    l_NumANDDate := l_NumAndDates.Child[i];
    case l_NumANDDate.IntA[k2_tiType] of
     Ord(dnPublish): begin
         f_DocDate := StDateToDateTime(l_NumANDDate.IntA[k2_tiStart]);
         f_Number := l_NumANDDate.StrA[k2_tiNumber];
       end;
     Ord(dnLawCaseNum): f_LawCaseNumber := l_NumANDDate.StrA[k2_tiNumber];
    end;
   end; // for i := 0 to l_NumAndDates.ChildrenCount - 1 do
  end; // if l_NumAndDates.ChildrenCount > 0 then
 end; // if not l_NumAndDateTag.IsValid then
end;

procedure TevAACMaker.ReadParticipants(const aDocument: Tl3Variant);
var
 i              : Integer;
 l_ParticItem   : Tl3Variant;
 l_Participants : Tl3Variant;
begin
 l_Participants := aDocument.Attr[k2_tiCaseDocParticipants];
 f_PartNames.Clear;
 f_PartTypes.Clear;
 if l_Participants.IsValid then
 begin
  for i := 0 to l_Participants.ChildrenCount - 1 do
  begin
   l_ParticItem := l_Participants.Child[i];
   f_PartNames.Add(l_ParticItem.StrA[k2_tiName]);
   f_PartTypes.Add(cParticipants[TlcParticipantType(l_ParticItem.IntA[k2_tiType])]);
  end; // for i:= 0 to f_PartTypes.Count - 1 do
 end; // if l_Participants.IsValid then
end;

procedure TevAACMaker.ReadTypeAndSource(const aDocument: Tl3Variant);
var
 i          : Integer;
 l_Court    : string;
 l_Types    : Tl3Variant;
 l_DictItem : Tl3Variant;
 l_Source   : Tl3Variant;
begin
 f_Type := '';
 l_Types := aDocument.Attr[k2_tiTypes];
 if l_Types.IsValid then
 begin
  if l_Types.ChildrenCount > 0 then
  begin
   l_DictItem := l_Types.Child[0];
   if l_DictItem.IsValid then
    f_Type := l_DictItem.StrA[k2_tiName]
  end; // if l_Types.ChildCount > 0 then
 end; // if l_Types.IsValid then
 l_Source := aDocument.Attr[k2_tiSources];
 if l_Source.IsValid then
 begin
  if l_Source.ChildrenCount > 0 then
  begin
   l_DictItem := l_Source.Child[0];
   if l_DictItem.IsValid then
   begin
    l_Court := l_DictItem.StrA[k2_tiName];
    for i := 0 to f_Source.RowCount - 1 do
     if f_Source.AsString(i, cnForStorage, CP_DefaultValue) = l_Court then
     begin
      f_Court := f_Source.AsString(i, cnForDisplay, CP_DefaultValue);
      Break;
     end; // if f_Source.AsString(i, cnForStorage, CP_DefaultValue) = l_Court then
   end;
  end; // if l_Types.ChildCount > 0 then
 end; // if l_Source.IsValid then
end;

end.
