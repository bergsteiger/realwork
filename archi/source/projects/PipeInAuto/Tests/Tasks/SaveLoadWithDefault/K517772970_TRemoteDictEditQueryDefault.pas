unit K517772970_TRemoteDictEditQueryDefault;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoadWithDefault/K517772970_TRemoteDictEditQueryDefault.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TasksSaveLoadWithDefault::K517772970_TRemoteDictEditQueryDefault
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
  K517772970_TCheckSaveToStreamDefault
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}
type
 TK517772970_TRemoteDictEditQueryDefault = class(TK517772970_TCheckSaveToStreamDefault)
  {* [RequestLink:517772970] }
 protected
 // realized methods
   function GetTaskClass: TddTaskClass; override;
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
 end;//TK517772970_TRemoteDictEditQueryDefault
{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

implementation

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csServerTaskTypes
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  ,
  l3Filer,
  SysUtils
  ;
{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

{$If defined(AppServerSide) AND defined(InsiderTest) AND defined(RemoteDict)}

// start class TK517772970_TRemoteDictEditQueryDefault

function TK517772970_TRemoteDictEditQueryDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_53197E5501B8_var*
//#UC END# *53170E4100CF_53197E5501B8_var*
begin
//#UC START# *53170E4100CF_53197E5501B8_impl*
 result := TRemoteDictEditQuery;
//#UC END# *53170E4100CF_53197E5501B8_impl*
end;//TK517772970_TRemoteDictEditQueryDefault.GetTaskClass

{$If defined(nsTest)}
function TK517772970_TRemoteDictEditQueryDefault.GetFolder: AnsiString;
 {-}
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TRemoteDictEditQueryDefault.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TRemoteDictEditQueryDefault.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53197E5501B8';
end;//TK517772970_TRemoteDictEditQueryDefault.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest AND RemoteDict

initialization
 TestFramework.RegisterTest(TK517772970_TRemoteDictEditQueryDefault.Suite);

end.