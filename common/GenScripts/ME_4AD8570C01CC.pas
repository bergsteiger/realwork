unit nsContextHistory;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsContextHistory.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , ContextHistoryInterfaces
;

function nsGetContextHistory(aKind: TnsContextHistoryKind): InsContextSearchHistory;
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , nsInpharmContextHistory
 , nsDocumentContextHistory
;

function nsGetContextHistory(aKind: TnsContextHistoryKind): InsContextSearchHistory;
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
end;//nsGetContextHistory
{$IfEnd} // NOT Defined(Admin)

end.
