unit alcuServerTaskManagerFactory;
 {* Фабрика для TddServerTaskManager }

// Модуль: "w:\archi\source\projects\PipeInAuto\Server\alcuServerTaskManagerFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuServerTaskManagerFactory" MUID: (52FA29AE02C2)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 , alcuTaskManager
 , alcuBaseEngineHolder
;

type
 RalcuServerTaskManagerFactory = class of TalcuServerTaskManagerFactory;

 TalcuServerTaskManagerFactory = class
  {* Фабрика для TddServerTaskManager }
  protected
   class function DoMake(const aRootPath: AnsiString;
    const aBaseEngineHolder: TalcuBaseEngineHolder): TddServerTaskManager; virtual;
  public
   class function Make(const aRootPath: AnsiString;
    const aBaseEngineHolder: TalcuBaseEngineHolder): TddServerTaskManager;
 end;//TalcuServerTaskManagerFactory

var g_FactoryClass: RalcuServerTaskManagerFactory = nil;
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
;

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
{$IfEnd} // Defined(AppServerSide)

end.
