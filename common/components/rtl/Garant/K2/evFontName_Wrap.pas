unit evFontName_Wrap;

// Модуль: "w:\common\components\rtl\Garant\K2\evFontName_Wrap.pas"
// Стереотип: "Wrapper"
// Элемент модели: "WevFontName" MUID: (484CEA1E0104)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3String_Wrap
 , l3Variant
;

type
 WevFontName = class(Wl3String)
  protected
   function StrToTag(const aValue: AnsiString): Tl3Tag; override;
   function ObjToTag(aValue: TObject): Il3TagRef; override;
 end;//WevFontName

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , k2Base
 , l3FontManagerEx
 , k2FontName
 , l3LogFont
 , k2FontManager
 , k2FontName_Const
 //#UC START# *484CEA1E0104impl_uses*
 //#UC END# *484CEA1E0104impl_uses*
;

function WevFontName.StrToTag(const aValue: AnsiString): Tl3Tag;
//#UC START# *484CCEBC00DC_484CEA1E0104_var*
var
 FN : Tk2FontName;
//#UC END# *484CCEBC00DC_484CEA1E0104_var*
begin
//#UC START# *484CCEBC00DC_484CEA1E0104_impl*
 if (aValue = EmptyStr) then
  Result := k2NullTag
 else
 begin
  FN := Tk2FontManager.Instance.FontByName(aValue);
  if (FN = nil) then
   Result := k2NullTag
  else
   Result := FN;
 end;//aValue = EmptyStr
//#UC END# *484CCEBC00DC_484CEA1E0104_impl*
end;//WevFontName.StrToTag

function WevFontName.ObjToTag(aValue: TObject): Il3TagRef;
//#UC START# *484CEAD301AE_484CEA1E0104_var*
//#UC END# *484CEAD301AE_484CEA1E0104_var*
begin
//#UC START# *484CEAD301AE_484CEA1E0104_impl*
 if (aValue Is Tk2FontName) then
  Result := Tk2FontName(aValue)
 else
 if (aValue Is Tl3CustomString) then
 begin
  //Assert(false);
  if Tl3CustomString(aValue).Empty then
   Result := k2NullTag
  else
   Result := AtomType.StrToTag(Tl3CustomString(aValue).AsString) As Tk2FontName {._AsRef};
 end//aValue Is Tl3CustomString
 else
 begin
  Assert(false);
  Result := inherited ObjToTag(aValue);
 end;//aValue Is Tl3CustomString
//#UC END# *484CEAD301AE_484CEA1E0104_impl*
end;//WevFontName.ObjToTag

end.
