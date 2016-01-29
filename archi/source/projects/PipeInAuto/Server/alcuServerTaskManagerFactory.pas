unit alcuServerTaskManagerFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Server"
// Модуль: "w:/archi/source/projects/PipeInAuto/Server/alcuServerTaskManagerFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Server::Server::TalcuServerTaskManagerFactory
//
// Фабрика для TddServerTaskManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide)}
uses
  alcuTaskManager,
  alcuBaseEngineHolder
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}
type
 RalcuServerTaskManagerFactory = class of TalcuServerTaskManagerFactory;

 TalcuServerTaskManagerFactory = class
  {* Фабрика для TddServerTaskManager }
 protected
 // protected methods
   class function DoMake(const aRootPath: AnsiString;
     const aBaseEngineHolder: TalcuBaseEngineHolder): TddServerTaskManager; virtual;
 public
 // public methods
   class function Make(const aRootPath: AnsiString;
     const aBaseEngineHolder: TalcuBaseEngineHolder): TddServerTaskManager;
 end;//TalcuServerTaskManagerFactory
{$IfEnd} //AppServerSide

  {$If defined(AppServerSide)}
var
   g_FactoryClass : RalcuServerTaskManagerFactory = nil;
  {$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}

// start class TalcuServerTaskManagerFactory

class function TalcuServerTaskManagerFactory.Make(const aRootPath: AnsiString;
  const aBaseEngineHolder: TalcuBaseEngineHolder): TddServerTaskManager;
//#UC START# *52FA29DE0384_52FA29AE02C2_var*
//#UC END# *52FA29DE0384_52FA29AE02C2_var*
begin
//#UC START# *52FA29DE0384_52FA29AE02C2_impl*
 if (g_FactoryClass = nil) then
  Result := TalcuServerTaskManagerFactory.DoMake(aRootPath, aBaseEngineHolder)
 else
  Result := g_FactoryClass.DoMake(aRootPath, aBaseEngineHolder); 
//#UC END# *52FA29DE0384_52FA29AE02C2_impl*
end;//TalcuServerTaskManagerFactory.Make

class function TalcuServerTaskManagerFactory.DoMake(const aRootPath: AnsiString;
  const aBaseEngineHolder: TalcuBaseEngineHolder): TddServerTaskManager;
//#UC START# *52FA2C99010A_52FA29AE02C2_var*
//#UC END# *52FA2C99010A_52FA29AE02C2_var*
begin
//#UC START# *52FA2C99010A_52FA29AE02C2_impl*
 Result := TddServerTaskManager.Create(aRootPath, aBaseEngineHolder);
//#UC END# *52FA2C99010A_52FA29AE02C2_impl*
end;//TalcuServerTaskManagerFactory.DoMake

{$IfEnd} //AppServerSide

end.