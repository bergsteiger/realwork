unit K517772970_TDictEditQuery;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TDictEditQuery.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TDictEditQuery" MUID: (532150C50123)
// Имя типа: "TK517772970_TDictEditQuery"

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
 TK517772970_TDictEditQuery = class(TK517772970_TddProcessTask)
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
 end;//TK517772970_TDictEditQuery
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
function TK517772970_TDictEditQuery.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TDictEditQuery.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TDictEditQuery.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '532150C50123';
end;//TK517772970_TDictEditQuery.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TDictEditQuery.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_532150C50123_var*
//#UC END# *5320088202FB_532150C50123_var*
begin
//#UC START# *5320088202FB_532150C50123_impl*
 result := TDictEditQuery;
//#UC END# *5320088202FB_532150C50123_impl*
end;//TK517772970_TDictEditQuery.TaskClass

procedure TK517772970_TDictEditQuery.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_532150C50123_var*
const
 IntConst = 123;
//#UC END# *532008D203BA_532150C50123_var*
begin
//#UC START# *532008D203BA_532150C50123_impl*
 inherited InitTask(Task);
 with (Task as TDictEditQuery) do begin
  {DictInfo.}Family := IntConst;
  {DictInfo.}DictType := IntConst;
  {DictInfo.}Operation := IntConst;
  {DictInfo.}ID := IntConst;
  {DictInfo.}ParentID := IntConst;
  {DictInfo.}NextID := IntConst;
 end;
//#UC END# *532008D203BA_532150C50123_impl*
end;//TK517772970_TDictEditQuery.InitTask

initialization
 TestFramework.RegisterTest(TK517772970_TDictEditQuery.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
