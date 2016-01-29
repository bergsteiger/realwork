unit SplashServerInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Splash"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Splash/SplashServerInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Core::Splash::Splash::SplashServerInterfaces
//
// Интерфейсы для сервера
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
  l3Interfaces
  ;

type
 InsSplashWaiter = interface(IUnknown)
  {* Объект ожидающий нотификацию о том, что клиент хочет погасить сплеш }
   ['{3551107A-2BC6-4CC3-94EA-7F5455557CB0}']
   procedure CanCloseSplash;
     {* Клиент разрешил закрыть сплеш }
 end;//InsSplashWaiter

 InsSplashInfo = interface(IUnknown)
  {* Информация с описанием сплеша, который надо показать }
   ['{CBECD569-DD17-4BFB-8FAA-F16E652356A4}']
   function Get_Waiter: InsSplashWaiter;
   procedure Set_Waiter(const aValue: InsSplashWaiter);
   function Get_IsValid: Boolean;
   function Get_MinimalShowTime: Cardinal;
   function Get_Warning: Il3CString;
   function Get_UserInfo: Il3CString;
   function Get_ApplicationTitle: PAnsiChar;
   procedure SwitchToParent;
     {* Переключиться на окно клиента (в конце показа) }
   function MakeSplashDataStream: IStream;
   function MakeLogoStream: IStream;
     {* Создает поток для вычитывания TvtPngImageList в котормо лежит лого }
   property Waiter: InsSplashWaiter
     read Get_Waiter
     write Set_Waiter;
     {* Нотификатор, которому надо сказать, что клиент кочет закрыть сплеш.
По идее достаточно этого, а не полноценного Publisher/Subscriber }
   property IsValid: Boolean
     read Get_IsValid;
     {* Данные успешно вычитаны и можно показывать сплеш }
   property MinimalShowTime: Cardinal
     read Get_MinimalShowTime;
     {* Минимальное время показа сплеша }
   property Warning: Il3CString
     read Get_Warning;
     {* Предупреждение о нарушении авторских прав. }
   property UserInfo: Il3CString
     read Get_UserInfo;
     {* Строка с информацией о пользователе }
   property ApplicationTitle: PAnsiChar
     read Get_ApplicationTitle;
     {* Заголовок клиентского приложения }
 end;//InsSplashInfo
{$IfEnd} //not Admin AND not Monitorings

implementation

end.