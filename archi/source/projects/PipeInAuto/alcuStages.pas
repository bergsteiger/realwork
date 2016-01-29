unit alcuStages;

interface

procedure CopyStages;

implementation

uses ddAppConfig, alcuStrings, l3base, SysUtils, DateUtils, Types, l3FileUtils, GardocBridge,
 l3Date, ddConst, alcuMailServer, l3Types, alcuTypes;

procedure CopyStages;
var
  l_Msg: string;
  l_Error: Boolean;
  l_FromDate, l_ToDate: TDateTime;
  l_FileName : String;
begin
 if ddAppConfiguration.AsString[SalcuAutoPipeServer_GarDocDir] <> '' then
 begin
  l3System.Msg2Log(SalcuAutoPipeServer_Kopirovaniefaylaetapov);
  l_Error:= True;
  l_FromDate := ddAppConfiguration.AsDateTime['dayGardocDate'];
  if l_FromDate <> 0 then
   l_ToDate := SysUtils.Date
  else
  begin
    // С позавчера по вчера, если сейчас меньше StartTime, иначе со вчера по сегодня
    if CompareTime(Time, ddAppConfiguration.AsDateTime['WorkDayStart']) = GreaterThanValue then
     l_FromDate := IncDay(SysUtils.Date, -1)
    else
     l_FromDate := IncDay(SysUtils.Date, -2);
    l_ToDate := IncDay(l_FromDate);
  end;
  try
   l_FileName := ConcatDirName(ddAppConfiguration.AsString[SalcuAutoPipeServer_GarDocDir], BridgeFileName);
   OutListToStageExchangeFile(l_FileName, DateTimeToStDate(l_FromDate), DateTimeToStDate(l_ToDate));
   l3System.Msg2Log('Размер файла этапов: %d байт', [SizeofFile(l_FileName)], l3_msgLevel1);
   if CompareTime(Time, ddAppConfiguration.AsDateTime['WorkDayStart']) = GreaterThanValue then
    l_ToDate:= IncDay(l_ToDate);
   ddAppConfiguration.AsDateTime['dayGardocDate']:= l_ToDate;
   l_Msg:= SalcuAutoPipeServer_Kopirovaniefaylaetapovzaversheno;
   l_Error:= False;
  except
   l_Msg := 'Ошибка во время записи информации о закрытых этапах обработки документов';
   l_Error := True;
  end;

  alcuMail.SendEmailNotify(eventCopyStages, l_Error, l_Msg, dd_apsCopyStageFile);
  l3System.Msg2Log(l_Msg);
 end;
end;

end.
