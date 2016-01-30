unit vcmFormDispatcherInterfaces;
 {* Интерфейсы для работы с диспетчером форм }

// Модуль: "w:\common\components\gui\Garant\VCM\vcmFormDispatcherInterfaces.pas"
// Стереотип: "Interfaces"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
;

type
 IvcmFormDispatcherListener = interface(IvcmBase)
  ['{BABDE672-E93F-47FE-977B-BA11D6250821}']
  procedure StartNewMainForm;
   {* вызывается перед созданием главной формы }
 end;//IvcmFormDispatcherListener

 IvcmFormDispatcherNotify = interface(IvcmBase)
  {* Уведомляет о событиях диспетчера форм }
  ['{B91EBDC9-90C1-4165-BD33-8EB57BA4DACA}']
  procedure AddListener(const aListener: IvcmFormDispatcherListener);
  procedure RemoveListener(const aListener: IvcmFormDispatcherListener);
 end;//IvcmFormDispatcherNotify
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
