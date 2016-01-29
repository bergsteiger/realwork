{$IfNDef k2DoQT_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2DoQT.imp.pas"
// Начат: 16.12.2010 19:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::K2::k2PrimObjects::k2DoQT
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define k2DoQT_imp}
 _k2DoQT_ = {mixin} class(_k2DoQT_Parent_)
 public
 // overridden public methods
   function DoQT(const IID: TGUID;
     out Obj;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//_k2DoQT_

{$Else k2DoQT_imp}

// start class _k2DoQT_

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

{$EndIf k2DoQT_imp}
