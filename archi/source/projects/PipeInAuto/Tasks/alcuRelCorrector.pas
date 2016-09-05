unit alcuRelCorrector;
{ Задача, добавляющая информацию о публикации в справку }

{ $Id: alcuRelCorrector.pas,v 1.18 2016/06/16 05:38:37 lukyanets Exp $ }

// $Log: alcuRelCorrector.pas,v $
// Revision 1.18  2016/06/16 05:38:37  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.17  2016/03/16 11:00:31  lukyanets
// Похоже портим экземпляр Exception
//
// Revision 1.16  2014/10/23 07:08:06  lukyanets
// Обращаемся к несуществующему параметру
//
// Revision 1.15  2014/10/03 13:05:38  lukyanets
// Более адекватное название
//
// Revision 1.14  2014/09/10 06:18:38  lukyanets
// Более адекватное название метода
//
// Revision 1.13  2014/09/02 10:29:04  lukyanets
// Учим экспорт в разные регионы работать одновременно
//
// Revision 1.12  2014/08/26 11:56:00  lukyanets
// Учимся прерывать
//
// Revision 1.11  2014/08/22 12:54:24  lukyanets
// {Requestlink:563199760}. Отцепляем экспорт прайма
//
// Revision 1.10  2014/08/20 13:45:10  lukyanets
// {Requestlink:558466572}. Расставляем возможность одноврменной работы
//
// Revision 1.9  2014/08/08 06:40:12  lukyanets
// {Requestlink:556143119}. Отцепили alcuRelPublishTask
//
// Revision 1.8  2014/08/07 14:02:22  lukyanets
// {Requestlink:556143119}. Вытащили ручки для отключения конкретных типов задач
//
// Revision 1.7  2014/08/07 08:09:59  lukyanets
// {Requestlink:556143119}. Отцепили alcuRelPublishTask
//
// Revision 1.6  2014/08/07 07:04:46  lukyanets
// {Requestlink:556143119}. Готовимся к рулению асинхронного запуска от AppConfig
//
// Revision 1.5  2014/07/21 09:26:38  lulin
// - спрямляем модель.
//
// Revision 1.4  2014/07/07 12:10:47  lulin
// - движемся к константности TaskType.
//
// Revision 1.3  2014/06/06 13:14:15  lulin
// - чистим код.
//
// Revision 1.10  2014/02/12 12:39:12  lulin
// - рефакторим списки заданий.
//
// Revision 1.9  2013/12/02 09:28:10  fireton
// - логируем автопополнение справок
//
// Revision 1.8  2013/11/27 09:27:08  fireton
// - логируем автопополнение справок
//
// Revision 1.7  2012/07/02 05:25:37  narry
// Автодополнение справок
//
// Revision 1.6  2012/05/24 05:35:19  narry
// Обновление
//
// Revision 1.5  2012/05/17 10:35:22  narry
// Ссылки внутри добавляемой информации (363574319)
//
// Revision 1.4  2012/05/14 09:28:41  narry
// Автодополнение справок (269063217)
//
// Revision 1.3  2011/08/10 11:06:54  narry
// Украшательство
//
// Revision 1.2  2011/08/09 09:31:38  narry
// Заливка информации в справки каждую ночь (266422146)
//

interface

{$I ddDefine.inc}

uses
  csProcessTask, ddProgressObj, daTypes, csImport,

  csTaskResult,

  csRelPublishTask,
  alcuRelPublishTaskResult,

  ddRelPublish,
  ddProcessTaskPrim
  ;

type
 TalcuRelPublishTask = class(TcsRelPublishTask)
 private
  f_Corrector: TddRelPublishCorrector;
  function pm_GetTaskResult: TalcuRelPublishTaskResult;
 protected
  procedure DoAbort; override;
  procedure DoRun(const aContext: TddRunContext); override;
  function GetTaskResultClass: TcsTaskResultClass; override;
  {$If defined(AppServerSide)}
  procedure DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
  function AllowSimultaneousRun: Boolean; override;
 public
  class function CanAsyncRun: Boolean; override;
  constructor Create(aUserID: TdaUserID); override;
  property TaskResult: TalcuRelPublishTaskResult read pm_GetTaskResult;
 end;//TalcuRelPublishTask

implementation

uses
  {$If defined(AppServerSide)} ddAppConfig, alcuMailServer, {$IfEnd defined(AppServerSide)}
  Classes, SysUtils, l3FileUtils, CsTaskTypes, l3Base, l3LongintList, ddServerTask;

{
******************************** TddProcessTask ********************************
}
function TalcuRelPublishTask.AllowSimultaneousRun: Boolean;
begin
  Result := False;
end;

