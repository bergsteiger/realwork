unit OfficeLikeAppInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "UserInteraction"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/UserInteraction/OfficeLikeAppInterfaces.pas"
// Начат: 20.10.2009 20:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi Operations::OfficeLike::UserInteraction::OfficeLikeAppInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces
  ;

type
 InsWindow = interface(IUnknown)
  {* интерфейс окна. Для работы с окнами системы }
   ['{8F95EBB5-E396-4AF3-9A6A-EFD0684A20C9}']
   function Get_Form: IvcmEntityForm;
   property Form: IvcmEntityForm
     read Get_Form;
 end;//InsWindow
{$IfEnd} //not NoVCM

implementation

end.