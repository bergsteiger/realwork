program cs;

{$APPTYPE CONSOLE}

uses
  ActiveX,
  
  SysUtils,

  l3Chars,
  l3Types,
  l3Base,
  l3String,

  m2COMLib,

  m3StorageInterfaces,
  m3StgMgr,

  m4Search,
  m4SearchFormula,
  m4SearchExEx,
  m4DocumentAddress,
  m4SearchEx{,

  m4FoundSelector}
  ;

procedure Prompt(var theString: String; const aString: String = '');
begin
 Write(aString + '>');
 ReadLn(theString);
end;

procedure SayOk;
begin
 WriteLn('Ok');
end;

procedure Say(const aString: String);
begin
 WriteLn(l3ChangeCodePage(aString, CP_ANSI, CP_OEM));
end;

procedure SayError(const aString: String);
begin
 Say(aString);
end;

var
  f_SearchEngine : Tm4SearchEngine = nil;

procedure CreateSearchEngine(const aName: String);
  {-}
var
 l_Storage      : Im3IndexedStorage;
 l_IndexStorage : Im3IndexedStorage;
begin
 try
  l_Storage := Tm3ReadModeStorageManager.MakeInterface(aName);
  try
   l3Free(f_SearchEngine);
   try
    l_IndexStorage := m2COMOpenStorage(l_Storage,
                                       'index',
                                       STGM_READ or STGM_SHARE_EXCLUSIVE,
                                       false) As Im3IndexedStorage;
   except
    l_IndexStorage := l_Storage;
   end;//try..except
   f_SearchEngine := Tm4SearchEngine.Create(l_IndexStorage);
   SayOk;
  finally
   l_Storage := nil;
  end;//try..finally
 except
  on E: Exception do
   if (f_SearchEngine = nil) then
    SayError('Индекс не загружен : ' + E.Message);
 end;//try..except
end;

var
 g_NeedSelect: Bool = true;

procedure Search(const aString: String; aCodePage: Long = CP_OEM);
var
 l_Expr   : Tm4BaseExpression;
 l_Result : Tl3LongintList;
 l_Index  : Long;
 l_Time   : TDateTime;
 l_Addresses : Tm4Addresses;
// l_Selector  : Tm4FoundSelector;
begin
 try
  l_Expr := m4ParseSearchFormula(l3PCharLen(aString, aCodePage));
  try
   l_Time := Now;
   l_Addresses := nil;
   if g_NeedSelect then
    l_Result := f_SearchEngine.Search(l_Expr, @l_Addresses)
   else
    l_Result := f_SearchEngine.Search(l_Expr);
   try
    l_Time := Now - l_Time;
    // .. здесь выводим результат поиска
    Say('Время поиска:' + TimeToStr(l_Time));
    if l_Result.Empty then
     Say('Ничего не найдено')
    else
     Say('Найдено: ' + IntToStr(l_Result.Count) + ' документов.');
 (*   Caption := TimeToStr(l_Time);
    with outMemo do begin
     l_Op := StartOp(0);
     try
      if l_Result.Empty then
       Text := 'Ничего не найдено.'
      else begin
       l_Selector := Tm4FoundSelector.Create(2, l_Addresses);
       try
       finally
        l3Free(l_Selector);
       end;//try..finally
       Text := '';
       with l_Result do begin
        if (Count <= 5000) OR
           (MessageDlg('Найдено ' + IntToStr(Count) + ' документов. Показать?',
                       mtConfirmation,
                       [mbYes, mbNo], 0) = mrYes) then
         for l_Index := Lo to Hi do
          InsertBuf(l3PCharLen(IntToStr(Items[l_Index])+cc_EOL));
       end;//with l_Result
      end;//l_Result.Empty
     finally
      l_Op := nil;
     end;//try..finally
    end;//with outMemo*)
   finally
    try
     l3Free(l_Result);
    finally
     l3Free(l_Addresses);
    end;//try..finally
   end;//try..finally
  finally
   l3Free(l_Expr);
  end;//try..finally
 except
  on E: Exception do
   SayError(E.Message);
 end;//try..except
end;

var
 l_Command : String;
begin
 try
  if (ParamCount > 0) then begin
   CreateSearchEngine(ParamStr(1));
   if (ParamCount > 1) then 
    Search(ParamStr(2), CP_ANSI);
  end;//ParamCount > 0
  while true do begin
   Prompt(l_Command);
   if (l_Command = '') OR SameText(l_Command, 'q') then
    break;
   if SameText(l_Command, 'i') then begin
    Prompt(l_Command, 'Имя индекса');
    if (l_Command <> '') then
     CreateSearchEngine(l_Command);
   end else if SameText(l_Command, '.') then begin
    g_NeedSelect := not g_NeedSelect;
    if g_NeedSelect then
     Say('С выделением')
    else
     Say('Без выделения');
   end else
    Search(l_Command);
  end;//while true
 finally
  l3Free(f_SearchEngine);
 end;//try..finally
end.
