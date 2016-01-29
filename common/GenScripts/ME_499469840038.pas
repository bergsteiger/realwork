unit vcmFormDispatcherInterfaces;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
;

type
 IvcmFormDispatcherListener = interface(IvcmBase)
  procedure StartNewMainForm;
   {* вызывается перед созданием главной формы }
 end;//IvcmFormDispatcherListener
 
 IvcmFormDispatcherNotify = interface(IvcmBase)
  {* Уведомляет о событиях диспетчера форм }
  procedure AddListener(const aListener: IvcmFormDispatcherListener);
  procedure RemoveListener(const aListener: IvcmFormDispatcherListener);
 end;//IvcmFormDispatcherNotify
 
implementation

uses
 l3ImplUses
;

end.
