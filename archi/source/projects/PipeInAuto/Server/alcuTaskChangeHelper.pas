unit alcuTaskChangeHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Server"
// Модуль: "w:/archi/source/projects/PipeInAuto/Server/alcuTaskChangeHelper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ServiceImplementation::Class>> archi$AutoPipeServer$Garant::Server::Server::TalcuTaskChangeHelper
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
  l3ProtoObject
  {$If not defined(Nemesis)}
  ,
  csTaskChangeHelper
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}
type
 TalcuTaskChangeHelper = {final} class(Tl3ProtoObject {$If not defined(Nemesis)}, IcsTaskChangeHelper{$IfEnd} //not Nemesis
 )
 public
 // realized methods
    {$If not defined(Nemesis)}
   procedure TaskGotErrorStatus;
    {$IfEnd} //not Nemesis
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TalcuTaskChangeHelper;
    {- возвращает экземпляр синглетона. }
 end;//TalcuTaskChangeHelper
{$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}
uses
  l3Base {a},
  alcuMailServer,
  alcuTypes
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}


// start class TalcuTaskChangeHelper

var g_TalcuTaskChangeHelper : TalcuTaskChangeHelper = nil;

procedure TalcuTaskChangeHelperFree;
begin
 l3Free(g_TalcuTaskChangeHelper);
end;

class function TalcuTaskChangeHelper.Instance: TalcuTaskChangeHelper;
begin
 if (g_TalcuTaskChangeHelper = nil) then
 begin
  l3System.AddExitProc(TalcuTaskChangeHelperFree);
  g_TalcuTaskChangeHelper := Create;
 end;
 Result := g_TalcuTaskChangeHelper;
end;


class function TalcuTaskChangeHelper.Exists: Boolean;
 {-}
begin
 Result := g_TalcuTaskChangeHelper <> nil;
end;//TalcuTaskChangeHelper.Exists

{$If not defined(Nemesis)}
procedure TalcuTaskChangeHelper.TaskGotErrorStatus;
//#UC START# *F75B4443B80B_5583CD3601BD_var*
//#UC END# *F75B4443B80B_5583CD3601BD_var*
begin
//#UC START# *F75B4443B80B_5583CD3601BD_impl*
 alcuMail.SendSMSNotify(eventTaskError, dd_apsProcessQuery);
//#UC END# *F75B4443B80B_5583CD3601BD_impl*
end;//TalcuTaskChangeHelper.TaskGotErrorStatus
{$IfEnd} //not Nemesis

{$IfEnd} //AppServerSide

initialization
{$If defined(AppServerSide)}
// Регистрация TalcuTaskChangeHelper
 {$If not defined(Nemesis)}
 TcsTaskChangeHelper.Instance.Alien := TalcuTaskChangeHelper.Instance;
 {$IfEnd} //not Nemesis

{$IfEnd} //AppServerSide

end.