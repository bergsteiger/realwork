Unit NSRCPipeBend;

{ $Id: NSRCPipeBend.pas,v 1.44 2015/07/02 11:41:28 lukyanets Exp $ }

// $Log: NSRCPipeBend.pas,v $
// Revision 1.44  2015/07/02 11:41:28  lukyanets
// Описываем словари
//
// Revision 1.43  2013/04/11 16:46:26  lulin
// - отлаживаем под XE3.
//
// Revision 1.42  2005/03/21 17:02:27  lulin
// - используем правильный тип описателя свойства.
//
// Revision 1.41  2004/09/21 12:21:04  lulin
// - Release заменил на Cleanup.
//
// Revision 1.40  2004/09/13 14:21:49  lulin
// - избавился от зависимости от RX.
//
// Revision 1.39  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//
// Revision 1.38  2001/04/27 07:52:44  narry
// Update - добавлен метод CloseStream
//
// Revision 1.37  2001/03/28 13:46:02  narry
// Добавлен флажок, управляющий выливкой RTF файл
//
// Revision 1.36  2001/03/14 13:24:53  law
// - some cleaup and tuning.
//
// Revision 1.35  2001/03/05 14:34:59  narry
// Add empty paragraph after rtf-block
//
// Revision 1.34  2001/02/05 13:41:28  narry
// Coding for Block Name
//
// Revision 1.33  2000/12/19 16:05:18  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.32  2000/12/19 15:06:26  law
// - #13#10 -> cc_EOL.
//
// Revision 1.31  2000/12/15 15:29:53  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

Uses
  l3Types, l3Filer, l3Base,
  k2TagGen,
  evStrGen, evTypesE,
  ddRTFwriter, daTypes,
  dt_Const;

type
  TddBlockPipe = class(Tl3Base)
  private
    f_RTFGen: TevRTFObjectGenerator;
    f_Filer: TevDOSFiler;
    f_BendOpened: Boolean;
    f_ExtNum: Longint;
    f_InnerBlocks: Longint;
    f_Started: Boolean;
    f_ExportDir: AnsiString;
    f_SubDir : AnsiString;
    EnableWrite: Boolean;
    DontWrite: Boolean;
    f_BlockName: Tl3String;
    f_BlockNo: Long;
    f_DictRecType: TdaDictionaryType;
    f_Belongs: Tl3String;
    f_BelongsDone: Boolean;

    f_ObjFiler: TevDOSFiler;
    f_AdditionalFile: TevDOSFiler;

    f_PipeBend: TevTagFilter;
    f_WriteRTFBody : Boolean;
  protected
    procedure OpenBend;
    procedure CloseBend;
    function Check4OpenBend(AtomIndex: Long; const Value: TevVariant): Boolean;
    function GetExternalHandle: Longint;
    function RTFFileName: AnsiString;
    procedure StartRTF;
    procedure Cleanup; override;
  public
    constructor Create(aOwner: TObject); override;


    procedure BeforeStartChildEx(TypeID: Long; IsDefault: Bool = false);
    procedure AfterStartChildEx(TypeID: Long; IsDefault: Bool = false);
      {-}
    procedure AddAtomEx(AtomIndex: Long; const Value: TevVariant);
      {-}
    procedure StartTag(TagID: Long);
      {-}
    procedure BeforeCloseStructure(NeedUndo: Bool);
    procedure AfterCloseStructure(NeedUndo: Bool);

    property ExportDir: AnsiString
      read f_ExportDir write f_ExportDir;
    property WriteRTFBody : Boolean
      read f_WriteRTFBody write f_WriteRTFBody;
  end;

  TddPipeBend = class(TevTagFilter)
  private
    f_ObjFiler: TevDOSFiler;
    f_AdditionalFile: TevDOSFiler;
    f_ObjPipes: Tl3VList;
    f_ExportDir: AnsiString;
    f_DictRecType: TdaDictionaryType;
    f_Belongs: Tl3String;
    f_BelongsDone: Boolean;
    f_SubDir : AnsiString;
    f_SeparateFiles: Boolean;
    f_WriteRTFBody : Boolean;
  protected
    procedure Cleanup; override;
    procedure CloseStream(NeedUndo: Bool); override;
    procedure CloseStructure(NeedUndo: Bool); override;
  public
    constructor Create(anOwner: Tk2TagGeneratorOwner); override;

    procedure StartChild(TypeID: Long; IsDefault: Bool = false); override;
      {-}
    procedure AddAtomEx(AtomIndex: Long; const Value: TevVariant); override;
      {-}
    procedure StartTag(TagID: Long); override;
      {-}
    

    

    property ExportDir: AnsiString
      read f_ExportDir write f_ExportDir;
    property SeparateFiles: Boolean
      read f_SeparateFiles write f_SeparateFiles;
    property WriteRTFBody : Boolean
      read f_WriteRTFBody write f_WriteRTFBody;
  end;

