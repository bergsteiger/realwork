unit vcmToolbarsInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/vcmToolbarsInterfaces.pas"
// Начат: 12.02.2008 21:10
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VCM::vcmToolbarsInterfaces
//
// Интерфейсы для работы с панелями инструментов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces
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
{$IfEnd} //not NoVCM

implementation

end.