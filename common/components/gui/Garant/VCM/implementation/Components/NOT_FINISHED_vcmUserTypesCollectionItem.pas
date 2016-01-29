unit NOT_FINISHED_vcmUserTypesCollectionItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Components/NOT_FINISHED_vcmUserTypesCollectionItem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::UserTypes::TvcmUserTypesCollectionItem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmBaseUserTypesCollectionItem
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmUserTypesCollectionItem = class(TvcmBaseUserTypesCollectionItem)
 end;//TvcmUserTypesCollectionItem
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TvcmUserTypesCollectionItem
 TtfwClassRef.Register(TvcmUserTypesCollectionItem);
{$IfEnd} //not NoScripts AND not NoVCM

end.