implementation

uses
  SysUtils,
  evSegLst, evStyles,
  l3Stream, l3Bits, l3Chars,
  k2Tags, k2Base,
  ddNSRC_w,
  Str_Man
  ;

{----------TddPipeBend.-----------------}
constructor TddBlockPipe.Create(aOwner: TObject);
begin
  inherited;
  f_RTFGen:= TevRTFObjectGenerator.Create(nil);
  f_Filer:= TevDOSFiler.Create(nil);
  f_Filer.Mode:= l3_fmWrite;
  f_RTFGen.Filer:= f_Filer;
  f_BendOpened:= False;
  EnableWrite:= False;
  DontWrite:= False;
  f_Belongs:= Tl3String.Create(nil);
  f_BlockNo:= -1;
  f_WriteRTFBody:= False;
end;

procedure TddBlockPipe.Cleanup;
begin
  if f_BendOpened then
    CloseBend;
  l3Free(f_RTFGen);
  l3Free(f_Filer);
  l3Free(f_Belongs);
  l3FRee(f_BlockName);
  inherited;
end;

procedure TddBlockPipe.BeforeStartChildEx(TypeID: Long; IsDefault: Bool = false);
var
  S: Tl3String;
begin
  if TypeID = k2_idDocument then
  begin
    f_ExtNum:= 0;
    f_Started:= False;
    f_Belongs.Clear;
    f_DictRecType := da_dlNone;
    f_BelongsDone:= False;
  end;

  if f_BendOpened and EnableWrite and (TypeID = k2_idTextPara) then
  begin
    if f_BlockName = nil then
    begin
      f_BlockName:= Tl3String.Create(nil);
      f_BlockName.AsString:= Format('Блок N%d', [GetExternalHandle]);
      f_BlockName.CodePage:= cp_OEM;
    end;

    EnableWrite:= False;
    DontWrite:= True;
    S:= Tl3String.Create(nil);
    try
      S.AsString:= 'См. данную форму в редакторе MS-Word';
      f_PipeBend.StartChild(k2_idTextPara);
      try
        f_PipeBend.AddBoolAtom(k2_tiVisible, False);
        f_PipeBend.AddIntegerAtom(k2_tiStyle, ev_saTxtComment);
        { Сгенерить ссылки }
        f_PipeBend.StartTag(k2_tiSegments);
        try
          f_PipeBend.StartChild(k2_idSegmentsLayer);
          try
            f_PipeBend.AddIntegerAtom(k2_tiHandle, ev_slHyperlinks);
            f_PipeBend.StartChild(k2_idHyperlink);
            try
              f_PipeBend.AddIntegerAtom(k2_tiHandle, 1); {<-- Это все на всякий случай }
              f_PipeBend.AddIntegerAtom(k2_tiStart, 12);
              f_PipeBend.AddIntegerAtom(k2_tiFinish, 16);
              f_PipeBend.StartChild(k2_idAddress);
              try
                f_PipeBend.AddIntegerAtom(k2_tiDocID, GetExternalHandle);
              finally
                f_PipeBend.Finish;
              end; { k2_idAddress}
            finally
              f_PipeBend.Finish;
            end; { k2_Hyperlink }
          finally
            f_PipeBend.Finish;
          end; { k2_idSegmentsLayer }
        finally
          f_PipeBend.Finish;
        end; { k2_tiSegments }
        f_PipeBend.AddStringAtom(k2_tiText, S);
      finally
        f_PipeBend.Finish;
      end; { k2_idTextPara }
      f_PipeBend.StartChild(k2_idTextPara);
      f_PipeBend.Finish;
    finally
      l3Free(S);
    end;
    DontWrite:= False;
  end;
end;

procedure TddBlockPipe.AfterStartChildEx(TypeID: Long; IsDefault: Bool = false);
var
  S: Tl3String;
begin

  if f_PipeBend.CurrentType.InheritsFrom(k2_idBlock) and f_BendOpened then
    inc(f_InnerBlocks);
//  Check4OpenBend;
  if WriteRTFBody and f_BendOpened and not DontWrite then
  begin
    if not f_Started then
      StartRTF;
    f_RTFGen.StartChild(TypeID, IsDefault);
  end;

