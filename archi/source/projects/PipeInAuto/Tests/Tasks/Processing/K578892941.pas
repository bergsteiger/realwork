unit K578892941;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/Processing/K578892941.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TasksProcessing::K578892941
//
// {RequestLink:578892941}
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
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK578892941 = class(TBaseTest)
  {* [RequestLink:578892941] }
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
 published
 // published methods
   procedure DoIt;
 end;//TK578892941
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  SysUtils
  {$If not defined(Nemesis)}
  ,
  ncsGetReadyToDeliveryTasksReply
  {$IfEnd} //not Nemesis
  ,
  evdNcsTypes
  {$If not defined(Nemesis)}
  ,
  ncsMessage
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK578892941

procedure TK578892941.DoIt;
//#UC START# *54785B9A00C8_54785B8603B8_var*
var
 l_Message : TncsMessage;
 l_Reply: TncsGetReadyToDeliveryTasksReply;
//#UC END# *54785B9A00C8_54785B8603B8_var*
begin
//#UC START# *54785B9A00C8_54785B8603B8_impl*
 l_Message := TncsMessage.Create;
 try
  l_Message.Kind := ncs_mkMessage;
  l_Reply := TncsGetReadyToDeliveryTasksReply.Create(l_Message);
  try
   l_Reply.TasksIDList.Add('104');
  finally
   FreeAndNil(l_Reply);
  end;//try..finally
 finally
  FreeAndNil(l_Message);
 end;//try..finally
//#UC END# *54785B9A00C8_54785B8603B8_impl*
end;//TK578892941.DoIt

{$If defined(nsTest)}
function TK578892941.GetFolder: AnsiString;
 {-}
begin
 Result := 'TasksProcessing';
end;//TK578892941.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK578892941.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '54785B8603B8';
end;//TK578892941.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK578892941.Suite);

end.