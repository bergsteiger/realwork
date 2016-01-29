unit vcmToolbarMenuRes;

interface

uses
 l3IntfUses
 , l3StringIDEx
 , afwInterfaces
 , l3Interfaces
;

type
 TvcmGlyphSize = (
  vcm_gsAutomatic
  , vcm_gs16x16
  , vcm_gs24x24
  , vcm_gs32x32
 );//TvcmGlyphSize
 
 vcmIconSizeMapHelper = class
  {* ”тилитный класс дл€ преобразовани€ значений vcmIconSizeMap }
  procedure FillStrings(const aStrings: IafwStrings);
   {* «аполнение списка строк значени€ми }
  function DisplayNameToValue(const aDisplayName: Il3CString): TvcmGlyphSize;
   {* ѕреобразование строкового значени€ к пор€дковому }
 end;//vcmIconSizeMapHelper
 
implementation

uses
 l3ImplUses
 , l3MessageID
 , l3String
 , SysUtils
;

end.
