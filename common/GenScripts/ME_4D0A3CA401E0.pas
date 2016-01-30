{$IfNDef k2DoQT_imp}

// Модуль: "w:\common\components\rtl\Garant\K2\k2DoQT.imp.pas"
// Стереотип: "Impurity"

{$Define k2DoQT_imp}

 _k2DoQT_ = class(_k2DoQT_Parent_)
  public
   function DoQT(const IID: TGUID;
    out Obj;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//_k2DoQT_

{$Else k2DoQT_imp}

{$IfNDef k2DoQT_imp_impl}

{$Define k2DoQT_imp_impl}

function _k2DoQT_.DoQT(const IID: TGUID;
 out Obj;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *532C4D4102D8_4D0A3CA401E0_var*
var
 l_Type    : Tk2Type;
 l_Factory : Tk2InterfaceFactory;
//#UC END# *532C4D4102D8_4D0A3CA401E0_var*
begin
//#UC START# *532C4D4102D8_4D0A3CA401E0_impl*
 Result := false;
 Pointer(Obj) := nil;
 l_Type := Tk2Type(_Instance_R_(Self).pm_GetTagType);
 if (l_Type <> nil) then
 begin
  l_Factory := l_Type.InterfaceFactory;
  if (l_Factory <> nil) then
   try
    Result := l_Factory.QueryToolN(_Instance_R_(Self), IID, Obj, aProcessor);
   finally
    l_Factory := nil;
   end;{try..finally}
 end;//l_Type <> nil
//#UC END# *532C4D4102D8_4D0A3CA401E0_impl*
end;//_k2DoQT_.DoQT

{$EndIf k2DoQT_imp_impl}

{$EndIf k2DoQT_imp}

