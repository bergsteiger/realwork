unit SplashTypes;
 {* Внутренние типы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Splash\SplashTypes.pas"
// Стереотип: "Interfaces"
// Элемент модели: "SplashTypes" MUID: (499C07150302)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Windows
;

const
 {* Константы }
 cMemFileName = '{FD2B7487-1FEB-40A4-9D66-8532A4BB7C10}';
  {* Имя файла проецируемого в память }
 cGuardName = '{36F75AF8-F8E5-4C52-9046-1720F059F9A1}';
  {* Имя мьютекса для защиты данных }
 cFinishEventName = '{9B07B496-065C-474D-87D6-7FCA7A3184B0}';
  {* Сообщение от клиента к серверу о том, что оболочка все сделала и можно сплеш закрывать }
 cSplashVersion = 1;
  {* Версия протокола - для защиты от дурака }

type
 PnsSplashData = ^TnsSplashData;
  {* Указатель на заголовок }

 TnsSplashData = packed record
  {* Заголовок файла проецируемого в память }
  Version: Cardinal;
   {* Версия данных - для защиты от дурака }
  ProcessID: Cardinal;
   {* ID процесса сервера - для защиты от дурака }
  Size: Cardinal;
   {* Полный размер данных (с заголовком) }
  MinimalShowTime: Cardinal;
   {* Минимальное время показа сплеша }
  ParentWnd: THandle;
   {* Окно клиента, которому надо передать обратно фокус }
  SplashDataOffset: Cardinal;
   {* Смещение для данных флеша/картинки }
  SplashDataSize: Cardinal;
   {* Размер данных сплеша/картинки }
  ApplicationTitleOffset: Cardinal;
  ApplicationTitleSize: Cardinal;
   {* Передается как AnsiChar, включает конечный нуль }
  UserInfoOffset: Cardinal;
  UserInfoSize: Cardinal;
   {* Передается как WideChar, включает конечные нули }
  WarningOffset: Cardinal;
  WarningSize: Cardinal;
   {* Передается как WideChar, включает конечные нули }
  LogoOffset: Cardinal;
   {* Картинка с лого - едет компонент TvtPngImageList }
  LogoSize: Cardinal;
 end;//TnsSplashData
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
