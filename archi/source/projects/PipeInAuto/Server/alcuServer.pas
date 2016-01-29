unit alcuServer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Server"
// Модуль: "w:/archi/source/projects/PipeInAuto/Server/alcuServer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Server::Server::TalcuServer
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
  alcuAutoPipeServer
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}
type
 TalcuServer = class(TalcuServerPrim)
 protected
 // overridden protected methods
   procedure AfterDestroyCalled; override;
     {* Сигнатура метода AfterDestroyCalled }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TalcuServer;
    {- возвращает экземпляр синглетона. }
 end;//TalcuServer
{$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}
uses
  l3Base {a},
  alcuStrings,
  SysUtils,
  alcuTaskChangeHelper
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}


// start class TalcuServer

var g_TalcuServer : TalcuServer = nil;

procedure TalcuServerFree;
begin
 l3Free(g_TalcuServer);
end;

class function TalcuServer.Instance: TalcuServer;
begin
 if (g_TalcuServer = nil) then
 begin
  l3System.AddExitProc(TalcuServerFree);
  g_TalcuServer := Create;
 end;
 Result := g_TalcuServer;
end;


class function TalcuServer.Exists: Boolean;
 {-}
begin
 Result := g_TalcuServer <> nil;
end;//TalcuServer.Exists

procedure TalcuServer.AfterDestroyCalled;
//#UC START# *52BC2B9401F3_52F8C9E00037_var*
//#UC END# *52BC2B9401F3_52F8C9E00037_var*
begin
//#UC START# *52BC2B9401F3_52F8C9E00037_impl*
 Assert(g_l3System <> nil);
 Tl3System(g_l3System).Str2Log(FormatDateTime(rsSessiyaostanovlenaDDMMYYYYvHhNn, Now));
 inherited;
//#UC END# *52BC2B9401F3_52F8C9E00037_impl*
end;//TalcuServer.AfterDestroyCalled

{$IfEnd} //AppServerSide

end.