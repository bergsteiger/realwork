unit Format5Reader;

interface

uses
  k2Reader, k2TagGen, l3Base, l3StringList, ddSimpleHTMLReader, l3Date;

type
 TFormat5Reader = class(Tk2CustomFileParser)
 private
  f_Code: string;
  f_Date: Integer;
  f_PubDate: TstDate;
  f_RCode: string;
  f_RDate: Integer;
  f_TokenReaded: Boolean;
  f_Text: Tl3String;
  f_Texts: Tl3StringList;
  function ConvertDate(const aDateStr: string): TstDate;
  procedure FinishDocument;
  procedure LoadTexts;
  function ReadText: Boolean;
  procedure StartDocument;
  procedure WorkBRANCH;
  procedure WorkCTRLCONTACT;
  procedure WorkCTRLDATEBEG;
  procedure WorkCTRLDATEEDIT;
  procedure WorkCTRLDATEEND;
  procedure WorkCTRLDEPART;
  procedure WorkCTRLINSPECTOR;
  procedure WorkCTRLORG;
  procedure WorkCTRLTYPERES;
  procedure WorkDATEORG;
  procedure WorkDATEPUB;
  procedure WorkDATEREG;
  procedure WorkFormat;
  procedure WorkGUIDRBC;
  procedure WorkKIND;
  procedure WorkNAME;
  procedure WorkNGR;
  procedure WorkNUMORG;
  procedure WorkNUMREG;
  procedure WorkORGAN;
  procedure WorkPUBLIC;
  procedure WorkREAL;
  procedure WorkREGION;
  procedure WorkSTATE;
  procedure WorkTEXT;
  procedure WorkTHEME;
  procedure WorkTYPE;
  procedure WorkReserved;
  procedure WorkUND;
  procedure WorkUPDATE;
  procedure WorkupToken;
 protected
  procedure Cleanup; override;
  procedure AddDateNums;
    // internal methods
  procedure Read; override;
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner); override;
 end;

implementation

Uses
 Format5Const, Document_Const, DictItem_Const, k2Tags, l3Const, l3Chars,
 l3StringListPrim, SysUtils, l3DateSt, Dt_Types, NumAndDate_Const,
 Format5HTMLReader;

constructor TFormat5Reader.Create(aOwner: Tk2TagGeneratorOwner);
begin
  inherited Create(aOwner);
  Parser.CheckFloat:= False;
  parser.CheckHex := False;
  Parser.CheckInt := False;
  Parser.LineComment:= ';';
end;

procedure TFormat5Reader.Cleanup;
begin
 inherited;
 FreeAndNil(f_Text);
 FreeAndNil(f_Texts);
end;

procedure TFormat5Reader.FinishDocument;
begin
 Generator.Finish;
end;

procedure TFormat5Reader.AddDateNums;
begin
  Generator.StartTag(k2_tiNumAndDates);
  try
    // Date-Code
    if (f_Date > 0) or (f_Code <> '') then
    begin
     Generator.StartChild(k2_idNumAndDate);
     try
      Generator.AddIntegerAtom(k2_tiType, Ord(dnPublish));
      if f_Date > 0 then
       Generator.AddIntegerAtom(k2_tiStart, f_Date);
      if f_Code <> '' then
       Generator.AddStringAtom(k2_tiNumber, f_Code);
     finally
      Generator.Finish;
     end;
    end; // (f_Date <> 0) or (f_Code <> '')
    // RDate-RCode
    if (f_RDate > 0) or (f_RCode <> '') then
    begin
     Generator.StartChild(k2_idNumAndDate);
     try
      Generator.AddIntegerAtom(k2_tiType, Ord(dnMU));
      if f_RDate > 0 then
       Generator.AddIntegerAtom(k2_tiStart, f_RDate);
      if f_RCode <> '' then
       Generator.AddStringAtom(k2_tiNumber, f_RCode);
     finally
      Generator.Finish;
     end;
    end; // (f_RDate <> 0) or (f_RCode <> '')
  finally
   Generator.Finish;
  end;
end;

function TFormat5Reader.ConvertDate(const aDateStr: string): TstDate;
var
 l_Format: String;
 l_Sep: Char;
begin
 Result:= -1;
 if aDateStr <> '' then
 begin
  Result:= l3DateSt.FlexStr2StDate(aDateStr);
  if Result = -1 then
  begin
   l_Format:= ShortDateFormat;
   l_Sep:= DateSeparator;
   DateSeparator:= '-';
   ShortDateFormat:= 'yyyy-m-d';
   try
    Result:= DateTimeToStDate(StrToDate(aDateStr));
   except
    Result:= -1;
   end;
   ShortDateFormat:= l_Format;
   DateSeparator:= l_Sep;
  end; // Result = -1
 end; // aDateStr <> ''
end;

procedure TFormat5Reader.LoadTexts;
var
 l_Text: Tl3String;
