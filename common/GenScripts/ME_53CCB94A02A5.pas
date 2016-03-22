unit alcuServerAsyncExecutionInterfaces;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuServerAsyncExecutionInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "alcuServerAsyncExecutionInterfaces" MUID: (53CCB94A02A5)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3IntfUses
 , dt_Types
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 PalcuAsyncTaskFinishedNotifier = ^IalcuAsyncTaskFinishedNotifier;

 IalcuAsyncSubmitterManager = interface
  {* Коробка для информации нужной ансинхронному выполнению }
  ['{EA167115-DB53-43B6-B272-CF8F715E7D69}']
  function Get_ServerHostName: AnsiString;
  function Get_ServerPort: Integer;
  procedure GetUserAccountByID(anID: TUserID;
   out theName: AnsiString;
   out thePassword: AnsiString);
   {* Получить логин/пароль по ID }
  function IsUserLogined(aUserID: TUserID): Boolean;
  procedure SendAbortNotification(anID: TUserID);
  function EnterTaskExecution(const aTask: TddProcessTask): Boolean;
  procedure LeaveTaskExecution(const aTask: TddProcessTask);
  property ServerHostName: AnsiString
   read Get_ServerHostName;
  property ServerPort: Integer
   read Get_ServerPort;
 end;//IalcuAsyncSubmitterManager

 IalcuAsyncTaskFinishedNotifier = interface
  ['{3B274A91-A432-4FCA-92B3-FDC1BAA7AEED}']
  procedure TaskFinished(const aTask: TddProcessTask);
 end;//IalcuAsyncTaskFinishedNotifier
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

implementation

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

end.
