{$IfNDef atSaveQueryToXMLAddon_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atSaveQueryToXMLAddon.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::Operations::atSaveQueryToXMLAddon
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atSaveQueryToXMLAddon_imp}
 _atSaveQueryToXMLAddon_ = {mixin} class(_atSaveQueryToXMLAddon_Parent_)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 protected
 // overridden protected methods
   procedure InitParamList; override;
 protected
 // protected fields
   f_FilePathPrefix : AnsiString;
 protected
 // protected methods
   procedure SaveQuery(anQuery: TatQuery); virtual;
 end;//_atSaveQueryToXMLAddon_

{$Else atSaveQueryToXMLAddon_imp}

// start class _atSaveQueryToXMLAddon_

procedure _atSaveQueryToXMLAddon_.SaveQuery(anQuery: TatQuery);
//#UC START# *5006FE6A03B4_5006FE0303DD_var*
  var
    l_FileName, l_FileNameBase : String;
    l_XML : IXMLDocument;
    i : Integer;
    l_FHandle : Windows.THandle;
//#UC END# *5006FE6A03B4_5006FE0303DD_var*
begin
//#UC START# *5006FE6A03B4_5006FE0303DD_impl*
  if NOT anQuery.Empty then
  begin
    l_XML := anQuery.ExportAsXML;

    if Assigned(l_XML) then
    begin
      // формируем уникальное имя файла
      l_FileNameBase := f_FilePathPrefix;
      if (l_FileNameBase <> '') AND (AnsiLastChar(l_FileNameBase) <> '\') then
        l_FileNameBase := l_FileNameBase + '.';
      l_FileNameBase := l_FileNameBase + TatQueryTypeConverter.Instance.ToName(anQuery.QueryType) + '.' + GetTimeStamp + '.';
      // меняем имя пока не создадим свой новый файл (т.к. одновременно несколько клиентов могут сохранять)
      i := 0;
      repeat
        l_FileName := l_FileNameBase + IntToStr(i) + '.xml';
        l_FHandle := CreateFile(PAnsiChar(l_FileName), GENERIC_WRITE, 0, nil, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);
        Inc(i);
      until l_FHandle <> INVALID_HANDLE_VALUE;
      CloseHandle(l_FHandle);
      //
      Logger.Info('Сохраняем экспортированный запрос в файл "' + l_FileName + '"');
      l_XML.SaveToFile(l_FileName);
    end;
  end;
//#UC END# *5006FE6A03B4_5006FE0303DD_impl*
end;//_atSaveQueryToXMLAddon_.SaveQuery

procedure _atSaveQueryToXMLAddon_.ExecuteSelf;
//#UC START# *48089F460352_5006FE0303DD_var*
//#UC END# *48089F460352_5006FE0303DD_var*
begin
//#UC START# *48089F460352_5006FE0303DD_impl*
  f_FilePathPrefix := Parameters['file_path_prefix'].AsStr;
  //
  inherited;
//#UC END# *48089F460352_5006FE0303DD_impl*
end;//_atSaveQueryToXMLAddon_.ExecuteSelf

procedure _atSaveQueryToXMLAddon_.InitParamList;
//#UC START# *48089F3701B4_5006FE0303DD_var*
//#UC END# *48089F3701B4_5006FE0303DD_var*
begin
//#UC START# *48089F3701B4_5006FE0303DD_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('file_path_prefix', 'Префикс пути к файлам, в которые будем сохранять') );
  end;
//#UC END# *48089F3701B4_5006FE0303DD_impl*
end;//_atSaveQueryToXMLAddon_.InitParamList

{$EndIf atSaveQueryToXMLAddon_imp}
