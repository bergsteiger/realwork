unit L10nInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Model"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Model/L10nInterfaces.pas"
// Начат: 10.02.2009 17:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Базовые определения предметной области::LegalDomain::Model::L10nInterfaces
//
// Интерфейсы для локализации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3Interfaces,
  afwInterfaces
  ;

type
 InsStringValueMap = afwInterfaces.IafwStringValueMap;

 InsSpecialStringValueMap = interface(InsStringValueMap)
  {* мапа "<число> %"-"строковое число" со строковым спец значением "Во весь экран" }
   ['{808A21E0-63EB-4659-AA60-9D0CB1EF937E}']
   function Get_SpecialDisplayName: Il3CString;
   function Get_SpecialValue: Il3CString;
   function Get_MinValue: Integer;
   function Get_MaxValue: Integer;
   property SpecialDisplayName: Il3CString
     read Get_SpecialDisplayName;
   property SpecialValue: Il3CString
     read Get_SpecialValue;
   property MinValue: Integer
     read Get_MinValue;
   property MaxValue: Integer
     read Get_MaxValue;
 end;//InsSpecialStringValueMap

 InsStringsSource = afwInterfaces.IafwStringsSource;

 TnsValueMapID = afwInterfaces.TafwValueMapID;

 InsValueMap = afwInterfaces.IafwValueMap;

 InsStringValueMapFactory = afwInterfaces.IafwStringValueMapFactory;

 InsStringValueMapManager = afwInterfaces.IafwStringValueMapManager;

 InsIntegerValueMap = afwInterfaces.IafwIntegerValueMap;

 InsIntegerValueMapFactory = afwInterfaces.IafwIntegerValueMapFactory;

 InsIntegerValueMapManager = afwInterfaces.IafwIntegerValueMapManager;

implementation

end.