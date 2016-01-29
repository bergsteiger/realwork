unit evOpProc;

interface

uses
 l3IntfUses
 , l3_Base
 , nevTools
 , l3Variant
 , nevBase
 , l3Types
 , l3Interfaces
;

type
 TevCustomProcessor = class(Tl3_Base, InevDocumentLimits, InevDocumentInfo)
  {* Обработчик операций. }
  procedure BeepOnParaLimit;
  function BruttoCharLimit: Integer;
   {* ограничение на количество введенных символов. }
  function TextParaLimit: Integer;
  procedure ClearStat;
  function TextParaCount: Integer;
  function BruttoCharCount: Integer;
  function NettoCharCount: Integer;
  function BitmapParaCount: Integer;
 end;//TevCustomProcessor
 
 TevCustomUndoProcessor = class(TevCustomProcessor, Il3OpPackMode, InevProcessor)
  {* Обработчик операций с возможностью Undo & Redo. }
  function GetNeedReplaceQuotes: Boolean;
  procedure DoCheckParaOp(aParent: Tl3Variant;
   var aChild: Tl3Variant;
   anOp: Tl3Operation;
   anIndex: TnevParaIndex);
   {* проверить операцию с параграфом }
  procedure DoAfterUndoRedo;
  procedure DoParaOp(Parent: Tl3Variant;
   Child: Tl3Variant;
   Op: Tl3Operation);
   {* завершить операцию с параграфом }
  procedure Subscribe(const aRecipient: Il3Notify);
   {* подписка на извещения. }
  procedure Unsubscribe(const aRecipient: Il3Notify);
   {* "отписка" от извещений. }
  function StartOp(OpCode: Integer;
   DoLock: Boolean): Il3OpPack;
   {* начать операцию. }
  function FinishOp(anOp: TObject): Boolean;
   {* закончить операцию. }
  function LastOp: Il3OpPack;
   {* предыдущая операция. }
  function InOp: Boolean;
   {* Пачка операций открыта. }
  procedure Lock;
   {* закрыть. }
  procedure Unlock;
   {* открыть. }
  function Undo: Boolean;
   {* отменить предыдущую операцию. }
  function Redo: Boolean;
   {* вернуть отмененную операцию. }
  procedure CheckInsert(aParent: Tl3Variant;
   var aChild: Tl3Variant;
   var anIndex: Integer);
   {* проверить операцию с параграфом. }
  procedure CheckDelete(aParent: Tl3Variant;
   aChild: Tl3Variant;
   anIndex: Integer);
   {* проверить операцию с параграфом. }
  procedure NotifyCompleted(aList: Tl3Variant;
   aChild: Tl3Variant);
  procedure NotifyInsert(aList: Tl3Variant;
   aProp: TObject;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: Il3OpPack);
  procedure NotifyDelete(aList: Tl3Variant;
   aProp: TObject;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: Il3OpPack);
  function DefaultStyle: Tl3StyleId;
   {* Стиль по-умолчанию. }
  function CanUndo: Boolean;
   {* возможно ли Undo. }
  function CanRedo: Boolean;
   {* возможно ли Redo. }
  procedure MarkModified(aTarget: Tl3Variant);
  procedure InvertModified;
  function GetModified: Boolean;
  function InUndo: Boolean;
  function SaveUndo: Boolean;
  function DeleteMapped: Boolean;
  function Optimize: Boolean;
  function InIOProcess: Boolean;
  function Processor: Ik2Processor;
   {* процессор операций в контексте которого выполняется данная пачка. }
  function NeedReplaceQuotes: Boolean;
   {* Опрелеляет - нужно ли заменять кавычки при вводе. }
  procedure CheckReadOnly;
  procedure DisableReadonly;
   {* Выключает режим проверки ReadOnly }
  procedure EnableReadOnly;
   {* Включает режим проверки ReadOnly }
  function ReadOnly: Boolean;
  function UndoBuffer: Ik2UndoBuffer;
  procedure NotifyPropChanged(aProp: TObject;
   aValues;
   const anOp: Il3OpPack);
   {* Сообщает об изменении свойства объекта }
  procedure CheckOn;
  procedure CheckOff;
  function IsCheckOff: Boolean;
 end;//TevCustomUndoProcessor
 
implementation

uses
 l3ImplUses
;

end.
