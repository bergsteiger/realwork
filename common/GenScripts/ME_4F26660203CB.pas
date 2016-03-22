unit evCustomTextFormatterModelPart;

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomTextFormatterModelPart.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCustomTextFormatterModelPart" MUID: (4F26660203CB)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdDocumentFilter
 , l3Variant
;

type
 TevCustomTextFormatterModelPart = class(TevdDocumentFilter)
  protected
   procedure ValidateStyles(aPara: Tl3Variant);
 end;//TevCustomTextFormatterModelPart

implementation

uses
 l3ImplUses
 , evdTextStyle_Const
 , k2Tags
 , Formula_Const
 , evdTypes
 , ObjectSegment_Const
;

procedure TevCustomTextFormatterModelPart.ValidateStyles(aPara: Tl3Variant);

 function DoIt(anItem: Tl3Variant;
  anIndex: Integer): Boolean;
  {* Подитеративная функция для вызова L2Mk2ChildrenIterateChildrenFAction из ValidateStyles }
 var l_Layer: Tl3Variant;

  function DoIt(anItem: Tl3Variant;
   anIndex: Integer): Boolean;
   {* Подитеративная функция для вызова L2Mk2ChildrenIterateChildrenFAction из DoIt }
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
