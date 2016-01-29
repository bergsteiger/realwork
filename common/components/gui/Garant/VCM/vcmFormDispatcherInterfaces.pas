unit vcmFormDispatcherInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/vcmFormDispatcherInterfaces.pas"
// Начат: 12.02.2009 21:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VCM::vcmFormDispatcherInterfaces
//
// Интерфейсы для работы с диспетчером форм
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
{$IfEnd} //not NoVCM

implementation

end.