unit ObamReader;

interface
uses
 k2Reader, l3Types;


type
 TObamReader = class(Tk2CustomFileReader)
 private
  f_DocPath: string;
  f_ErrorCount: Integer;
  f_OnProgress: Tl3ProgressProc;
  f_TopicNo: LongWord;
  procedure pm_SetDocPath(const Value: string);
  procedure Progress(aState     : Byte; aValue     : Long; const aMsg : String);
 public
  procedure Read; override;
  property DocPath: string read f_DocPath write pm_SetDocPath;
  property ErrorCount: Integer read f_ErrorCount;
  property TopicNo: LongWord read f_TopicNo write f_TopicNo;
  property OnProgress: Tl3ProgressProc read f_OnProgress write f_OnProgress;
 end;

implementation
uses
 Classes,
 SysUtils,

 l3Base,
 l3Interfaces,
 l3String,
 l3Date,
 l3LingLib,
 l3Filer,

 k2Tags,
 k2TagGen,
 Document_Const,

 evTypes,
 nevPersistentDocumentContainer,
 evExtFormat,
 evNestedDocumentEliminator,


 ddRTFReader,
 ddDocReader,
 ddCSV,

 DT_Types, TextPara_Const, evdStyles;

const
 rc_Type     = 0;
 rc_Source   = 1;
 rc_Number   = 2;
 rc_Date     = 3;
 rc_Name     = 4;
 rc_DocFN    = 16;

procedure TObamReader.pm_SetDocPath(const Value: string);
begin
 if Value <> '' then
  f_DocPath := IncludeTrailingBackslash(Value)
 else
  f_DocPath := ''; 
end;

procedure TObamReader.Progress(aState: Byte; aValue: Long; const aMsg : String);
begin
 if Assigned(f_OnProgress) then
  f_OnProgress(aState, aValue, aMsg);
end;

procedure TObamReader.Read;
var
 l_CSV: TddCSV;
 l_DocReader: TddDocReader;
 l_NestedFilter: TevNestedDocumentEliminator;
 I: Integer;
 l_DocFN: string;
 l_Name: Tl3WString;
 l_Num: Tl3WString;
 l_Date: Tl3WString;
 l_Source: Tl3WString;
 l_Type  : Tl3WString;
 l_DocName : Il3CString;
 l_StDate: TStDate;
 l_RSource: Il3CString;
 l_DocFormat: TevFormat;
 l_Filer: Tl3DOSFiler;
 l_Ext: string;
 l_Str: Il3CString;

