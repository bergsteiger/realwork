unit nsWindowsList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "UserInteraction"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/UserInteraction/nsWindowsList.pas"
// Начат: 19.10.2009 15:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Operations::OfficeLike::UserInteraction::WindowsListSupport::TnsWindowsList
//
// класс управляющий списком окон
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  nsWindowsListPrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TnsWindowsList = class(TnsWindowsListPrim)
  {* класс управляющий списком окон }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsWindowsList;
    {- возвращает экземпляр синглетона. }
 end;//TnsWindowsList
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


// start class TnsWindowsList

var g_TnsWindowsList : TnsWindowsList = nil;

procedure TnsWindowsListFree;
begin
 l3Free(g_TnsWindowsList);
end;

class function TnsWindowsList.Instance: TnsWindowsList;
begin
 if (g_TnsWindowsList = nil) then
 begin
  l3System.AddExitProc(TnsWindowsListFree);
  g_TnsWindowsList := Create;
 end;
 Result := g_TnsWindowsList;
end;


class function TnsWindowsList.Exists: Boolean;
 {-}
begin
 Result := g_TnsWindowsList <> nil;
end;//TnsWindowsList.Exists

{$IfEnd} //not NoVCM

end.