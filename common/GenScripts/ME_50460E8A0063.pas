unit atContextSearchInDocumentOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atContextSearchInDocumentOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atOperationBase
 , DocumentUnit
 , atDocumentHelper
 , Classes
 , atStringProvider
;

type
 _atHasStringParamAddOn_Parent_ = TatOperationBase;
 {$Include atHasStringParamAddOn.imp.pas}
 TatContextSearchInDocumentOperation = class(_atHasStringParamAddOn_)
  private
   f_IsLogFoundContexts: Boolean;
   f_DTP: IDocumentTextProvider;
   f_StartParas: TParaIDArr;
   f_ParasText: TStringList;
  protected
   function OnString(const aString: AnsiString): Boolean; override;
   procedure InitParamList; override;
   procedure ExecuteSelf; override;
 end;//TatContextSearchInDocumentOperation

implementation

uses
 l3ImplUses
 , atLogger
 , Math
 , atStringHelper
 , BaseTypesUnit
 , SysUtils
 , atSyncedStringFileReader
 , atStringFileReader
 , atConstStringProvider
;

{$Include atHasStringParamAddOn.imp.pas}

function TatContextSearchInDocumentOperation.OnString(const aString: AnsiString): Boolean;
//#UC START# *503648620273_50460E8A0063_var*
  var
    l_ParaID : TParaId;
    l_FoundContext : IFoundContext;
    l_ContextList : IContextList;
    l_FragmentList : IFragmentList;
    l_Context : TContext;
    l_EP : TEntryPoint;
    i, j, l_Key : Integer;
    l_ParaIDStr : String;
    l_PStr : PString;
//#UC END# *503648620273_50460E8A0063_var*
begin
//#UC START# *503648620273_50460E8A0063_impl*
  Result := true;
  //
  l_ParaID := f_StartParas[RandomRange(Low(f_StartParas), High(f_StartParas))];

  Logger.Info('Ищем контекст "%s" начиная с параграфа %d', [aString, l_ParaID]);

  // ищем
  try
    f_DTP.FindContext( TatStringHelper.DStr2AStr(aString), l_ParaID, l_FoundContext);
  except
    on ECanNotFindData do
    begin
      Logger.Info('Ничего не найдено');
      Exit;
    end;
  end;

  // читаем то что нашли
  l_FoundContext.GetList(l_ContextList);
  Logger.Info('Найдено %d вхождений', [l_ContextList.Count]);  
  for i := 0 to l_ContextList.Count-1 do
  begin
    l_ContextList.pm_GetItem(i, l_FragmentList);
    for j := 0 to l_FragmentList.Count-1 do
    begin
      l_FragmentList.pm_GetItem(j, l_Context);
      //
      l_EP := TatDocumentHelper.GetEPByNIP(f_DTP, l_Context.rPath);
      l_ParaID := f_DTP.GetChildExternalId(l_EP);

      if f_IsLogFoundContexts then
      begin
        // сохраняем текст параграфа потому что его можно получить только один раз
        l_ParaIDStr := IntToStr(l_ParaID);
        l_Key := f_ParasText.IndexOf(l_ParaIDStr);
        if l_Key = -1 then
        begin
          New(l_PStr);
          l_PStr^ := TatDocumentHelper.ReadParaText(f_DTP, l_EP);
          f_ParasText.AddObject(l_ParaIDStr, TObject(l_PStr));
        end
        else
          l_PStr := PString(f_ParasText.Objects[l_Key]);

        if Parameters['is_log_found_contexts'].AsBool then
          Logger.Info('В параграфе %d с %d по %d позиции найден контекст "%s" (фрагмент %d/%d)',
            [l_ParaID, l_Context.rStart, l_Context.rFinish, Copy(l_PStr^, l_Context.rStart + 1, l_Context.rFinish - l_Context.rStart),
            j+1, l_FragmentList.Count]);
      end;
    end;
  end;
//#UC END# *503648620273_50460E8A0063_impl*
end;//TatContextSearchInDocumentOperation.OnString

procedure TatContextSearchInDocumentOperation.InitParamList;
//#UC START# *48089F3701B4_50460E8A0063_var*
//#UC END# *48089F3701B4_50460E8A0063_var*
begin
//#UC START# *48089F3701B4_50460E8A0063_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('start_para_id', 'С какого параграфа начинать искать', '0') );
    Add( ParamType.Create('is_log_found_contexts', 'Логгировать найденные контексты', 'false') );    
  end;
//#UC END# *48089F3701B4_50460E8A0063_impl*
end;//TatContextSearchInDocumentOperation.InitParamList

procedure TatContextSearchInDocumentOperation.ExecuteSelf;
//#UC START# *48089F460352_50460E8A0063_var*
  var
    l_Document : IDocument;
    l_StartParaID, i : Integer;
//#UC END# *48089F460352_50460E8A0063_var*
begin
//#UC START# *48089F460352_50460E8A0063_impl*
  f_IsLogFoundContexts := Parameters['is_log_found_contexts'].AsBool;

  l_Document := ExecutionContext.UserWorkContext.CurrDoc;
  if (l_Document = nil) then
  begin
    Logger.Error('Нет открытого документа!');
    Exit;
  end;
  //
  l_Document.GetTextProvider(false, f_DTP);

  // заполняем массив параграфов
  l_StartParaID := Parameters['start_para_id'].AsInt;
  if l_StartParaID >= 0 then
  begin // здесь только одно, конкретное значение
    SetLength(f_StartParas, 1);
    f_StartParas[0] := l_StartParaID;
  end
  else
  begin
    // заполняем массив номерами параграфов документа
    f_StartParas := TatDocumentHelper.GetParaIDArray(f_DTP, -1, false);
    if f_StartParas = nil then
    begin
      Logger.Error('В документе не найдено подходящих параграфов!');
      Exit;
    end;
  end;

  Logger.Info('Выполняем контекстный поиск в документе %d', [l_Document.GetInternalId]);

  f_ParasText := TStringList.Create;
  try
    // обрабатываем строки
    inherited;
  finally
    for i := 0 to f_ParasText.Count-1 do
      Dispose( PString(f_ParasText.Objects[i]) );
    FreeAndNil(f_ParasText);
  end;
//#UC END# *48089F460352_50460E8A0063_impl*
end;//TatContextSearchInDocumentOperation.ExecuteSelf

end.