begin
 f_ErrorCount := 0;
 l_DocReader := nil;
 l_CSV := TddCSV.Create(17);
 try
  l_CSV.Codepage := CP_ANSI;
  l_CSV.Load(Filer);
  l3System.Msg2Log('Начало чтения реестра документов');
  Progress(0, l_CSV.RowCount, 'Начало чтения реестра документов');
  for I := 0 to l_CSV.RowCount - 1 do
  begin
   l_DocFN := l_CSV.AsString(I, rc_DocFN);
   if (l_DocFN <> '') and (not FileExists(f_DocPath + l_DocFN)) then
   begin
    Inc(f_ErrorCount);
    l3System.Msg2Log('Файл %s не найден', [l_DocFN]);
   end
   else // if (l_DocFN <> '') and (not FileExists(l_DocFN))
   begin
    l_Name := l3Trim(l_CSV.AsWString(I, rc_Name));
    l_Num  := l3Trim(l_CSV.AsWString(I, rc_Number));
    l_Date  := l3Trim(l_CSV.AsWString(I, rc_Date));
    l_Type := l3Trim(l_CSV.AsWString(I, rc_Type));
    l_Source  := l3Trim(l_CSV.AsWString(I, rc_Source));

    if (not l3IsNil(l_Name)) or (not l3IsNil(l_Num)) or
       (not l3IsNil(l_Type)) or (not l3IsNil(l_Source)) or (not l3IsNil(l_Date))then
    begin
     StartChild(k2_typDocument); // начинаем документ
     try
      AddIntegerAtom(k2_tiExternalHandle, f_TopicNo);
      Inc(f_TopicNo);

      if not l3IsNil(l_Date) then
       l_StDate := DateTimeToStDate(StrToDateDef(l3PCharLen2String(l_Date), BadDateTime))
      else
       l_StDate := BadDate;

      l_DocName := l3CStr('');
      if (not l3IsNil(l_Source)) and (not l3IsNil(l_Type)) then
      begin
       l_DocName := l3Cat(l_DocName, l_Type);
       l_DocName := l3Cat(l_DocName, ' ');
       l_RSource := l3CStr(mlmaRusDeclensionStr(l3PCharLen2String(l_Source), rdRodit));
       l_DocName := l3Cat(l_DocName, l_RSource.AsWStr);

       if l_StDate <> BadDate then
       begin
        l_DocName := l3Cat(l_DocName, ' от ');
        l_DocName := l3Cat(l_DocName, l_Date);
       end;
       if not l3IsNil(l_Num) then
       begin
        l_DocName := l3Cat(l_DocName, ' N ');
        l_DocName := l3Cat(l_DocName, l_Num);
       end;
       AddStringAtom(k2_tiShortName, l_DocName.AsWStr);
      end; // (not l3IsNil(l_Source)) and (not l3IsNil(l_Type))

      if not l3IsNil(l_DocName) then
       if not l3IsNil(l_Name) then
       begin
        l_DocName := l3Cat(l_DocName, ' "');
        l_DocName := l3Cat(l_DocName, l_Name);
        l_DocName := l3Cat(l_DocName, ' "');
        AddStringAtom(k2_tiName, l_DocName.AsWStr);
       end
       else
        AddStringAtom(k2_tiName, l_DocName.AsWStr);


      if not l3IsNil(l_Type) then
      begin
       StartTag(k2_tiTypes);
       try
        StartDefaultChild;
        try
         AddStringAtom(k2_tiName, l_Type);
        finally
         Finish;
        end;
       finally
        Finish;
       end;
      end;

      if not l3IsNil(l_Source) then
      begin
       StartTag(k2_tiSources);
       try
        StartDefaultChild;
        try
         AddStringAtom(k2_tiName, l_Source);
        finally
         Finish;
        end;
       finally
        Finish;
       end;
      end;

      if (l_StDate <> BadDate) or (not l3IsNil(l_Num)) then
      begin
       StartTag(k2_tiNumANDDates);
       try
        StartDefaultChild;
        try
         AddIntegerAtom(k2_tiType, Ord(dnPublish));
         if (l_StDate <> BadDate) then
          AddIntegerAtom(k2_tiStart, l_StDate);
         if not l3IsNil(l_Num) then
          AddStringAtom(k2_tiNumber, l_Num);
        finally
         Finish;
        end;
       finally
        Finish;
       end;
      end;

      StartChild(k2_typTextPara);
      try
       AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
       AddStringAtom(k2_tiText, l_DocName.AsWStr);
      finally
       Finish;
      end;
      StartChild(k2_typTextPara);
      Finish;

      if l_DocFN <> '' then
      begin
       l_DocReader := TddDocReader.Make(f_DocPath + l_DocFN);
       if l_DocReader <> nil then
       begin
        l_DocReader.LiteVersion := True;
        try
         l_NestedFilter := TevNestedDocumentEliminator.Create;
         try
          l_DocReader.Generator := l_NestedFilter;
          l_NestedFilter.Generator := Self.Generator;
          l_DocReader.Start;
          try
           try
            l_DocReader.Execute;
           except
            on E: Exception do
            begin
             l3System.Msg2Log(Format('Ошибка при чтении исходного файла. Топик %d, файл - %s',[f_TopicNo-1, l_DocFN]));
             Inc(f_ErrorCount)
            end;
           end;
          finally
           l_DocReader.Finish;
          end;
         finally
          FreeAndNil(l_NestedFilter);
         end;
        finally
         FreeAndNil(l_DocReader);
        end;
       end // if l_DocReader <> nil
       else
       begin
        Inc(f_ErrorCount);
        l3System.Msg2Log('Файл %s имеет неизвестный формат', [l_DocFN]);
       end;
      end;
     finally
      Finish;  // завершаем документ
     end;
    end;
   end; // if (l_DocFN <> '') and (not FileExists(l_DocFN))
   Progress(1, i, '');
  end; // for i
  Progress(2, l_CSV.RowCount, 'Чтение реестра документов завершено');
 finally
  FreeAndNil(l_CSV);
 end;
end;

end.
