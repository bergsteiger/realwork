unit k2TypedSmallLeafTag;
 {* ��������� ��� � ������� ����������� ����� � ������� ����� �� ����� 32 (������������) ��������� }

// ������: "w:\common\components\rtl\Garant\K2\k2TypedSmallLeafTag.pas"
// ���������: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2LeafTag
 , l3BitArr
 , k2Base
 , l3Variant
 , k2BaseStruct
 , k2TagList
 , k2Prim
 , l3IID
 , k2BaseTypes
 , l3Types
 , l3Interfaces
;

 {$Define k2Tag_No_f_TagType}

type
 _HashType_ = Tl3OneBytePtrHash;
 _k2HashTag_Parent_ = Tk2LeafTag;
 {$Include k2HashTag.imp.pas}
 Tk2TypedSmallLeafTag = class(_k2HashTag_)
  {* ��������� ��� � ������� ����������� ����� � ������� ����� �� ����� 32 (������������) ��������� }
 end;//Tk2TypedSmallLeafTag

implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , l3Dict
 , k2Const
 , l3Const
 , l3String
 , k2Except
 , k2Strings
 , TypInfo
 , l3Stream
 , l3Base
 , k2Facade
 , Classes
 , k2OList_Const
 , k2Dictionary
 , k2NonOptimizeContext
 , k2VariantImpl
 , k2Bool_Const
 , k2String
 , k2NullTagImpl
 , k2Interfaces
 , k2DictionaryPrim
 , k2InterfaceFactory
;

type _Instance_R_ = Tk2TypedSmallLeafTag;

{$Include k2HashTag.imp.pas}

end.
