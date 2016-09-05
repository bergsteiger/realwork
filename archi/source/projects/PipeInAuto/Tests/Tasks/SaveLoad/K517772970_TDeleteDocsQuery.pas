unit K517772970_TDeleteDocsQuery;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TDeleteDocsQuery.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TDeleteDocsQuery" MUID: (532150340028)
// Имя типа: "TK517772970_TDeleteDocsQuery"

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
 TK517772970_TDeleteDocsQuery = class(TK517772970_TddProcessTask)
  {* [RequestLink:517772970] }
  protected
   function TaskClass: TddTaskClass; override;
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
 end;//TK517772970_TDeleteDocsQuery
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
 //#UC START# *532150340028impl_uses*
 //#UC END# *532150340028impl_uses*
;

function TK517772970_TDeleteDocsQuery.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_532150340028_var*
//#UC END# *5320088202FB_532150340028_var*
begin
//#UC START# *5320088202FB_532150340028_impl*
 result := TDeleteDocsQuery;
//#UC END# *5320088202FB_532150340028_impl*
end;//TK517772970_TDeleteDocsQuery.TaskClass

{$If Defined(nsTest)}
function TK517772970_TDeleteDocsQuery.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TDeleteDocsQuery.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TDeleteDocsQuery.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '532150340028';
end;//TK517772970_TDeleteDocsQuery.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TDeleteDocsQuery.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
