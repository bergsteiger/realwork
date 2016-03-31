unit nsInpharmContextHistoryPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsInpharmContextHistoryPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsInpharmContextHistoryPrim" MUID: (4AD846290145)

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
 TnsInpharmContextHistoryPrim = class(_nsContextHistoryPrim_, InsContextSearchHistory)
  public
   constructor Create; reintroduce;
   class function Make: InsContextSearchHistory; reintroduce;
 end;//TnsInpharmContextHistoryPrim
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
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsContextHistoryPrim.imp.pas}

constructor TnsInpharmContextHistoryPrim.Create;
//#UC START# *4AD846560013_4AD846290145_var*
//#UC END# *4AD846560013_4AD846290145_var*
begin
//#UC START# *4AD846560013_4AD846290145_impl*
 inherited Create(ns_chkInpharm);
//#UC END# *4AD846560013_4AD846290145_impl*
end;//TnsInpharmContextHistoryPrim.Create

class function TnsInpharmContextHistoryPrim.Make: InsContextSearchHistory;
var
 l_Inst : TnsInpharmContextHistoryPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsInpharmContextHistoryPrim.Make
{$IfEnd} // NOT Defined(Admin)

end.
