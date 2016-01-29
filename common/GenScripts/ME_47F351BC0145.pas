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
  {* ���������� ��������. }
  procedure BeepOnParaLimit;
  function BruttoCharLimit: Integer;
   {* ����������� �� ���������� ��������� ��������. }
  function TextParaLimit: Integer;
  procedure ClearStat;
  function TextParaCount: Integer;
  function BruttoCharCount: Integer;
  function NettoCharCount: Integer;
  function BitmapParaCount: Integer;
 end;//TevCustomProcessor
 
 TevCustomUndoProcessor = class(TevCustomProcessor, Il3OpPackMode, InevProcessor)
  {* ���������� �������� � ������������ Undo & Redo. }
  function GetNeedReplaceQuotes: Boolean;
  procedure DoCheckParaOp(aParent: Tl3Variant;
   var aChild: Tl3Variant;
   anOp: Tl3Operation;
   anIndex: TnevParaIndex);
   {* ��������� �������� � ���������� }
  procedure DoAfterUndoRedo;
  procedure DoParaOp(Parent: Tl3Variant;
   Child: Tl3Variant;
   Op: Tl3Operation);
   {* ��������� �������� � ���������� }
  procedure Subscribe(const aRecipient: Il3Notify);
   {* �������� �� ���������. }
  procedure Unsubscribe(const aRecipient: Il3Notify);
   {* "�������" �� ���������. }
  function StartOp(OpCode: Integer;
   DoLock: Boolean): Il3OpPack;
   {* ������ ��������. }
  function FinishOp(anOp: TObject): Boolean;
   {* ��������� ��������. }
  function LastOp: Il3OpPack;
   {* ���������� ��������. }
  function InOp: Boolean;
   {* ����� �������� �������. }
  procedure Lock;
   {* �������. }
  procedure Unlock;
   {* �������. }
  function Undo: Boolean;
   {* �������� ���������� ��������. }
  function Redo: Boolean;
   {* ������� ���������� ��������. }
  procedure CheckInsert(aParent: Tl3Variant;
   var aChild: Tl3Variant;
   var anIndex: Integer);
   {* ��������� �������� � ����������. }
  procedure CheckDelete(aParent: Tl3Variant;
   aChild: Tl3Variant;
   anIndex: Integer);
   {* ��������� �������� � ����������. }
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
   {* ����� ��-���������. }
  function CanUndo: Boolean;
   {* �������� �� Undo. }
  function CanRedo: Boolean;
   {* �������� �� Redo. }
  procedure MarkModified(aTarget: Tl3Variant);
  procedure InvertModified;
  function GetModified: Boolean;
  function InUndo: Boolean;
  function SaveUndo: Boolean;
  function DeleteMapped: Boolean;
  function Optimize: Boolean;
  function InIOProcess: Boolean;
  function Processor: Ik2Processor;
   {* ��������� �������� � ��������� �������� ����������� ������ �����. }
  function NeedReplaceQuotes: Boolean;
   {* ���������� - ����� �� �������� ������� ��� �����. }
  procedure CheckReadOnly;
  procedure DisableReadonly;
   {* ��������� ����� �������� ReadOnly }
  procedure EnableReadOnly;
   {* �������� ����� �������� ReadOnly }
  function ReadOnly: Boolean;
  function UndoBuffer: Ik2UndoBuffer;
  procedure NotifyPropChanged(aProp: TObject;
   aValues;
   const anOp: Il3OpPack);
   {* �������� �� ��������� �������� ������� }
  procedure CheckOn;
  procedure CheckOff;
  function IsCheckOff: Boolean;
 end;//TevCustomUndoProcessor
 
implementation

uses
 l3ImplUses
;

end.
