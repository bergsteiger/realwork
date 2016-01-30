unit K517772970_TRemoteDictEditQuery;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TRemoteDictEditQuery.pas"
// Стереотип: "TestCase"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)}
uses
 l3IntfUses
 , K517772970_TddProcessTask
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TRemoteDictEditQuery = class(TK517772970_TddProcessTask)
  {* [RequestLink:517772970] }
  protected
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
   function TaskClass: TddTaskClass; override;
   procedure InitTask(Task: TddTaskItem); override;
 end;//TK517772970_TRemoteDictEditQuery
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csServerTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TRemoteDictEditQuery.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TRemoteDictEditQuery.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TRemoteDictEditQuery.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53214F530029';
end;//TK517772970_TRemoteDictEditQuery.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TRemoteDictEditQuery.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53214F530029_var*
//#UC END# *5320088202FB_53214F530029_var*
begin
//#UC START# *5320088202FB_53214F530029_impl*
 result := TRemoteDictEditQuery;
//#UC END# *5320088202FB_53214F530029_impl*
end;//TK517772970_TRemoteDictEditQuery.TaskClass

procedure TK517772970_TRemoteDictEditQuery.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53214F530029_var*
const
 IntConst = 123;
//#UC END# *532008D203BA_53214F530029_var*
begin
//#UC START# *532008D203BA_53214F530029_impl*
 inherited InitTask(Task);
 with (Task as TRemoteDictEditQuery) do begin
  Family := IntConst;
  DictType := IntConst;
  Operation := IntConst;
  ID := IntConst;
  ParentID := IntConst;
  NextID := IntConst;
  NameCyr := ClassName;
  NameShort := ClassName;
  NameLat := ClassName;
  IsPrivate := IntConst;
  IsNonPeriodic := IntConst;
  DateToDelete := IntConst;
 end;
//#UC END# *532008D203BA_53214F530029_impl*
end;//TK517772970_TRemoteDictEditQuery.InitTask

initialization
 TestFramework.RegisterTest(TK517772970_TRemoteDictEditQuery.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)

end.
