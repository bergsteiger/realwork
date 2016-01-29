unit k2TypedSmallSortableListTag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2TypedSmallSortableListTag.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2TypedSmallSortableListTag
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3BitArr,
  k2TypedSimpleSortableTagListPrim,
  k2Base,
  l3Variant,
  k2TagList,
  k2Prim,
  k2BaseStruct,
  l3Interfaces,
  k2BaseTypes,
  l3Types,
  l3IID
  ;

 {$Define k2Tag_No_f_TagType}

 {$Define k2TagIsList}

type
 _HashType_ = Tl3OneBytePtrHash;
 _k2HashTag_Parent_ = Tk2TypedSimpleSortableTagListPrim;
 {$Include ..\K2\k2HashTag.imp.pas}
 _k2TagByIntegerSearcher_Parent_ = _k2HashTag_;
 {$Include ..\K2\k2TagByIntegerSearcher.imp.pas}
 Tk2TypedSmallSortableListTag = class(_k2TagByIntegerSearcher_)
 end;//Tk2TypedSmallSortableListTag

implementation

uses
  SysUtils,
  k2Tags,
  l3Dict,
  k2Const,
  l3Const,
  l3String,
  k2Except,
  k2Strings,
  TypInfo,
  l3Stream,
  l3Base,
  k2Facade,
  Classes,
  k2OList_Const,
  k2Dictionary,
  k2NonOptimizeContext,
  k2VariantImpl,
  k2Bool_Const,
  k2String,
  k2List,
  k2NullTagImpl,
  k2Interfaces,
  k2DictionaryPrim,
  k2InterfaceFactory
  ;

type _Instance_R_ = Tk2TypedSmallSortableListTag;

{$Include ..\K2\k2HashTag.imp.pas}


{$Include ..\K2\k2TagByIntegerSearcher.imp.pas}

end.