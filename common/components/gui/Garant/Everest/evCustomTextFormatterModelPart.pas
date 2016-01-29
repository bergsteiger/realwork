unit evCustomTextFormatterModelPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evCustomTextFormatterModelPart.pas"
// Начат: 30.01.2012 13:42
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevCustomTextFormatterModelPart
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdDocumentFilter,
  l3Variant
  ;

type
 TevCustomTextFormatterModelPart = class(TevdDocumentFilter)
 protected
 // protected methods
   procedure ValidateStyles(aPara: Tl3Variant);
 end;//TevCustomTextFormatterModelPart

implementation

uses
  evdTypes,
  ObjectSegment_Const,
  evdTextStyle_Const,
  k2Tags,
  Formula_Const
  ;

// start class TevCustomTextFormatterModelPart

procedure TevCustomTextFormatterModelPart.ValidateStyles(aPara: Tl3Variant);

 function DoIt(anItem: Tl3Variant;
   anIndex: Integer): Boolean;
 var
  l_Layer : Tl3Variant;

  function DoIt(anItem: Tl3Variant;
    anIndex: Integer): Boolean;
  //#UC START# *87A18881C23B__var*
  //#UC END# *87A18881C23B__var*
  begin
  //#UC START# *87A18881C23B__impl*
   Result := true;
   if (anItem.IntA[k2_tiStyle] = evd_saObject) then
    if not anItem.IsKindOf(k2_typObjectSegment) then
     l_Layer.DeleteChild(anItem);
  //#UC END# *87A18881C23B__impl*
  end;//DoIt

 //#UC START# *4F26694603B5__var*
 //#UC END# *4F26694603B5__var*
 begin
  //#UC START# *4F26694603B5iter*
  Result := true;
  l_Layer := anItem;
  //if (l_Layer.IntA[k2_tiHandle] <> ev_slObjects) then
   l_Layer.
  //#UC END# *4F26694603B5iter*
   IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@DoIt));
 end;//DoIt

//#UC START# *4F2666AC03A4_4F26660203CB_var*
//#UC END# *4F2666AC03A4_4F26660203CB_var*
begin
 //#UC START# *4F2666AC03A4iter*
 if (aPara.IntA[k2_tiStyle] = evd_saObject) then
  if not aPara.IsKindOf(k2_typFormula) then
   aPara.AttrW[k2_tiStyle, nil] := nil;
 aPara.Attr[k2_tiSegments].
 //#UC END# *4F2666AC03A4iter*
  IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@DoIt));
end;//TevCustomTextFormatterModelPart.ValidateStyles

end.