unit nevObjectSegmentFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevObjectSegmentFormatInfo.pas"
// Начат: 01.09.2011 20:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevObjectSegmentFormatInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevFormatInfo,
  nevSegmentFormatInfo,
  nevBase
  ;

type
 TnevCachedFontArray = array [Boolean] of TnevCachedFont;

 TnevObjectSegmentFormatInfo = class(TnevSegmentFormatInfo)
 private
 // private fields
   f_Font : TnevCachedFontArray;
 protected
 // overridden protected methods
   procedure ClearCache; override;
   function GetObjIFont(aCorrectItalic: Boolean): InevFont; override;
   function DoGetFont(aCorrectItalic: Boolean): InevFont; override;
 end;//TnevObjectSegmentFormatInfo

implementation

uses
  nevTools,
  evGlyphFont,
  BitmapPara_Const
  ;

// start class TnevObjectSegmentFormatInfo

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