begin
 if f_Texts = nil then
  f_Texts:= Tl3StringList.Make
 else
  f_Texts.Clear;
 Parser.NextTokenSp;
 while (Parser.TokenChar <> chrStartToken) and not Filer.EOF do
 begin
  l_text:= Tl3String.Create;
  try
   l_Text.Append(Parser.TokenChar);
   l_text.Append(Filer.ReadLn);
   f_Texts.Add(l_Text);
  finally
   FreeAndNil(l_Text);
  end;
  Parser.NextTokenSp;
 end;
end;

procedure TFormat5Reader.Read;
begin
 try
  f_TokenReaded:= False;
  Filer.CodePage:= cp_oem;
  StartDocument;
  Parser.NextTokenSp;
  while (not Filer.EOF) do
   WorkupToken;
  FinishDocument;
 except
  raise;
 end;
end;

function TFormat5Reader.ReadText: Boolean;
begin
 Result:= False;
 if f_Text = nil then
  f_Text:= Tl3String.Create
 else
  f_Text.Clear;
 f_Text.CodePage:= CP_OEM;
 Parser.NextTokenSp;
 if Parser.TokenChar <> chrStartToken then
 begin
  f_Text.Append(Parser.TokenChar, 1, cp_OEM);
  f_Text.Append(Filer.ReadLn);
  f_Text.CodePage:= CP_ANSI;
  f_Text.Trim;
  Result:= true;
 end;
end;

procedure TFormat5Reader.StartDocument;
begin
 Generator.StartChild(k2_idDocument);
end;

procedure TFormat5Reader.WorkBRANCH;
var
 i: Integer;
begin
 //  лассификатор
 Filer.ReadLn;
 LoadTexts;
 Generator.StartTag(k2_tiClasses);
 try
  for i:= 0 to f_Texts.hi do
  begin
   Generator.StartChild(k2_idDictItem);
   try
    Generator.AddStringAtom(k2_tiName, f_Texts[i]);
   finally
    Generator.Finish;
   end; { DictItem }
  end; // for i
 finally
  Generator.Finish;
 end;

end;

procedure TFormat5Reader.WorkCTRLCONTACT;
begin
 // TODO -cMM: TFormat5Reader.WorkCTRLCONTACT default body inserted
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkCTRLDATEBEG;
begin
 // TODO -cMM: TFormat5Reader.WorkCTRLDATEBEG default body inserted
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkCTRLDATEEDIT;
begin
 // TODO -cMM: TFormat5Reader.WorkCTRLDATEEDIT default body inserted
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkCTRLDATEEND;
begin
 // TODO -cMM: TFormat5Reader.WorkCTRLDATEEND default body inserted
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkCTRLDEPART;
begin
 // TODO -cMM: TFormat5Reader.WorkCTRLDEPART default body inserted
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkCTRLINSPECTOR;
begin
 // TODO -cMM: TFormat5Reader.WorkCTRLINSPECTOR default body inserted
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkCTRLORG;
begin
 // TODO -cMM: TFormat5Reader.WorkCTRLORG default body inserted
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkCTRLTYPERES;
begin
 // TODO -cMM: TFormat5Reader.WorkCTRLTYPERES default body inserted
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkDATEORG;
begin
 // дата регистрации органе прин€ти€  (date)
 Filer.ReadLn;
 ReadText;
 f_Date:= ConvertDate(f_Text.AsString);
end;

procedure TFormat5Reader.WorkDATEPUB;
begin
 // TODO -cMM: TFormat5Reader.WorkDATEPUB default body inserted
 Filer.ReadLn;
 ReadText;
 f_PubDate:= ConvertDate(f_Text.AsString);
end;

procedure TFormat5Reader.WorkDATEREG;
begin
 // TODO -cMM: TFormat5Reader.WorkDATEREG default body inserted (RDate)
 Filer.ReadLn;
 ReadText;
 f_RDate:= ConvertDate(f_Text.AsString);
end;

procedure TFormat5Reader.WorkFormat;
begin
 Filer.ReadLn;
end;

procedure TFormat5Reader.WorkGUIDRBC;
begin
 // уникальный гуид карточки документа в базе
 WorkReserved;
end;

procedure TFormat5Reader.WorkKIND;
begin
 // вид документа
 Filer.ReadLn;
 ReadText;
 Generator.StartTag(k2_tiTypes);
 try
  Generator.StartChild(k2_idDictItem);
  try
   Generator.AddStringAtom(k2_tiName, f_Text);
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

procedure TFormat5Reader.WorkNAME;
begin
 // название документа
 Filer.ReadLn;
 ReadText;
 Generator.AddStringAtom(k2_tiName, f_text);
end;

procedure TFormat5Reader.WorkNGR;
begin
 // номер государственной регистрации
 Filer.ReadLn;
 ReadText; // Ќомер
end;

procedure TFormat5Reader.WorkNUMORG;
begin
 // номер документа в органе прин€ти€  (Code)
 Filer.ReadLn;
 ReadText;
 f_Code:= f_Text.AsString;
end;

procedure TFormat5Reader.WorkNUMREG;
begin
 // регистрационный номер в ћинюсте (если есть) (Rcode)
 Filer.ReadLn;
 ReadText;
 f_RCode:= f_Text.AsString;
