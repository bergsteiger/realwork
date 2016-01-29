unit K517772970_TddNonEditableDictsRequest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TddNonEditableDictsRequest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TddNonEditableDictsRequest
//
// {RequestLink:517772970}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}
uses
  K517772970_TddRequestTask
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}
type
 TK517772970_TddNonEditableDictsRequest = class(TK517772970_TddRequestTask)
  {* [RequestLink:517772970] }
 protected
 // overridden protected methods
   {$If defined(nsTest)}
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   {$IfEnd} //nsTest
   {$If defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} //nsTest
   function TaskClass: TddTaskClass; override;
 end;//TK517772970_TddNonEditableDictsRequest
{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

implementation

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csNonEditableDictsRequest
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}

// start class TK517772970_TddNonEditableDictsRequest

{$If defined(nsTest)}
function TK517772970_TddNonEditableDictsRequest.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddNonEditableDictsRequest.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TddNonEditableDictsRequest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5320282A0092';
end;//TK517772970_TddNonEditableDictsRequest.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TddNonEditableDictsRequest.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_5320282A0092_var*
//#UC END# *5320088202FB_5320282A0092_var*
begin
//#UC START# *5320088202FB_5320282A0092_impl*
 result := TddNonEditableDictsRequest;
//#UC END# *5320088202FB_5320282A0092_impl*
end;//TK517772970_TddNonEditableDictsRequest.TaskClass

{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

initialization
 TestFramework.RegisterTest(TK517772970_TddNonEditableDictsRequest.Suite);

end.