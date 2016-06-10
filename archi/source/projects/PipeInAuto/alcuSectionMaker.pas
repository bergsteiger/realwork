unit alcuSectionMaker;
{ Расставялет разрывы разделов и масштабы }
{ $Id: alcuSectionMaker.pas,v 1.8 2016/03/31 12:53:26 lukyanets Exp $ }

// $Log: alcuSectionMaker.pas,v $
// Revision 1.8  2016/03/31 12:53:26  lukyanets
// Расчитываем даты версии/компиляции с учетом нескольких однотипных заданий
//
// Revision 1.7  2016/03/29 13:10:38  lukyanets
// Cleanup
//
// Revision 1.6  2015/11/26 08:45:26  lukyanets
// КОнстанты переехали
//
// Revision 1.5  2014/08/18 10:56:04  lukyanets
// {Requestlink:562611471}. Вертаем взад
//
// Revision 1.4  2014/07/16 07:48:08  lukyanets
// {Requestlink:553422280}. Притормаживаем отцепленное выполнение
//
// Revision 1.3  2014/04/17 13:07:50  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.2  2011/09/08 08:03:05  fireton
// - поменялось название метода (Update -> ProcessUpdate)
//
// Revision 1.1  2010/08/18 11:29:07  narry
// - не собиралось в связи с переименованием dt_Srch2
//

interface
(*
uses l3base, ddProgressObj, l3longintlist;

type
 TalcuSectionMaker = class(Tl3Base)
 private
  function BuildListAndMakeSections(aProgressor: TddProgressObject): Boolean;
  procedure SendReport(aList: Tl3longintList);
 public
  function Execute(aProgressor: TddProgressObject): Boolean;
 end;
*)
implementation
(*
uses
 ddAppConfig, ddScheduler, ddCalendarEvents, SysUtils, dtIntf, Dt_Sab, DT_Types, Dt_Query, l3Date,
 ddSectionRepairUtils, l3LongintListPrim, L3FileUtils, Dt_Serv, daSchemeConsts,
 alcuStrings, alcuMailServer, DT_Utils, StrUtils;

function TalcuSectionMaker.BuildListAndMakeSections(aProgressor: TddProgressObject): Boolean;
var
 l_Start, l_Finish: TDateTime;
 l_All: ISab;
 l_Q, l_New: TdtQuery;
 l_List: Tl3LongintList;
begin
 Result:= False;
 // подключенные, измененные подключенные или анонсированные за период
 with ddAppConfiguration do
 begin
  if AsInteger['smDates'] = 0 then
  begin // C последней обаботки
   l_Start:= AsDateTime['smLast'];
  end
  else
  begin // с последней компиляции
   if not TddScheduler(ddAppConfiguration.AsObject['Scheduler']).GetPrevFullDateTime(ctCompilation, Date, l_Start) then
    Assert(False);
  end;
  l_Finish:= Date;
 end; // with ddAppConfiguration
 l_New := TdtAndQuery.Create;
 l_Q := TdtLogByActionQuery.Create(
         acIncluded,
         StDateToDemon(DateTimeToStDate(l_Start)),  // FromDate
         StDateToDemon(DateTimeToStDate(l_Finish)) // ToDate
         );
 TdtAndQuery(l_New).AddQueryF(l_Q);
 l_Q := TdtLogByActionQuery.Create(
         acAnonced,
         StDateToDemon(DateTimeToStDate(l_Start)),  // FromDate
         StDateToDemon(DateTimeToStDate(l_Finish)) // ToDate
         );
 TdtAndQuery(l_New).AddQueryF(l_Q);
 l_List:= Tl3LongintList.Make;
 try
  dtCopyValuesSabToList(l_New.FoundList, l_List);
  Result:= DoSectionRepair(ConcatDirName(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily),
                                         SalcuAutoPipeServer_Bserv001), l_List, nil, aProgressor.ProcessUpdate);
  SendReport(l_List);
 finally
  FreeAndNil(l_List);
 end;
end;

function TalcuSectionMaker.Execute(aProgressor: TddProgressObject): Boolean;
begin
 l3System.Msg2Log('Начало расстановки разрывов разделов');
 Result:= BuildListAndMakeSections(aProgressor);
 l3System.Msg2Log('Расстановка завершилась %s', [IfThen(Result, 'успешно', 'неудачей')]);
end;

procedure TalcuSectionMaker.SendReport(aList: Tl3longintList);
var
 l_Message: String;
begin
 if ddAppConfiguration.AsString['smNotify'] <> '' then
 begin
  if aList.Empty then
   l_Message:= 'Не было обработано ни одного документа'
  else
  begin
   // Список номеров в список документов
   ConvertList2Text(aList, l_Message);
   l_Message:= Format('Обработано %d документов:'#13#10'%s', [aList.Count, l_Message]);
  end;
  alcuMail.SendEmail(ddAppConfiguration.AsString['smNotify'], l_Message, 'Расстановка разделов. Отчет');
 end;
end;
*)
end.
