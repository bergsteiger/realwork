unit alcuProcessingEnabledService;

// Модуль: "w:\archi\source\projects\PipeInAuto\Server\alcuProcessingEnabledService.pas"
// Стереотип: "ServiceImplementation"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3ProcessingEnabledService
;

type
 TalcuProcessingEnabledService = {final} class(Tl3ProtoObject, Il3ProcessingEnabledService)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   function Enabled: Boolean;
   class function Instance: TalcuProcessingEnabledService;
    {* Метод получения экземпляра синглетона TalcuProcessingEnabledService }
 end;//TalcuProcessingEnabledService
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
 , alcuServer
 , SysUtils
 , l3Base
;

var g_TalcuProcessingEnabledService: TalcuProcessingEnabledService = nil;
 {* Экземпляр синглетона TalcuProcessingEnabledService }

procedure TalcuProcessingEnabledServiceFree;
 {* Метод освобождения экземпляра синглетона TalcuProcessingEnabledService }
begin
 l3Free(g_TalcuProcessingEnabledService);
end;//TalcuProcessingEnabledServiceFree

class function TalcuProcessingEnabledService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TalcuProcessingEnabledService <> nil;
end;//TalcuProcessingEnabledService.Exists

function TalcuProcessingEnabledService.Enabled: Boolean;
//#UC START# *ECCF31CF8A24_561CF00A0193_var*
//#UC END# *ECCF31CF8A24_561CF00A0193_var*
begin
//#UC START# *ECCF31CF8A24_561CF00A0193_impl*
 Result := not TalcuServer.Instance.IsBaseLocked;
//#UC END# *ECCF31CF8A24_561CF00A0193_impl*
end;//TalcuProcessingEnabledService.Enabled

class function TalcuProcessingEnabledService.Instance: TalcuProcessingEnabledService;
 {* Метод получения экземпляра синглетона TalcuProcessingEnabledService }
begin
 if (g_TalcuProcessingEnabledService = nil) then
 begin
  l3System.AddExitProc(TalcuProcessingEnabledServiceFree);
  g_TalcuProcessingEnabledService := Create;
 end;
 Result := g_TalcuProcessingEnabledService;
end;//TalcuProcessingEnabledService.Instance

initialization
 Tl3ProcessingEnabledService.Instance.Alien := TalcuProcessingEnabledService.Instance;
 {* Регистрация TalcuProcessingEnabledService }
{$IfEnd} // Defined(AppServerSide)

end.
