unit vcmToolbarsInterfaces;
 {* Интерфейсы для работы с панелями инструментов }

// Модуль: "w:\common\components\gui\Garant\VCM\vcmToolbarsInterfaces.pas"
// Стереотип: "Interfaces"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
;

type
 IvcmToolbarsCustomizeListener = interface(IvcmBase)
  {* Слушатель событий настройки панелей инструментов }
  ['{68687746-F997-4BEC-BD6B-BDCFBD82726B}']
  procedure BeforeCustomize;
   {* вызывается перед вызовом окна редактирования панелей инструментов }
 end;//IvcmToolbarsCustomizeListener

 IvcmToolbarsCustomizeNotify = interface(IvcmBase)
  {* Уведомляет о событиях редактирования панели инструментов }
  ['{30A12550-6409-4E0E-B7FD-817414AE3CC2}']
  procedure AddListener(const aListener: IvcmToolbarsCustomizeListener);
  procedure RemoveListener(const aListener: IvcmToolbarsCustomizeListener);
 end;//IvcmToolbarsCustomizeNotify

 IvcmToolbarsCustomize = interface(IvcmBase)
  {* Настройка панелей инструментов }
  ['{4A5A5457-01CE-4FFF-B872-7633827158D4}']
  function pm_GetNotify: IvcmToolbarsCustomizeNotify;
  property Notify: IvcmToolbarsCustomizeNotify
   read pm_GetNotify;
 end;//IvcmToolbarsCustomize
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
