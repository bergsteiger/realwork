unit nsBlockNode;
 {* Блок документа. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsBlockNode.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsBlockNodePrim
 , l3Variant
;

type
 TnsBlockNode = class(TnsBlockNodePrim)
  {* Блок документа. }
  protected
   procedure DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
    All: Boolean); override;
 end;//TnsBlockNode

implementation

uses
 l3ImplUses
 , k2Tags
;

procedure TnsBlockNode.DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
 All: Boolean);
//#UC START# *49A545D501F6_467FCEA901AC_var*
//#UC END# *49A545D501F6_467FCEA901AC_var*
begin
//#UC START# *49A545D501F6_467FCEA901AC_impl*
 if not All then
  Attr[k2_tiShortName];
 inherited;
//#UC END# *49A545D501F6_467FCEA901AC_impl*
end;//TnsBlockNode.DoIterateProperties

end.
