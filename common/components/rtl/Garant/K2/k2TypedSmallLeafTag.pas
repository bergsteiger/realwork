unit k2TypedSmallLeafTag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2TypedSmallLeafTag.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2TypedSmallLeafTag
//
// Листьевой тег с заранее определённым типом и могущий иметь НЕ более 32 (включительно) атрибутов
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
  k2LeafTag,
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

type
 _HashType_ = Tl3OneBytePtrHash;
 _k2HashTag_Parent_ = Tk2LeafTag;
 {$Include ..\K2\k2HashTag.imp.pas}
 Tk2TypedSmallLeafTag = class(_k2HashTag_)
  {* Листьевой тег с заранее определённым типом и могущий иметь НЕ более 32 (включительно) атрибутов }
 end;//Tk2TypedSmallLeafTag

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

type _Instance_R_ = Tk2TypedSmallLeafTag;

{$Include ..\K2\k2HashTag.imp.pas}

end.