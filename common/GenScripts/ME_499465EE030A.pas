unit vcmToolbarsInterfaces;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
;

type
 IvcmToolbarsCustomizeListener = interface(IvcmBase)
  {* Слушатель событий настройки панелей инструментов }
  procedure BeforeCustomize;
   {* вызывается перед вызовом окна редактирования панелей инструментов }
 end;//IvcmToolbarsCustomizeListener
 
 IvcmToolbarsCustomizeNotify = interface(IvcmBase)
  {* Уведомляет о событиях редактирования панели инструментов }
  procedure AddListener(const aListener: IvcmToolbarsCustomizeListener);
  procedure RemoveListener(const aListener: IvcmToolbarsCustomizeListener);
 end;//IvcmToolbarsCustomizeNotify
 
 IvcmToolbarsCustomize = interface(IvcmBase)
  {* Настройка панелей инструментов }
 end;//IvcmToolbarsCustomize
 
implementation

uses
 l3ImplUses
;

end.
