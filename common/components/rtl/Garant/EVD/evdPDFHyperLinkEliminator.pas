unit evdPDFHyperLinkEliminator;
 {* Фильтр, удаляющий ссылки для PDF. }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdPDFHyperLinkEliminator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevdPDFHyperLinkEliminator" MUID: (541A7EEC0051)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , evdHyperlinkEliminator
 , l3Variant
;

type
 TevdPDFHyperLinkEliminator = class(TevdHyperlinkEliminator)
  {* Фильтр, удаляющий ссылки для PDF. }
  protected
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevdPDFHyperLinkEliminator

implementation

uses
 l3ImplUses
 , k2Tags
 , k2VariantImpl
 , k2Types
 , evdStyles
 //#UC START# *541A7EEC0051impl_uses*
 //#UC END# *541A7EEC0051impl_uses*
;

procedure TevdPDFHyperLinkEliminator.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4836D52400D9_541A7EEC0051_var*
var
 l_Value: Tk2Variant;
//#UC END# *4836D52400D9_541A7EEC0051_var*
begin
//#UC START# *4836D52400D9_541A7EEC0051_impl*
 if (AtomIndex = k2_tiStyle) and (Value.AsInteger = ev_saHyperLinkCont) then
 begin
  l_Value := Tk2VariantImpl.Make(ev_saContents);
  try
   inherited AddAtomEx(AtomIndex, l_Value);
  finally
   l_Value := nil;
  end;
 end // if (AtomIndex = k2_tiStyle) and (Value.AsInteger = ev_saHyperLinkCont) then
 else
  inherited;
//#UC END# *4836D52400D9_541A7EEC0051_impl*
end;//TevdPDFHyperLinkEliminator.AddAtomEx

end.
