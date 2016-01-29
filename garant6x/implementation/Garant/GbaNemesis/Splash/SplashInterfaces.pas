unit SplashInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Splash"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Splash/SplashInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Core::Splash::Splash::SplashInterfaces
//
// Интерфесы для клиента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
type
 InsSplashClient = interface(IUnknown)
  {* Невизуальный объект.
Готовит данные для сервера и запускает его.
Перед разрушением говорит серверу, что можно уже не показывать сплеш. }
   ['{6DE59664-EC43-42E5-AE95-A2465CF37006}']
 end;//InsSplashClient
{$IfEnd} //not Admin AND not Monitorings

implementation

end.