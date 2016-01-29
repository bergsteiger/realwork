unit K517772970_TddCommonDataRequest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TddCommonDataRequest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TddCommonDataRequest
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

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  K517772970_TddRequestTask
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TddCommonDataRequest = class(TK517772970_TddRequestTask)
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
 end;//TK517772970_TddCommonDataRequest
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csCommonDataRequest
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TddCommonDataRequest

{$If defined(nsTest)}
function TK517772970_TddCommonDataRequest.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddCommonDataRequest.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TddCommonDataRequest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5320228E011B';
end;//TK517772970_TddCommonDataRequest.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TddCommonDataRequest.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_5320228E011B_var*
//#UC END# *5320088202FB_5320228E011B_var*
begin
//#UC START# *5320088202FB_5320228E011B_impl*
 result := TddCommonDataRequest;
//#UC END# *5320088202FB_5320228E011B_impl*
end;//TK517772970_TddCommonDataRequest.TaskClass

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TddCommonDataRequest.Suite);

end.