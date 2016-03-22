unit K517772970_TUserEditQuery;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TUserEditQuery.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TUserEditQuery" MUID: (53214EEB036D)
// Имя типа: "TK517772970_TUserEditQuery"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TddProcessTask
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TUserEditQuery = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TUserEditQuery
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
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
function TK517772970_TUserEditQuery.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TUserEditQuery.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TUserEditQuery.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53214EEB036D';
end;//TK517772970_TUserEditQuery.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TUserEditQuery.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53214EEB036D_var*
//#UC END# *5320088202FB_53214EEB036D_var*
begin
//#UC START# *5320088202FB_53214EEB036D_impl*
 result := TUserEditQuery;
//#UC END# *5320088202FB_53214EEB036D_impl*
end;//TK517772970_TUserEditQuery.TaskClass

procedure TK517772970_TUserEditQuery.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53214EEB036D_var*
const
 IntConst = 123;
//#UC END# *532008D203BA_53214EEB036D_var*
begin
//#UC START# *532008D203BA_53214EEB036D_impl*
 inherited InitTask(Task);
 with (Task as TUserEditQuery) do begin
  IsGroup := true;
  ID := IntConst;
 end;
//#UC END# *532008D203BA_53214EEB036D_impl*
end;//TK517772970_TUserEditQuery.InitTask

initialization
 TestFramework.RegisterTest(TK517772970_TUserEditQuery.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
