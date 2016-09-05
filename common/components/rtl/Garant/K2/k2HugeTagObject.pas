unit k2HugeTagObject;
 {* ���� �� ���������� ��������� �����. � �������������� ����������� ������� }

// ������: "w:\common\components\rtl\Garant\K2\k2HugeTagObject.pas"
// ���������: "SimpleClass"
// ������� ������: "Tk2HugeTagObject" MUID: (467FC49800E8)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2NonAtomicTag
 , l3BitArr
 , l3Variant
 , k2Base
 , k2BaseStruct
 , k2TagList
 , k2Prim
 , l3IID
 , k2BaseTypes
 , l3Types
 , l3Interfaces
;

type
 _HashType_ = Tl3PtrHash;
 _k2HashTag_Parent_ = Tk2NonAtomicTag;
 {$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}
 Tk2HugeTagObject = class(_k2HashTag_)
  {* ���� �� ���������� ��������� �����. � �������������� ����������� ������� }
 end;//Tk2HugeTagObject

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
 , k2List
 //#UC START# *467FC49800E8impl_uses*
 //#UC END# *467FC49800E8impl_uses*
;

type _Instance_R_ = Tk2HugeTagObject;

{$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}

end.
