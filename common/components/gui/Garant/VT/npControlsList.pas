unit npControlsList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$WithVCM"
// Модуль: "w:/common/components/gui/Garant/VT/npControlsList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$WithVCM::vtNavigator::TnpControlsList
//
// список навигаторов на форме, от которых были отстыкованы компоненты.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  npControlsListPrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TnpControlsList = class(TnpControlsListPrim)
  {* список навигаторов на форме, от которых были отстыкованы компоненты. }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnpControlsList;
    {- возвращает экземпляр синглетона. }
 end;//TnpControlsList
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


// start class TnpControlsList

var g_TnpControlsList : TnpControlsList = nil;

procedure TnpControlsListFree;
begin
 l3Free(g_TnpControlsList);
end;

class function TnpControlsList.Instance: TnpControlsList;
begin
 if (g_TnpControlsList = nil) then
 begin
  l3System.AddExitProc(TnpControlsListFree);
  g_TnpControlsList := Create;
 end;
 Result := g_TnpControlsList;
end;


class function TnpControlsList.Exists: Boolean;
 {-}
begin
 Result := g_TnpControlsList <> nil;
end;//TnpControlsList.Exists

{$IfEnd} //not NoVCM

end.