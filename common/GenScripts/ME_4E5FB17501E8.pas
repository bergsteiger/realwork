unit nevObjectSegmentFormatInfo;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevObjectSegmentFormatInfo.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevSegmentFormatInfo
 , nevBase
 , nevFormatInfo
;

type
 TnevCachedFontArray = array [Boolean] of TnevCachedFont;

 TnevObjectSegmentFormatInfo = class(TnevSegmentFormatInfo)
  private
   f_Font: TnevCachedFontArray;
  protected
   procedure ClearCache; override;
   function GetObjIFont(aCorrectItalic: Boolean): InevFont; override;
   function DoGetFont(aCorrectItalic: Boolean): InevFont; override;
 end;//TnevObjectSegmentFormatInfo

implementation

uses
 l3ImplUses
 , nevTools
 , evGlyphFont
 , BitmapPara_Const
;

procedure TnevObjectSegmentFormatInfo.ClearCache;
//#UC START# *4E5E7D240227_4E5FB17501E8_var*
//#UC END# *4E5E7D240227_4E5FB17501E8_var*
begin
//#UC START# *4E5E7D240227_4E5FB17501E8_impl*
 inherited;
 Finalize(f_Font);
 f_Font[false].rIsCached := false;
 f_Font[true].rIsCached := false;
//#UC END# *4E5E7D240227_4E5FB17501E8_impl*
end;//TnevObjectSegmentFormatInfo.ClearCache

function TnevObjectSegmentFormatInfo.GetObjIFont(aCorrectItalic: Boolean): InevFont;
//#UC START# *4E60BA9903B0_4E5FB17501E8_var*
var
 l_Map : TnevFormatInfoPrim;
 l_Obj : InevObject;
//#UC END# *4E60BA9903B0_4E5FB17501E8_var*
begin
//#UC START# *4E60BA9903B0_4E5FB17501E8_impl*
 Result := inherited GetObjIFont(aCorrectItalic);
 if not Obj.AsObject.Child[0].QT(InevObject, l_Obj) then
  Assert(false);
(*  Assert(aParentFI <> nil);
 l_Map := aParentFI.InfoForChild(l_Obj);*)
 Assert(Parent <> nil);
 l_Map := Parent.GetInfoForChild(l_Obj);
 // - тут потом надо будет написать l_Map := Self.InfoForChild(l_Obj);
 Result := TevGlyphFont.Make(l_Obj.AsObject.IsKindOf(k2_typBitmapPara),
                             l_Map.Width,
                             l_Map.Height,
                             Result);
//#UC END# *4E60BA9903B0_4E5FB17501E8_impl*
end;//TnevObjectSegmentFormatInfo.GetObjIFont

function TnevObjectSegmentFormatInfo.DoGetFont(aCorrectItalic: Boolean): InevFont;
//#UC START# *4E60CEB700BD_4E5FB17501E8_var*
//#UC END# *4E60CEB700BD_4E5FB17501E8_var*
begin
//#UC START# *4E60CEB700BD_4E5FB17501E8_impl*
 if not f_Font[aCorrectItalic].rIsCached then
 begin
  f_Font[aCorrectItalic].rValue := GetObjIFont(aCorrectItalic);
  f_Font[aCorrectItalic].rIsCached := true;
 end;//not f_Font.rIsCached
 Result := f_Font[aCorrectItalic].rValue;
//#UC END# *4E60CEB700BD_4E5FB17501E8_impl*
end;//TnevObjectSegmentFormatInfo.DoGetFont

end.
