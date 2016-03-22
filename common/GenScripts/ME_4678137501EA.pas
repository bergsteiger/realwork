unit k2Interfaces;
 {* Интерфейсы, описывающие работу с теговыми структурами. }

// Модуль: "w:\common\components\rtl\Garant\K2\k2Interfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "k2Interfaces" MUID: (4678137501EA)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , k2Prim
 , l3Variant
 , l3Types
;

type
 Ik2Base = interface(Il3Base)
  {* Базовый интерфейс библиотеки K-2 }
  ['{100376F4-33DA-4C1D-8F6C-0E9569466122}']
 end;//Ik2Base

 Ik2Op = k2Prim.Ik2Op;

 Tk2EventID = (
  {* Идентификаторы событий. }
  k2_eidNull
   {* пустое событие. }
  , k2_eidChildrenInserted
   {* вставлены дочерние теги. }
  , k2_eidTypeTableWillBeDestroyed
   {* таблица типов сейчас будет освобождена. }
  , k2_eidAttrChanged
   {* аттрибут изменился. }
  , k2_eidChildrenAdded
   {* добавлены дочерние теги. }
  , k2_eidChildrenDeleted
   {* удалены дочерние теги. }
 );//Tk2EventID

 Tk2EventIDs = set of Tk2EventID;

 Tk2Event = record
  ID: Tk2EventID;
  Point: Integer;
  Len: Integer;
  Total: Integer;
 end;//Tk2Event

 Ik2TagListener = interface(Ik2Tag)
  {* Объекты, умеющие принимать сообщения о смене состояния тегов }
  ['{E75F297A-5A79-4C00-9FD6-6911D3275239}']
  procedure Fire(const anEvent: Tk2Event;
   const anOp: Ik2Op);
   {* сообщение о том, что c тегом что-то произошло. }
  function ExcludeEvents: Tk2EventIDs;
   {* События, которые не надо слушать. }
 end;//Ik2TagListener

 Ik2Listener = interface(Ik2Base)
  {* Объекты, умеющие принимать сообщения о смене состояния тегов }
  ['{400B6933-ACA2-4030-80B6-B609ADC3BC49}']
  procedure Fire(const anEvent: Tk2Event;
   const anOp: Ik2Op);
   {* сообщение о том, что что-то произошло. }
 end;//Ik2Listener

 Ik2TagBoxContainer = interface(Ik2Base)
  ['{2916A1A6-C56E-4B5B-8C46-A3C59800E1F4}']
  procedure SetTag(aTag: Tl3Variant);
 end;//Ik2TagBoxContainer

 Ik2GeneratorTarget = interface(Ik2Base)
  {* Интерфейс цели генерации. Используется для управления ее временем жизни. }
  ['{D7833AAF-1A4D-4CD0-A8AD-17461B2A8B6E}']
 end;//Ik2GeneratorTarget

 Tk2Integer = record
  rIsSet: Boolean;
  rValue: Integer;
 end;//Tk2Integer

 Ik2TagTool = interface(Ik2TagListener)
  {* Инструмент для манипулирования тегом }
  ['{72568393-5622-4C47-BC3A-D17C56F87BDE}']
  function pm_GetParentTool: Ik2TagTool;
  procedure pm_SetParentTool(const aValue: Ik2TagTool);
  property ParentTool: Ik2TagTool
   read pm_GetParentTool
   write pm_SetParentTool;
   {* инструмент родительского тега. }
 end;//Ik2TagTool

 Ik2RawData = interface(Ik2Base)
  ['{1BF80DA7-BEBC-48DC-808A-355329C193E6}']
  function pm_GetIsModified: Boolean;
  property IsModified: Boolean
   read pm_GetIsModified;
 end;//Ik2RawData

 Ik2TagReader = interface(Il3Reader)
  ['{7A106425-E165-42E9-ACF2-C7D54425CC64}']
  function pm_GetContext: Ik2Op;
  procedure pm_SetContext(const aValue: Ik2Op);
  procedure Rollback(CheckBrackets: Boolean = False);
  procedure Link(const G: Ik2TagGenerator);
  procedure UnLink(const G: Ik2TagGenerator);
  property Context: Ik2Op
   read pm_GetContext
   write pm_SetContext;
   {* Контекст генерации. }
 end;//Ik2TagReader

 Ik2Processor = l3Variant.Ik2Processor;

 Tk2TypePrim = k2Prim.Tk2TypePrim;

 Tk2CustomPropertyPrim = k2Prim.Tk2CustomPropertyPrim;

 Tk2ArrayPropertyPrim = k2Prim.Tk2ArrayPropertyPrim;

 Ik2TagGenerator = l3Variant.Ik2TagGenerator;

 Tk2TypeKind = (
  k2_tkInteger
  , k2_tkBool
  , k2_tkObject
  , k2_tkTransparent
  , k2_tkStream
 );//Tk2TypeKind

 Tk2Variant = Ik2Variant;

 Mk2InterfaceFactory_IterateCursors_Action = function(anItem: Pointer;
  anIndex: Integer): Boolean;
  {* Тип подитеративной функции для Mk2InterfaceFactory.IterateCursors }

 (*
 Mk2InterfaceFactory = interface
  procedure IterateCursors(anAction: Mk2InterfaceFactory_IterateCursors_Action);
  procedure IterateCursorsF(anAction: Mk2InterfaceFactory_IterateCursors_Action);
 end;//Mk2InterfaceFactory
 *)

 Tl3Type = l3Variant.Tl3Type;

 Tk2VarKind = l3Variant.Tk2VarKind;

 Ik2Variant = l3Variant.Ik2Variant;

 Ik2Tag = l3Variant.Ik2Tag;

 Tl3Variant = l3Variant.Tl3Variant;

function L2Mk2InterfaceFactoryIterateCursorsAction(anAction: pointer): Mk2InterfaceFactory_IterateCursors_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для Mk2InterfaceFactory.IterateCursors }

implementation

uses
 l3ImplUses
 , l3Base
;

function L2Mk2InterfaceFactoryIterateCursorsAction(anAction: pointer): Mk2InterfaceFactory_IterateCursors_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для Mk2InterfaceFactory.IterateCursors }
asm
 jmp l3LocalStub
end;//L2Mk2InterfaceFactoryIterateCursorsAction

end.
