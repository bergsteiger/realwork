unit k2HugeDictRec;

// ������: "w:\common\components\rtl\Garant\K2\k2HugeDictRec.pas"
// ���������: "SimpleClass"
// ������� ������: "Tk2HugeDictRec" MUID: (4E15EFFA0214)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2DictRecTag
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

type
 _HashType_ = Tl3PtrHash;
 _k2HashTag_Parent_ = Tk2DictRecTag;
 {$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}
 Tk2HugeDictRec = class(_k2HashTag_)
 end;//Tk2HugeDictRec

implementation

uses
 l3ImplUses
 , k2Tags
 , SysUtils
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
;

type _Instance_R_ = Tk2HugeDictRec;

{$Include w:\common\components\rtl\Garant\K2\k2HashTag.imp.pas}

end.
