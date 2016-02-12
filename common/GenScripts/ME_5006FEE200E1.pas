unit atSaveJournalQueryToXMLOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atSaveJournalQueryToXMLOperation.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , atIterateUserJournalOperation
 , atQuery
 , atUserJournalHelper
;

type
 _atSaveQueryToXMLAddon_Parent_ = TatIterateUserJournalOperation;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atSaveQueryToXMLAddon.imp.pas}
 TatSaveJournalQueryToXMLOperation = class(_atSaveQueryToXMLAddon_)
  protected
   function OnQuery(const anQuery: TatQuery): Boolean; override;
   function OnBookmark(const aBookmark: TatJournalBookmark): Boolean; override;
 end;//TatSaveJournalQueryToXMLOperation

implementation

uses
 l3ImplUses
 , atLogger
 , atCommon
 , XMLIntf
 , SysUtils
 , atQueryTypeConverter
 , Windows
;

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atSaveQueryToXMLAddon.imp.pas}

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