class function TalcuRelPublishTask.CanAsyncRun: Boolean;
begin
  Result := True;
end;

constructor TalcuRelPublishTask.Create(aUserID: TdaUserID);
begin
 inherited;
 //TaskType:= cs_ttRelPublish;
 Description:= 'Добавление в справки информации о публикации';
end;

procedure TalcuRelPublishTask.DoAbort;
begin
 inherited DoAbort;
 if f_Corrector <> nil then
  f_Corrector.AbortProcess;
end;

procedure TalcuRelPublishTask.DoRun(const aContext: TddRunContext);
var
 l_MissedList: TStrings;
 l_LockedList: Tl3LongintList;
 l_Total, l_Worked, l_Missed: Integer;
 l_FileName: String;
 l_MailBody: String;
 l_Region: Tl3LongintList;
begin
  {$IFDEF LogRelPublish}
  l3System.Msg2Log('* Начало выполнения задания пополнения справок');
  {$ENDIF}
  TaskResult.IsError := False;
  if SourceFiles.Count > 0 then
  begin
   l_FileName:= SourceFiles[0];
   if FileExists(l_FileName) then
   begin
    {$IFDEF LogRelPublish}
    l3System.Msg2Log('* Обработка файла %s', [l_FileName]);
    {$ENDIF}
    l_MissedList:= TStringList.Create;
    try
     l_LockedList:= Tl3LongintList.Make;
     try
      l_Region := Tl3LongintList.Make;
      try
       RegionIDList.ToList(l_Region);
       try
        f_Corrector := TddRelPublishCorrector.Create;
        try
         f_Corrector.Execute(l_FileName, l_Total, l_worked, l_Missed, l_MissedList,
          l_LockedList, l_Region, aContext.rProgressor);
        finally
         FreeAndNil(f_Corrector);
        end;
       except
        {$IFDEF LogRelPublish}
        on E: Exception do
        begin
         l3System.Msg2Log('* Вылет по exception!');
         l3System.Exception2Log(E);
         raise;
        end;
        {$ELSE}
        raise;
        {$ENDIF}
       end;
      finally
       FreeANdNil(l_Region);
      end;
      {$IFDEF LogRelPublish}
      l3System.Msg2Log('* Отправляем письмо');
      {$ENDIF}
      l_MailBody := Format('Файл %s.'#10+
                             'Обработано %d справок'#10+
                             'Информация о публикации добавлена в %d справок.'#10+
                             '%d справок пропущено',
                             [ExtractFileName(l_FileName), l_Total, l_worked, l_Missed]);
      l3System.Msg2Log(l_MailBody + '.');
      if (l_Total > 0) then
      begin
       l_MailBody := l_MailBody + ':'#10#10 + l_MissedList.Text;
       TaskResult.MailBody := l_MailBody;
      end; // l_Total > 0
     finally
      FreeAndNil(l_LockedList);
     end;
    finally
     FreeAndNil(l_MissedList);
    end;
   end
   else
   begin
    {$IFDEF LogRelPublish}
    l3System.Msg2Log('* Не найден файл с данными о публикации');
    {$ENDIF}
    TaskResult.IsError := False;
    TaskResult.MailBody := 'Не найден файл с данными о публикации';
   end
  end
  else
  begin
   {$IFDEF LogRelPublish}
   l3System.Msg2Log('* Не найден файл с данными о публикации');
   {$ENDIF}
   TaskResult.IsError := False;
   TaskResult.MailBody := 'Не задан файл с данными о публикации';
  end;
end;

  {$If defined(AppServerSide)}
procedure TalcuRelPublishTask.DoRunSuccessfullyFinished(
  const aServices: IcsRunTaskServices);
begin
  inherited;
{$IFDEF AutoSP}
  if TaskResult.MailBody <> '' then
    alcuMail.SendEmail(ddAppConfiguration.AsString['aiRelNotifyList'], TaskResult.MailBody, 'Информация о публикации', TaskResult.IsError);
{$ENDIF AutoSP}
end;
  {$IfEnd defined(AppServerSide)}

function TalcuRelPublishTask.GetTaskResultClass: TcsTaskResultClass;
begin
  Result := TalcuRelPublishTaskResult;
end;

function TalcuRelPublishTask.pm_GetTaskResult: TalcuRelPublishTaskResult;
begin
  Result := TalcuRelPublishTaskResult(inherited TaskResult);
end;

  {$If defined(AppServerSide)}
procedure TalcuRelPublishTask.SetupServerSideConfigParams;
begin
 inherited;
 RegionIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['utRegionID']));
end;
  {$IfEnd defined(AppServerSide)}

initialization
 RegisterTaskClass(cs_ttRelPublish, TalcuRelPublishTask, 'Дополнение справок');

end.
