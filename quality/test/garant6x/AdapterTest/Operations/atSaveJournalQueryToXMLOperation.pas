unit atSaveJournalQueryToXMLOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atSaveJournalQueryToXMLOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatSaveJournalQueryToXMLOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atIterateUserJournalOperation,
  atQuery,
  atUserJournalHelper
  ;

type
 _atSaveQueryToXMLAddon_Parent_ = TatIterateUserJournalOperation;
 {$Include ..\Operations\atSaveQueryToXMLAddon.imp.pas}
 TatSaveJournalQueryToXMLOperation = class(_atSaveQueryToXMLAddon_)
 protected
 // realized methods
   function OnQuery(const anQuery: TatQuery): Boolean; override;
   function OnBookmark(const aBookmark: TatJournalBookmark): Boolean; override;
 end;//TatSaveJournalQueryToXMLOperation

implementation

uses
  atLogger,
  atCommon,
  XMLIntf,
  SysUtils,
  atQueryTypeConverter,
  Windows
  ;

{$Include ..\Operations\atSaveQueryToXMLAddon.imp.pas}

// start class TatSaveJournalQueryToXMLOperation

function TatSaveJournalQueryToXMLOperation.OnQuery(const anQuery: TatQuery): Boolean;
//#UC START# *5006F37302DF_5006FEE200E1_var*
//#UC END# *5006F37302DF_5006FEE200E1_var*
begin
//#UC START# *5006F37302DF_5006FEE200E1_impl*
  Result := false; // нечего выполнять в детях
  SaveQuery(anQuery);
//#UC END# *5006F37302DF_5006FEE200E1_impl*
end;//TatSaveJournalQueryToXMLOperation.OnQuery

function TatSaveJournalQueryToXMLOperation.OnBookmark(const aBookmark: TatJournalBookmark): Boolean;
//#UC START# *5006F4130346_5006FEE200E1_var*
//#UC END# *5006F4130346_5006FEE200E1_var*
begin
//#UC START# *5006F4130346_5006FEE200E1_impl*
  Result := false;
//#UC END# *5006F4130346_5006FEE200E1_impl*
end;//TatSaveJournalQueryToXMLOperation.OnBookmark

end.