end;

procedure TddBlockPipe.AddAtomEx(AtomIndex: Long; const Value: TevVariant);
  {-}
begin

  if f_PipeBend.CurrentType.InheritsFrom(k2_idBlock) and not f_PipeBend.CurrentType.InheritsFrom(k2_idDOcument) then
    if (AtomIndex = k2_tiShortName) and (f_BlockName = nil)then
    begin
      f_BlockName:= Tl3String.Make(nil, Tl3String(Value.AsString));
    end
    else
    if (AtomIndex = k2_tiHandle) and (f_BlockNo = -1) then
      f_BlockNo:= Value.AsInteger;

  if Check4OpenBend(AtomIndex, Value) then
    OpenBend;


  if WriteRTFBody and f_BendOpened and not DontWrite  then
  begin
    if not f_Started then
      StartRTF;
    f_RTFGen.AddAtomEx(AtomIndex, Value);
  end;
end;

procedure TddBlockPipe.StartTag(TagID: Long);
  {-}
begin
  inherited;
//  Check4OpenBend;
  if WriteRTFBody and f_BendOpened and not DontWrite  then
  begin
    if not f_Started then
      StartRTF;
    f_RTFGen.StartTag(TagID);
  end;
end;

procedure TddBlockPipe.BeforeCloseStructure(NeedUndo: Bool);
begin
  if f_PipeBend.CurrentType.InheritsFrom(k2_idBlock) and not f_PipeBend.CurrentType.InheritsFrom(k2_idDocument) then
  begin
    if f_BendOpened then
    begin
      Dec(f_InnerBlocks);
      if f_InnerBlocks = -1 then
        CloseBend;
    end;
  end;
end;

procedure TddBlockPipe.AfterCloseStructure(NeedUndo: Bool);
begin
  if WriteRTFBody and f_BendOpened and not DontWrite  then
  begin
    //f_RTFGen.CloseStructure(NeedUndo);
    f_RTFGen.Finish;
  end;
end;

procedure TddBlockPipe.OpenBend;
begin
//  inc(f_ExtNum);
  ForceDirectories(ConcatDirName(ExportDir, f_SubDir));
  f_Filer.FileName:= ConcatDirName(ConcatDirName(ExportDir, f_SubDir), RTFFileName);
  f_Started:= False;

//  StartRTF;

  f_InnerBlocks:= 0;
  f_BendOpened:= True;
end;

procedure TddBlockPipe.StartRTF;
begin
 if WriteRTFBody then
 begin
  f_RTFGen.Start;
  f_RTFGen.StartChild(k2_idDocument);
  f_Started:= True;
 end;
end;

procedure TddBlockPipe.CloseBend;
var
  S: Tl3String;
//  NSRCGen: TddNSRCGenerator;

  st, st2: AnsiString;
procedure WriteName(aName: AnsiString);
var
  S: AnsiString;
  i,j: Integer;
begin
  if aName = '' then
    exit;
  i:= 1;
  s:= '';
  j:= 0;
  if Length(aName) > 73 then
    while i < Length(aName) do
    begin
      while (j <= 73) and (i <= Length(aName)) do
      begin
        S:= S + aName[i];
        inc(i); inc(j);
      end;

      if (i < Length(aName)) and (aName[i] <> ' ') then
      begin
        while (S[Length(S)] <> ' ') do
        begin
          dec(i);
          Delete(s, length(S), 1);
        end;
      end
      else
        inc(i);
      f_ObjFiler.Write(Format('!NAME %s'+cc_EOL, [S]));
      S:= '';
      j:= 0;
    end
  else
    f_ObjFiler.Write(Format('!NAME %s'+cc_EOL, [aName]));
end;

