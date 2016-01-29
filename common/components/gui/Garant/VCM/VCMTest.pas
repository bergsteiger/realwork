unit VCMTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCMTest"
// Модуль: "w:/common/components/gui/Garant/VCM/VCMTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestLibrary::Category>> Shared Delphi TestComplete Wrappers::VCMTest
//
// Тесты VCM
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

implementation

{$If not defined(NoVCM) AND not defined(XE)}
uses
  vcmProfilersCollection_p
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
  ,
  RectWrap
  {$IfEnd} //not NoTabs AND not NoVCM AND not XE
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
  ,
  vcmMenuForChromeLikeItemWrap
  {$IfEnd} //not NoTabs AND not NoVCM AND not XE
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
  ,
  vcmBaseMenuForChromeLike_p
  {$IfEnd} //not NoTabs AND not NoVCM AND not XE
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
  ,
  ChromeLikeTabSetControl_p
  {$IfEnd} //not NoTabs AND not NoVCM AND not XE
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
  ,
  ChromeLikeTab_p
  {$IfEnd} //not NoTabs AND not NoVCM AND not XE
  ,
  tc5OpenApp {a},
  tc6OpenApp {a}
  ;
{$IfEnd} //not NoVCM AND not XE

end.