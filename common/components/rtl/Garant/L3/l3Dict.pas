unit l3Dict;
 {* �������� �������-"�������" }

// ������: "w:\common\components\rtl\Garant\L3\l3Dict.pas"
// ���������: "UtilityPack"
// ������� ������: "l3Dict" MUID: (47AC79EA0132)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3DictionaryPrim
 , l3IDIndex
 , l3Interfaces
 , l3Types
;

 {$Define l3Items_NeedsBeforeFreeItem}

 {$Undef l3Items_NoSort}

type
 _l3Dictionary_Parent_ = Tl3DictionaryPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Dictionary.imp.pas}
 Tl3Dictionary = class(_l3Dictionary_)
  {* �������. ������������ ��� �������������� ������ � ������������� � ��������. ����� ��� ������� ���������� }
 end;//Tl3Dictionary

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3String
 , l3Variant
 , l3Memory
;

type _Instance_R_ = Tl3Dictionary;

{$Include w:\common\components\rtl\Garant\L3\l3Dictionary.imp.pas}

end.
