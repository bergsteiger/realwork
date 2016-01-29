unit alcuProcessingEnabledService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Server"
// Модуль: "w:/archi/source/projects/PipeInAuto/Server/alcuProcessingEnabledService.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ServiceImplementation::Class>> archi$AutoPipeServer$Garant::Server::Server::TalcuProcessingEnabledService
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
  l3ProtoObject,
  l3ProcessingEnabledService
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}
type
 TalcuProcessingEnabledService = {final} class(Tl3ProtoObject, Il3ProcessingEnabledService)
 public
 // realized methods
   function Enabled: Boolean;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TalcuProcessingEnabledService;
    {- возвращает экземпляр синглетона. }
 end;//TalcuProcessingEnabledService
{$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}
uses
  l3Base {a},
  alcuServer
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}


// start class TalcuProcessingEnabledService

var g_TalcuProcessingEnabledService : TalcuProcessingEnabledService = nil;

procedure TalcuProcessingEnabledServiceFree;
begin
 l3Free(g_TalcuProcessingEnabledService);
end;

class function TalcuProcessingEnabledService.Instance: TalcuProcessingEnabledService;
begin
 if (g_TalcuProcessingEnabledService = nil) then
 begin
  l3System.AddExitProc(TalcuProcessingEnabledServiceFree);
  g_TalcuProcessingEnabledService := Create;
 end;
 Result := g_TalcuProcessingEnabledService;
end;


class function TalcuProcessingEnabledService.Exists: Boolean;
 {-}
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

{$IfEnd} //AppServerSide

initialization
{$If defined(AppServerSide)}
// Регистрация TalcuProcessingEnabledService
 Tl3ProcessingEnabledService.Instance.Alien := TalcuProcessingEnabledService.Instance;
{$IfEnd} //AppServerSide

end.