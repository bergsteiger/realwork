unit nsParaModifier;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsParaModifier.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , evPara_Wrap
 , l3Variant
;

type
 TnsParaModifier = class(TevdParaModifier)
  public
   class function MarkModified(aTag: Tl3Variant): Boolean; override;
 end;//TnsParaModifier

implementation

uses
 l3ImplUses
;

class function TnsParaModifier.MarkModified(aTag: Tl3Variant): Boolean;
//#UC START# *4CEE6187015A_4CEE65B701A4_var*
//#UC END# *4CEE6187015A_4CEE65B701A4_var*
begin
//#UC START# *4CEE6187015A_4CEE65B701A4_impl*
 Result := aTag.Owner.MarkModified;
//#UC END# *4CEE6187015A_4CEE65B701A4_impl*
end;//TnsParaModifier.MarkModified

initialization
//#UC START# *4CEE685E0003*
 g_ParaModifier := TnsParaModifier;
//#UC END# *4CEE685E0003*

end.
