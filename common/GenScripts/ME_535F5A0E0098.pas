unit arSubImplementation;

// Модуль: "w:\archi\source\projects\Archi\Editor\arSubImplementation.pas"
// Стереотип: "SimpleClass"

{$Include arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , evSubImplementation
 , nevBase
;

type
 TarSubImplementation = class(TevSubImplementation)
  protected
   function DoGetFlags(aTag: Tl3Variant;
    aFlag: LongInt): LongInt; override;
 end;//TarSubImplementation
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , dt_Const
 , k2Tags
 , l3Bits
 , Block_Const
;

function TarSubImplementation.DoGetFlags(aTag: Tl3Variant;
 aFlag: LongInt): LongInt;
//#UC START# *535F5A7D00BB_535F5A0E0098_var*
var
 l_Tag    : Tl3Variant;
 l_Childs : Tl3Variant;
//#UC END# *535F5A7D00BB_535F5A0E0098_var*
begin
//#UC START# *535F5A7D00BB_535F5A0E0098_impl*
 Result := inherited DoGetFlags(aTag, aFlag);
 if aTag.IsKindOf(k2_typBlock) then
  l_Tag := aTag
 else
  l_Tag := aTag.rAtomEx([k2_tiSubs,
                         k2_tiChildren, k2_tiHandle, LayerID,
                         k2_tiChildren, k2_tiHandle, ID]);
 l_Childs := l_Tag.Attr[k2_tiKeyWords];
 if l_Childs.IsValid and (l_Childs.ChildrenCount > 0) then
  l3SetBit(Result, sfbitKeyWords);
 l_Childs := l_Tag.Attr[k2_tiClasses];
 if l_Childs.IsValid and (l_Childs.ChildrenCount > 0) then
  l3SetBit(Result, sfbitTreeNodes);
 l_Childs := l_Tag.Attr[k2_tiTypes];
 if l_Childs.IsValid and (l_Childs.ChildrenCount > 0) then
  l3SetBit(Result, sfbitDocType);
//#UC END# *535F5A7D00BB_535F5A0E0098_impl*
end;//TarSubImplementation.DoGetFlags
{$IfEnd} // Defined(AppClientSide)

end.
