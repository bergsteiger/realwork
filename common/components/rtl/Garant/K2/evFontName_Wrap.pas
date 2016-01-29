unit evFontName_Wrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/evFontName_Wrap.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Wrapper::Class>> Shared Delphi::K2::Standard::WevFontName
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3String_Wrap,
  l3Variant
  ;

type
 WevFontName = class(Wl3String)
 protected
 // overridden protected methods
   function StrToTag(const aValue: AnsiString): Tl3Tag; override;
   function ObjToTag(aValue: TObject): Il3TagRef; override;
 end;//WevFontName

implementation

uses
  l3Base,
  SysUtils,
  k2Base,
  l3FontManagerEx,
  k2FontName,
  l3LogFont,
  k2FontManager
  ;

// start class WevFontName

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