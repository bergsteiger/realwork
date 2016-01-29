unit nsBaseSearchFormGUIDFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearch/nsBaseSearchFormGUIDFactory.pas"
// Начат: 24.01.2012 20:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Основные прецеденты::BaseSearch::View::BaseSearch$Module::TnsBaseSearchFormGUIDFactory
//
// Фабрика GUID'ов для форм БП
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmFormGUIDFromMainFormList
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsBaseSearchFormGUIDFactory = class(TvcmFormGUIDFromMainFormList)
  {* Фабрика GUID'ов для форм БП }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsBaseSearchFormGUIDFactory;
    {- возвращает экземпляр синглетона. }
 end;//TnsBaseSearchFormGUIDFactory
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class TnsBaseSearchFormGUIDFactory

var g_TnsBaseSearchFormGUIDFactory : TnsBaseSearchFormGUIDFactory = nil;

procedure TnsBaseSearchFormGUIDFactoryFree;
begin
 l3Free(g_TnsBaseSearchFormGUIDFactory);
end;

class function TnsBaseSearchFormGUIDFactory.Instance: TnsBaseSearchFormGUIDFactory;
begin
 if (g_TnsBaseSearchFormGUIDFactory = nil) then
 begin
  l3System.AddExitProc(TnsBaseSearchFormGUIDFactoryFree);
  g_TnsBaseSearchFormGUIDFactory := Create;
 end;
 Result := g_TnsBaseSearchFormGUIDFactory;
end;


class function TnsBaseSearchFormGUIDFactory.Exists: Boolean;
 {-}
begin
 Result := g_TnsBaseSearchFormGUIDFactory <> nil;
end;//TnsBaseSearchFormGUIDFactory.Exists

{$IfEnd} //not Admin AND not Monitorings

end.