end;

procedure TFormat5Reader.WorkORGAN;
begin
 // орган прин€ти€
 Filer.ReadLn;
 ReadText;
 Generator.StartTag(k2_tiSources);
 try
  Generator.StartChild(k2_idDictItem);
  try
   Generator.AddStringAtom(k2_tiName, f_Text);
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

procedure TFormat5Reader.WorkPUBLIC;
begin
 // TODO -cMM: TFormat5Reader.WorkPUBLIC default body inserted
 Filer.ReadLn;
 ReadText;
end;

procedure TFormat5Reader.WorkREAL;
begin
 Filer.ReadLn;
 Loadtexts;
end;

procedure TFormat5Reader.WorkREGION;
begin
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkSTATE;
begin
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkTEXT;
var
 l_Reader: TFormat5HTMLReader;
begin
 AddDateNums;
 // TODO -cMM: TFormat5Reader.WorkTEXT default body inserted
 Filer.ReadLn;
 l_Reader:= TFormat5HTMLReader.Create();
 try
  l_Reader.CodePage:= cp_oem;
  l_Reader.Generator:= Generator;
  l_Reader.Filer:= Filer;
  l_reader.Execute;
 finally
  FreeAndNil(l_Reader);
 end;
end;

procedure TFormat5Reader.WorkTHEME;
begin
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkTYPE;
begin
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkReserved;
begin
 Filer.ReadLn;
 LoadTexts;
end;

procedure TFormat5Reader.WorkUND;
begin
 //уникальный номер документа равен Ќ√–
 Filer.ReadLn;
 Readtext;
end;

procedure TFormat5Reader.WorkUPDATE;
begin
 // TODO -cMM: TFormat5Reader.WorkUPDATE default body inserted
 Filer.ReadLn;
 Readtext;
end;

procedure TFormat5Reader.WorkupToken;
begin
 while (Parser.TokenChar <> chrStartToken) and not Filer.EOF do
  Parser.NextTokenSp;
 Parser.NextTokenSp;
 if not Filer.EOF then
 begin
  if Parser.TokenSymbolIs(kwdFormat) then  WorkFormat  else
  if Parser.TokenSymbolIs(kwdNGR           ) then WorkNGR else
  if Parser.TokenSymbolIs(kwdGUIDRBC       ) then WorkGUIDRBC else
  if Parser.TokenSymbolIs(kwdUND           ) then WorkUND else
  if Parser.TokenSymbolIs(kwdNAME          ) then WorkNAME else
  if Parser.TokenSymbolIs(kwdKIND          ) then WorkKIND else
  if Parser.TokenSymbolIs(kwdORGAN         ) then WorkORGAN else
  if Parser.TokenSymbolIs(kwdNUMORG        ) then WorkNUMORG else
  if Parser.TokenSymbolIs(kwdNUMREG        ) then WorkNUMREG else
  if Parser.TokenSymbolIs(kwdDATEORG       ) then WorkDATEORG else
  if Parser.TokenSymbolIs(kwdDATEREG       ) then WorkDATEREG else
  if Parser.TokenSymbolIs(kwdBRANCH        ) then WorkBRANCH else
  if Parser.TokenSymbolIs(kwdTHEME         ) then WorkTHEME else
  if Parser.TokenSymbolIs(kwdPUBLIC        ) then WorkPUBLIC else
  if Parser.TokenSymbolIs(kwdDATEPUB       ) then WorkDATEPUB else
  if Parser.TokenSymbolIs(kwdREGION        ) then WorkREGION else
  if Parser.TokenSymbolIs(kwdSTATE         ) then WorkSTATE else
  if Parser.TokenSymbolIs(kwdTYPE          ) then WorkTYPE else
  if Parser.TokenSymbolIs(kwdREAL          ) then WorkREAL else
  if Parser.TokenSymbolIs(kwdCTRLORG       ) then WorkCTRLORG else
  if Parser.TokenSymbolIs(kwdCTRLDEPART    ) then WorkCTRLDEPART else
  if Parser.TokenSymbolIs(kwdCTRLINSPECTOR ) then WorkCTRLINSPECTOR else
  if Parser.TokenSymbolIs(kwdCTRLCONTACT   ) then WorkCTRLCONTACT else
  if Parser.TokenSymbolIs(kwdCTRLDATEEDIT  ) then WorkCTRLDATEEDIT else
  if Parser.TokenSymbolIs(kwdCTRLTYPERES   ) then WorkCTRLTYPERES else
  if Parser.TokenSymbolIs(kwdCTRLDATEBEG   ) then WorkCTRLDATEBEG else
  if Parser.TokenSymbolIs(kwdCTRLDATEEND   ) then WorkCTRLDATEEND else
  if Parser.TokenSymbolIs(kwdUPDATE        ) then WorkUPDATE else
  if Parser.TokenSymbolIs(kwdTEXT          ) then WorkTEXT;
 end;
end;


end.
