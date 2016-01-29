unit NOT_FINISHED_vcmRepOperationsCollectionItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Components/NOT_FINISHED_vcmRepOperationsCollectionItem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Components::TvcmRepOperationsCollectionItem
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
  vcmBaseOperationsCollectionItem
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmFormActivate = class
 end;//TvcmFormActivate

 TvcmRepOperationsCollectionItem = class(TvcmBaseOperationsCollectionItem)
 end;//TvcmRepOperationsCollectionItem
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
// Регистрация TvcmRepOperationsCollectionItem
 TtfwClassRef.Register(TvcmRepOperationsCollectionItem);
{$IfEnd} //not NoScripts AND not NoVCM

end.