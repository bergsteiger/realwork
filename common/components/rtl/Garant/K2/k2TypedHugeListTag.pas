unit k2TypedHugeListTag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2TypedHugeListTag.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2TypedHugeListTag
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
  evHugeParaListPrimWithFind,
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

 {$Define k2TagIsList}

 {$Define k2Tag_No_f_TagType}

 {$Define k2TagNoSort}

type
 _HashType_ = Tl3PtrHash;
 _k2HashTag_Parent_ = TevHugeParaListPrimWithFind;
 {$Include ..\K2\k2HashTag.imp.pas}
 Tk2TypedHugeListTag = class(_k2HashTag_)
 end;//Tk2TypedHugeListTag

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

type _Instance_R_ = Tk2TypedHugeListTag;

{$Include ..\K2\k2HashTag.imp.pas}

end.