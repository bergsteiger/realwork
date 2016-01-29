unit k2Interfaces;

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
 end;//Tk2Event
 
 Ik2TagListener = interface(Ik2Tag)
  {* Объекты, умеющие принимать сообщения о смене состояния тегов }
  procedure Fire(const anEvent: Tk2Event;
   const anOp: Ik2Op);
   {* сообщение о том, что c тегом что-то произошло. }
  function ExcludeEvents: Tk2EventIDs;
   {* События, которые не надо слушать. }
 end;//Ik2TagListener
 
 Ik2Listener = interface
  {* Объекты, умеющие принимать сообщения о смене состояния тегов }
  procedure Fire(const anEvent: Tk2Event;
   const anOp: Ik2Op);
   {* сообщение о том, что что-то произошло. }
 end;//Ik2Listener
 
 Ik2TagBoxContainer = interface
  procedure SetTag(aTag: Tl3Variant);
 end;//Ik2TagBoxContainer
 
 Ik2GeneratorTarget = interface
  {* Интерфейс цели генерации. Используется для управления ее временем жизни. }
 end;//Ik2GeneratorTarget
 
 Tk2Integer = record
 end;//Tk2Integer
 
 Ik2TagTool = interface(Ik2TagListener)
  {* Инструмент для манипулирования тегом }
 end;//Ik2TagTool
 
 Ik2RawData = interface
 end;//Ik2RawData
 
 Ik2TagReader = interface(Il3Reader)
  procedure Rollback(CheckBrackets: Boolean);
  procedure Link(const G: Ik2TagGenerator);
  procedure UnLink(const G: Ik2TagGenerator);
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
  procedure IterateCursors;
 end;//Mk2InterfaceFactory
 *)
 
 Tl3Type = l3Variant.Tl3Type;
 
 Tk2VarKind = l3Variant.Tk2VarKind;
 
 Ik2Variant = l3Variant.Ik2Variant;
 
 Ik2Tag = l3Variant.Ik2Tag;
 
 Tl3Variant = l3Variant.Tl3Variant;
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
