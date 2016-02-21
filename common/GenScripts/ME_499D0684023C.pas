unit SplashInterfaces;
 {* Интерфесы для клиента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Splash\SplashInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 InsSplashClient = interface
  {* Невизуальный объект.
Готовит данные для сервера и запускает его.
Перед разрушением говорит серверу, что можно уже не показывать сплеш. }
  ['{6DE59664-EC43-42E5-AE95-A2465CF37006}']
 end;//InsSplashClient
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
