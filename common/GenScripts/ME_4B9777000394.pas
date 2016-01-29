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
  {* ��������� ����� ��� �������������� �������� vcmIconSizeMap }
  procedure FillStrings(const aStrings: IafwStrings);
   {* ���������� ������ ����� ���������� }
  function DisplayNameToValue(const aDisplayName: Il3CString): TvcmGlyphSize;
   {* �������������� ���������� �������� � ����������� }
 end;//vcmIconSizeMapHelper
 
implementation

uses
 l3ImplUses
 , l3MessageID
 , l3String
 , SysUtils
;

end.
