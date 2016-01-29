unit archiExportActionTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "New Actions Test"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/NewActions/Export/archiExportActionTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::New Actions Test::Tasked Actions::TarchiExportActionTest
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
 TarchiExportActionTest = class(TBaseTest)
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
 end;//TarchiExportActionTest
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  SysUtils
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TarchiExportActionTest

procedure TarchiExportActionTest.DoIt;
//#UC START# *5395D1AB0313_5395D124034E_var*
//#UC END# *5395D1AB0313_5395D124034E_var*
begin
//#UC START# *5395D1AB0313_5395D124034E_impl*
 Check(true);
//#UC END# *5395D1AB0313_5395D124034E_impl*
end;//TarchiExportActionTest.DoIt

{$If defined(nsTest)}
function TarchiExportActionTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Tasked Actions';
end;//TarchiExportActionTest.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TarchiExportActionTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5395D124034E';
end;//TarchiExportActionTest.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TarchiExportActionTest.Suite);

end.