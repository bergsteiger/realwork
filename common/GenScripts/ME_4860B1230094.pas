unit evdStyleContainer;

interface

uses
 l3IntfUses
 , k2DictionaryEx
 , l3Variant
 , k2Base
 , evdStyles
;

type
 _ItemType_ = Tl3Variant;
  {* ��� ������-�� ���, �� ��� ����� �� ��������� ��� �������� }
 
 TevStandardStylesArray = array [TevStandardCachedStyle] of Tl3Tag;
 
 TevdStyleContainer = class(Tk2DictionaryEx)
  {* �������� �������� ���������� ������ }
  procedure CheckValueTable(aType: Tk2Type);
   {* ��������� ������� ��������. }
 end;//TevdStyleContainer
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , k2Tags
;

end.
