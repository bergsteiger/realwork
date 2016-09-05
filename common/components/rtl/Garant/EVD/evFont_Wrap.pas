unit evFont_Wrap;
 {* Обёртка шрифта. }

// Модуль: "w:\common\components\rtl\Garant\EVD\evFont_Wrap.pas"
// Стереотип: "Wrapper"
// Элемент модели: "WevFont" MUID: (484CEEC803AD)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , k2Tag_Wrap
 , l3Variant
;

type
 WevFont = class(Wk2Tag)
  {* Обёртка шрифта. }
  protected
   function ObjToTag(aValue: TObject): Il3TagRef; override;
 end;//WevFont

implementation

uses
 l3ImplUses
 , Graphics
 , k2Interfaces
 , k2Tags
 , k2FontName_Const
 , Font_Const
 //#UC START# *484CEEC803ADimpl_uses*
 //#UC END# *484CEEC803ADimpl_uses*
;

function WevFont.ObjToTag(aValue: TObject): Il3TagRef;
//#UC START# *484CEAD301AE_484CEEC803AD_var*
var
 F    : TFont absolute aValue;
 Dest : Tl3Variant;
 St   : TFontStyles;
//#UC END# *484CEAD301AE_484CEEC803AD_var*
begin
//#UC START# *484CEAD301AE_484CEEC803AD_impl*
 if (aValue Is TFont) then
 begin
  Dest := AtomType.MakeTag.AsObject;
  try
   Dest.AttrW[k2_tiName, nil] := k2_typFontName.StrToTag(F.Name);
   Dest.IntA[k2_tiSize] := F.Size;
   Dest.IntA[k2_tiForeColor] := F.Color;
   St := F.Style;
   Dest.BoolA[k2_tiBold] := fsBold in St;
   Dest.BoolA[k2_tiItalic] := fsItalic in St;
   Dest.BoolA[k2_tiUnderline] := fsUnderline in St;
   Dest.BoolA[k2_tiStrikeout] := fsStrikeout in St;
   Dest.IntA[k2_tiPitch] := Integer(F.Pitch);
   Result := Dest.AsRef;
  finally
   Dest := nil;
  end;//try..finally
 end//aValue Is TFont
 else
  Result := inherited ObjToTag(aValue);
//#UC END# *484CEAD301AE_484CEEC803AD_impl*
end;//WevFont.ObjToTag

end.
