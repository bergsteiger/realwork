unit nsContextHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ContextHistory"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/rtl/Garant/ContextHistory/nsContextHistory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Common For Shell And Monitoring::Search::ContextHistory::ContextHistory::nsContextHistory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  ContextHistoryInterfaces
  ;

function NsGetContextHistory(aKind: TnsContextHistoryKind): InsContextSearchHistory;
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  nsInpharmContextHistory,
  nsDocumentContextHistory
  ;

// unit methods

function NsGetContextHistory(aKind: TnsContextHistoryKind): InsContextSearchHistory;
//#UC START# *4AD85724035A_4AD8570C01CC_var*
//#UC END# *4AD85724035A_4AD8570C01CC_var*
begin
//#UC START# *4AD85724035A_4AD8570C01CC_impl*
 case aKind of
  ns_chkDocument:
   Result := TnsDocumentContextHistory.Make;
  ns_chkInpharm:
   Result := TnsInpharmContextHistory.Make;
 else
  Result := nil;
 end;
//#UC END# *4AD85724035A_4AD8570C01CC_impl*
end;//NsGetContextHistory
{$IfEnd} //not Admin

end.