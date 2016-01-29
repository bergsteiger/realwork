unit arSubImplementation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editor"
// Модуль: "w:/archi/source/projects/Archi/Editor/arSubImplementation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi::Editor::DocumentContainer::TarSubImplementation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  evSubImplementation,
  nevBase
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}
type
 TarSubImplementation = class(TevSubImplementation)
 protected
 // overridden protected methods
   function DoGetFlags(aTag: Tl3Variant;
     aFlag: LongInt): LongInt; override;
 end;//TarSubImplementation
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  dt_Const,
  k2Tags,
  l3Bits,
  Block_Const
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}

// start class TarSubImplementation

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

{$IfEnd} //AppClientSide

end.