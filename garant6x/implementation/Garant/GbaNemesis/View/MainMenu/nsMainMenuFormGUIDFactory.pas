unit nsMainMenuFormGUIDFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/nsMainMenuFormGUIDFactory.pas"
// Начат: 25.01.2012 18:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Интерфейсные элементы::MainMenu::View::MainMenu::TnsMainMenuFormGUIDFactory
//
// Фабрика GUID'ов для ОМ
// http://mdp.garant.ru/pages/viewpage.action?pageId=326773370&focusedCommentId=330698414#comment-
// 330698414
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
 TnsMainMenuFormGUIDFactory = class(TvcmFormGUIDFromMainFormList)
  {* Фабрика GUID'ов для ОМ
http://mdp.garant.ru/pages/viewpage.action?pageId=326773370&focusedCommentId=330698414#comment-330698414 }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsMainMenuFormGUIDFactory;
    {- возвращает экземпляр синглетона. }
 end;//TnsMainMenuFormGUIDFactory
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class TnsMainMenuFormGUIDFactory

var g_TnsMainMenuFormGUIDFactory : TnsMainMenuFormGUIDFactory = nil;

procedure TnsMainMenuFormGUIDFactoryFree;
begin
 l3Free(g_TnsMainMenuFormGUIDFactory);
end;

class function TnsMainMenuFormGUIDFactory.Instance: TnsMainMenuFormGUIDFactory;
begin
 if (g_TnsMainMenuFormGUIDFactory = nil) then
 begin
  l3System.AddExitProc(TnsMainMenuFormGUIDFactoryFree);
  g_TnsMainMenuFormGUIDFactory := Create;
 end;
 Result := g_TnsMainMenuFormGUIDFactory;
end;


class function TnsMainMenuFormGUIDFactory.Exists: Boolean;
 {-}
begin
 Result := g_TnsMainMenuFormGUIDFactory <> nil;
end;//TnsMainMenuFormGUIDFactory.Exists

{$IfEnd} //not Admin AND not Monitorings

end.