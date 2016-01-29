unit nsStringValueMapFactoryRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Common/nsStringValueMapFactoryRes.pas"
// Начат: 19.01.2012 17:30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Common::nsStringValueMapFactoryRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3StringIDEx
  ;

var
  { Локализуемые строки Local }
 str_cpClassCaptionReview : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cpClassCaptionReview'; rValue : 'Раздел/Тема в ОИЗ');
  { 'Раздел/Тема в ОИЗ' }
 str_cpSourceCaptionReview : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cpSourceCaptionReview'; rValue : 'Орган/Источник в ОИЗ');
  { 'Орган/Источник в ОИЗ' }

implementation

uses
  l3MessageID
  ;


initialization
// Инициализация str_cpClassCaptionReview
 str_cpClassCaptionReview.Init;
// Инициализация str_cpSourceCaptionReview
 str_cpSourceCaptionReview.Init;

end.