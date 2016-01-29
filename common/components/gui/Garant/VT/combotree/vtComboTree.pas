unit vtComboTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/ComboTree/vtComboTree.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT::ComboTree::TvtComboTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
  FakeBox
  ;

type
 TvtComboTree = class(TFakeBox)
 end;//TvtComboTree

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  vtComboTreeWordsPack
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  vtComboBoxWordsPack
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// Регистрация TvtComboTree
 TtfwClassRef.Register(TvtComboTree);
{$IfEnd} //not NoScripts

end.