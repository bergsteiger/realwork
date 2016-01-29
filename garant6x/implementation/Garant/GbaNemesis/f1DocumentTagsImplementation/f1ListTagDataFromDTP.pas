unit f1ListTagDataFromDTP;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/f1ListTagDataFromDTP.pas"
// Начат: 23.08.2010 17:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::TagDataProviders::Tf1ListTagDataFromDTP
//
// Поставщик данных о списке параграфов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  f1TagDataFromDTP,
  DocumentUnit
  ;

type
 _nsParentedTagData_Parent_ = Tf1ListTagDataFromDTPPrim;
 {$Include ..\f1DocumentTagsImplementation\nsParentedTagData.imp.pas}
 Tf1ListTagDataFromDTP = class(_nsParentedTagData_)
  {* Поставщик данных о списке параграфов }
 end;//Tf1ListTagDataFromDTP

implementation

uses
  SysUtils,
  l3Base
  ;

{$Include ..\f1DocumentTagsImplementation\nsParentedTagData.imp.pas}

end.