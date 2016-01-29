unit F1Test;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1Test"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1Test.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestLibrary::Category>> F1 Базовые определения предметной области::F1Test
//
// Сборник тестов для оболочки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

implementation

{$If not defined(XE)}
uses
  EverestTest,
  VTTest
  {$If not defined(NoVCM) AND not defined(XE)}
  ,
  VCMTest
  {$IfEnd} //not NoVCM AND not XE
  
  {$If defined(Nemesis) AND not defined(XE)}
  ,
  NemesisTest
  {$IfEnd} //Nemesis AND not XE
  ,
  AFWTest
  {$If not defined(NoVGScene) AND not defined(XE)}
  ,
  VGSceneTest
  {$IfEnd} //not NoVGScene AND not XE
  ,
  TestDocListUtils,
  MessageOnDesktop,
  TestStringUtils,
  nsDocumentsList_p,
  tc5OpenApp {a},
  tc6OpenApp {a}
  ;
{$IfEnd} //not XE

end.