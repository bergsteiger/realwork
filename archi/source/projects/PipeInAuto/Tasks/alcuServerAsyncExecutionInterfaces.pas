unit alcuServerAsyncExecutionInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Tasks"
// ������: "w:/archi/source/projects/PipeInAuto/Tasks/alcuServerAsyncExecutionInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> archi$AutoPipeServer$Garant::Tasks::alcuServerAsyncExecutionInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(ServerTasks)}
uses
  dt_Types
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  
  ;

type
 IalcuAsyncSubmitterManager = interface(IUnknown)
  {* ������� ��� ���������� ������ ������������� ���������� }
   ['{EA167115-DB53-43B6-B272-CF8F715E7D69}']
   function Get_ServerHostName: AnsiString;
   function Get_ServerPort: Integer;
   procedure GetUserAccountByID(anID: TUserID;
    out theName: AnsiString;
    out thePassword: AnsiString);
     {* �������� �����/������ �� ID }
   function IsUserLogined(aUserID: TUserID): Boolean;
   procedure SendAbortNotification(anID: TUserID);
   function EnterTaskExecution(const aTask: TddProcessTask): Boolean;
   procedure LeaveTaskExecution(const aTask: TddProcessTask);
   property ServerHostName: AnsiString
     read Get_ServerHostName;
   property ServerPort: Integer
     read Get_ServerPort;
 end;//IalcuAsyncSubmitterManager

 IalcuAsyncTaskFinishedNotifier = interface(IUnknown)
   ['{3B274A91-A432-4FCA-92B3-FDC1BAA7AEED}']
   procedure TaskFinished(const aTask: TddProcessTask);
 end;//IalcuAsyncTaskFinishedNotifier
 PalcuAsyncTaskFinishedNotifier = ^IalcuAsyncTaskFinishedNotifier;

{$IfEnd} //AppServerSide AND ServerTasks

implementation

end.