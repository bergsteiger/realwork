unit K517772970_TddTaskItem;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddTaskItem.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TddTaskItem" MUID: (53200B930243)
// Имя типа: "TK517772970_TddTaskItem"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TCheckSaveToStream
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TddTaskItem = class(TK517772970_TCheckSaveToStream)
  {* [RequestLink:517772970] }
  protected
   function TaskClass: TddTaskClass; override;
   procedure InitTask(Task: TddTaskItem); override;
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
 end;//TK517772970_TddTaskItem
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 , l3Filer
 , SysUtils
 //#UC START# *53200B930243impl_uses*
 //#UC END# *53200B930243impl_uses*
;

function TK517772970_TddTaskItem.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53200B930243_var*
//#UC END# *5320088202FB_53200B930243_var*
begin
//#UC START# *5320088202FB_53200B930243_impl*
 Result := TddTaskItem;
//#UC END# *5320088202FB_53200B930243_impl*
end;//TK517772970_TddTaskItem.TaskClass

procedure TK517772970_TddTaskItem.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53200B930243_var*
//const
// VersionConst = 5;
// DateConst = 65000;
//#UC END# *532008D203BA_53200B930243_var*
begin
//#UC START# *532008D203BA_53200B930243_impl*
 with Task do
 begin
//  TaskType := cs_ttRequest;
//  Version := VersionConst;
//  Date := DateConst;
  Priority := 3;
  Description := ClassName;
 end;//with Task
//#UC END# *532008D203BA_53200B930243_impl*
end;//TK517772970_TddTaskItem.InitTask

{$If Defined(nsTest)}
function TK517772970_TddTaskItem.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddTaskItem.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddTaskItem.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53200B930243';
end;//TK517772970_TddTaskItem.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TddTaskItem.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
