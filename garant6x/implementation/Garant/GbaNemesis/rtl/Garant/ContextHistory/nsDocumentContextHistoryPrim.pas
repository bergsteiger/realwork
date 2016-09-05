unit nsDocumentContextHistoryPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsDocumentContextHistoryPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDocumentContextHistoryPrim" MUID: (4AD8457200F3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3SimpleObject
 , ContextHistoryInterfaces
 , InsContextSearchHistoryNotifierList
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _nsContextHistoryPrim_Parent_ = Tl3SimpleObject;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsContextHistoryPrim.imp.pas}
 TnsDocumentContextHistoryPrim = class(_nsContextHistoryPrim_, InsContextSearchHistory)
  public
   constructor Create; reintroduce;
   class function Make: InsContextSearchHistory; reintroduce;
 end;//TnsDocumentContextHistoryPrim
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , afwFacade
 , nsConst
 {$If NOT Defined(NoVCM)}
 , vcmStringList
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Types
 , l3String
 //#UC START# *4AD8457200F3impl_uses*
 //#UC END# *4AD8457200F3impl_uses*
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsContextHistoryPrim.imp.pas}

constructor TnsDocumentContextHistoryPrim.Create;
//#UC START# *4AD8461A0275_4AD8457200F3_var*
//#UC END# *4AD8461A0275_4AD8457200F3_var*
begin
//#UC START# *4AD8461A0275_4AD8457200F3_impl*
 inherited Create(ns_chkDocument);
//#UC END# *4AD8461A0275_4AD8457200F3_impl*
end;//TnsDocumentContextHistoryPrim.Create

class function TnsDocumentContextHistoryPrim.Make: InsContextSearchHistory;
var
 l_Inst : TnsDocumentContextHistoryPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsDocumentContextHistoryPrim.Make
{$IfEnd} // NOT Defined(Admin)

end.
