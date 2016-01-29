unit l3VCLFormPtrList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3VCLFormPtrList.pas"
// Начат: 20.04.2011 15:05
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Containers::Tl3VCLFormPtrList
//
// Список УКАЗАТЕЛЕЙ на формы VCL
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except
  ;

type
 _ItemType_ = TCustomForm;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3ObjectPtrList.imp.pas}
 Tl3VCLFormPtrList = class(_l3ObjectPtrList_)
  {* Список УКАЗАТЕЛЕЙ на формы VCL }
 end;//Tl3VCLFormPtrList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3VCLFormPtrList;

{$Include ..\L3\l3ObjectPtrList.imp.pas}

end.