begin
  if WriteRTFBody then
  begin
    f_RTFGen.Finish;
    f_RTFGen.Finish;
  end;
  f_BendOpened:= False;
  f_Started:= False;
  { По окончании заливки генерируем дополнительный NSRC и добавляем в исходный
  поток дополнительные строки }

  { Теперь генерим новый файл }
  S:= Tl3String.Create(nil);
  try
    S.CodePage:= cp_OEM;

    try
      if not f_ObjFiler.Opened then
      begin
        f_ObjFiler.FileName:= ConcatDirName(ConcatDirName(ExportDir, f_SubDir), 'objtopic.nsr');
        f_ObjFiler.Mode:= l3_fmWrite;
        f_ObjFiler.CodePage:= cp_OEM;
        f_ObjFiler.Open;

        f_AdditionalFile.FileName:= ConcatDirName(ConcatDirName(ExportDir, f_SubDir), 'comment.txt');
        f_AdditionalFile.Mode:= l3_fmWrite;
        f_AdditionalFile.CodePage:= cp_OEM;
        f_AdditionalFile.Open;

      end;

      S.AsString:= Format(';!BLOCK %d'+cc_EOL, [f_BlockNo]);
      f_ObjFiler.Write(S);

      S.AsString:= Format('!!!SUB %d'+cc_EOL, [f_BlockNo]);
      f_AdditionalFile.Write(S);
      S.Codepage:= cp_ANSI;
      S.AsString:= Format(#5#3'См. данную '#4'форму'#4'%d'#4' в редакторе MS-Word'#3#5+cc_EOL+'___'+cc_EOL, [GetExternalHandle]);
      S.CodePage:= cp_OEM;
      f_AdditionalFile.Write('!STYLE J 1 72 1'+cc_EOL);
      f_AdditionalFile.Write(S);

      st2:= f_BlockName.AsString;
      f_BlockName.CodePage:= cp_Ansi;
      f_BlockName.MakeUpper;
      f_BlockName.CodePage:= cp_OEM;

      if f_BlockName.Len > 70 then
      begin
        St:= System.Copy(f_BlockName.AsString, 1, 70)+'...';
      end
      else
        St:= f_BlockName.AsString;
      //St:= LowerCase(St);



      S.AsString:= Format('!OBJTOPIC %d %s'+cc_EOL, [GetExternalHandle, St]);
      f_ObjFiler.Write(S);

      WriteName(st2);
      S.AsString:= Format('!BELONGS %s'+cc_EOL, [f_Belongs.AsString]);
      f_ObjFiler.Write(S);
      S.AsString:= '!OBJTYPE RTF'+cc_EOL;
      f_ObjFiler.Write(S);
      S.AsString:= Format('!OBJPATH %s'+cc_EOL+cc_EOL, [ConcatDirName(f_SubDir, RTFFileName)]);
      f_ObjFiler.Write(S);
    except
      l3System.msg2Log('Ошибка выливки OBJTOPIC');
    end;{ Filer }
  finally
    l3Free(S);
  end;
  l3Free(f_BlockName);
end;

function TddBlockPipe.Check4OpenBend(AtomIndex: Long; const Value: TevVariant): Boolean;
var
  T: Tk2Type;
begin
  if f_BendOpened then
    exit;
  f_BendOpened:= False;
  T:= f_PipeBend.CurrentType;
  if T.InheritsFrom(k2_idBlock) and not T.InheritsFrom(k2_idDocument)
//             and (AtomIndex = k2_tiHandle) and (Value.AsInteger = 123);
           and (AtomIndex = k2_tiExternalHandle) then
  begin
    Result:= True;
    f_ExtNum:= Value.AsInteger;
    EnableWrite:= True;
  end
  else
    Result:= False;
end;

function TddBlockPipe.GetExternalHandle: Longint;
begin
  Result:= f_ExtNum;
end;

function TddBlockPipe.RTFFileName: AnsiString;
begin
  Result:= Format('%d.rtf', [GetExternalHandle]);
end;


{  TddPipeBend }

constructor TddPipeBend.Create(anOwner: Tk2TagGeneratorOwner);
begin
  inherited;
  f_ObjPipes:= Tl3VList.Create(nil);
  f_Belongs:= Tl3String.Create;
  f_ObjFiler:= TevDOSFiler.Create(nil);
  f_AdditionalFile:= TevDOSFiler.Create(nil);
  f_WriteRTFBody:= False;
end;

procedure TddPipeBend.Cleanup;
begin
  l3Free(f_Belongs);
  l3Free(f_ObjPipes);
  l3Free(f_ObjFiler);
  l3Free(f_AdditionalFile);
  inherited;
end;

procedure TddPipeBend.CloseStream(NeedUndo: Bool);
var
  i: Integer;
begin
  (*for i:= 0 to f_ObjPipes.Hi do
  begin
    TddBlockPipe(f_ObjPipes.Items[i]).BeforeCloseStructure
  end;
 *) f_ObjPipes.Clear;
  f_Belongs.Clear;
  f_WriteRTFBody:= False;
  inherited;
end;


procedure TddPipeBend.StartChild(TypeID: Long; IsDefault: Bool = false);
var
  i: Integer;
  BP: TddBlockPipe;
begin
  for i:= 0 to f_ObjPipes.Hi do
    TddBlockPipe(f_ObjPipes.Items[i]).BeforeStartChildEx(TypeID, IsDefault);
  inherited;

  if CurrentType.InheritsFrom(k2_idBlock) and not CurrentType.InheritsFrom(k2_idDocument) then
  begin
    BP:= TddBlockPipe.Create(nil);
    try
      BP.WriteRTFBody:= WriteRTFBody;
      BP.f_ExportDir:= ExportDir;
      BP.f_SubDir:= f_SubDir;
      BP.f_Belongs.Assign(f_Belongs);
      BP.f_PipeBend:= Self;
      BP.f_ObjFiler:= f_ObjFiler;
      BP.f_AdditionalFile:= f_AdditionalFile;
      f_ObjPipes.Add(TObject(BP));
    finally
      l3Free(BP);
    end;
  end;

  for i:= 0 to f_ObjPipes.Hi do
    TddBlockPipe(f_ObjPipes.Items[i]).AfterStartChildEx(TypeID, IsDefault);
 try
  if CurrentType.InheritsFrom(k2_idDictRec) and (f_DictRecType = da_dlBases) and (TopObject[1] <> nil) and (Ik2Property(TopObject[1]).TagIndex <> k2_tiGroups) then
  begin
    if f_Belongs.Ch[0] = '\' then
      f_Belongs.Delete(0,1);
    //LS(Format('!%s %s', [kwdBelongs, f_Belongs.AsString]));
    f_BelongsDone:= True;
  end;
  If CurrentType.InheritsFrom(k2_idDictRec) and (TopObject[1] is Ik2Property) then
  Begin
   if Ik2Property(TopObject[1]).TagIndex = k2_tiGroups then
     begin
       if f_DictRecType <> da_dlBases then
       begin
         f_Belongs.Clear;
         f_DictRecType:=da_dlBases;
       end;
     end;
   end;
 except
 end;
end;
  {-}

procedure TddPipeBend.AddAtomEx(AtomIndex: Long; const Value: TevVariant);
var
  i: Integer;
begin
  inherited;
  if CurrentType.InheritsFrom(k2_idDocument) and (AtomIndex = k2_tiExternalHandle) then
    f_SubDir:= IntToStr(Value.AsInteger);


  if CurrentType.InheritsFrom(k2_idBlock) and not CurrentType.InheritsFrom(k2_idDocument) and (f_ObjPipes.Count > 0) then
    TddBlockPipe(f_ObjPipes.Items[f_ObjPipes.Hi]).AddAtomEx(AtomIndex, Value)
  else
    for i:= 0 to f_ObjPipes.Hi do
      TddBlockPipe(f_ObjPipes.Items[i]).AddAtomEx(AtomIndex, Value);

  If CurrentType.InheritsFrom(k2_idDictRec) then {заполнение записи: элемент словаря}
  Begin
    If (AtomIndex = k2_tiShortName) then
     If (Value.Kind=ev_tkString) then
     begin
      if (f_DictRecType = da_dlBases) and not (f_BelongsDone) then
      begin
        f_Belongs.Append('\');
        f_Belongs.JoinWith(Value.AsString, nil);
      end;
     end
     else
      ConvertErrorEx(Value.Kind);
  end;
end;

procedure TddPipeBend.StartTag(TagID: Long);
var
  i: Integer;
begin
  inherited;
  for i:= 0 to f_ObjPipes.Hi do
    TddBlockPipe(f_ObjPipes.Items[i]).StartTag(TagID);
end;
  {-}

procedure TddPipeBend.CloseStructure(NeedUndo: Bool);
var
  i: Integer;
  NeedCheck: Boolean;
begin
  for i:= 0 to f_ObjPipes.Hi do
    TddBlockPipe(f_ObjPipes.Items[i]).BeforeCloseStructure(NeedUndo);

  NeedCheck:= CurrentType.InheritsFrom(k2_idBlock);
  {
  if CurrentType.InheritsFrom(k2_idDocument) and f_ObjFiler.Opened then
    f_ObjFiler.Close;
  }
  inherited;
  for i:= 0 to f_ObjPipes.Hi do
    TddBlockPipe(f_ObjPipes.Items[i]).AfterCloseStructure(NeedUndo);
  { Проверить закрытые  трубы и  уничтожить их }

  if NeedCheck and (f_ObjPipes.Count > 0) then
  begin

    if not TddBlockPipe(f_ObjPipes.Items[f_ObjPipes.Hi]).f_BendOpened then
        f_ObjPipes.Delete(f_ObjPipes.Hi)

  end;

end;

end.
