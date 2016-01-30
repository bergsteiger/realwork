unit NOT_FINISHED_evOpProc;
 {* Обработчики операций. }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evOpProc.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

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
  protected
   procedure BeepOnParaLimit; virtual;
   function pm_GetBruttoCharLimit: Integer;
   procedure pm_SetBruttoCharLimit(aValue: Integer);
   function pm_GetTextParaLimit: Integer;
   procedure pm_SetTextParaLimit(aValue: Integer);
   procedure ClearStat;
   function pm_GetTextParaCount: Integer;
   function pm_GetBruttoCharCount: Integer;
   function pm_GetNettoCharCount: Integer;
   function pm_GetBitmapParaCount: Integer;
 end;//TevCustomProcessor

 TevCustomUndoProcessor = class(TevCustomProcessor, Il3OpPackMode, InevProcessor)
  {* Обработчик операций с возможностью Undo & Redo. }
  protected
   function GetNeedReplaceQuotes: Boolean; virtual;
   procedure DoCheckParaOp(aParent: Tl3Variant;
    var aChild: Tl3Variant;
    anOp: Tl3Operation;
    anIndex: TnevParaIndex); virtual;
    {* проверить операцию с параграфом }
   procedure DoAfterUndoRedo; virtual;
   procedure DoParaOp(Parent: Tl3Variant;
    Child: Tl3Variant;
    Op: Tl3Operation); virtual;
    {* завершить операцию с параграфом }
   procedure Subscribe(const aRecipient: Il3Notify);
    {* подписка на извещения. }
   procedure Unsubscribe(const aRecipient: Il3Notify);
    {* "отписка" от извещений. }
   function StartOp(OpCode: Integer = 0;
    DoLock: Boolean = True): Il3OpPack;
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
   function pm_GetDefaultStyle: Tl3StyleId;
   procedure pm_SetDefaultStyle(aValue: Tl3StyleId);
   function pm_GetCanUndo: Boolean;
   function pm_GetCanRedo: Boolean;
   procedure MarkModified(aTarget: Tl3Variant);
   procedure InvertModified;
   function GetModified: Boolean;
   function Get_InUndo: Boolean;
   function Get_SaveUndo: Boolean;
   procedure Set_SaveUndo(aValue: Boolean);
   function pm_GetDeleteMapped: Boolean;
   procedure pm_SetDeleteMapped(aValue: Boolean);
   function pm_GetOptimize: Boolean;
   procedure pm_SetOptimize(aValue: Boolean);
   function pm_GetInIOProcess: Boolean;
   procedure pm_SetInIOProcess(aValue: Boolean);
   function pm_GetProcessor: Ik2Processor;
   function NeedReplaceQuotes: Boolean;
    {* Опрелеляет - нужно ли заменять кавычки при вводе. }
   procedure CheckReadOnly;
   procedure DisableReadonly;
    {* Выключает режим проверки ReadOnly }
   procedure EnableReadOnly;
    {* Включает режим проверки ReadOnly }
   procedure pm_SetReadOnly(aValue: Boolean);
   function Get_UndoBuffer: Ik2UndoBuffer;
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

procedure TevCustomProcessor.BeepOnParaLimit;
//#UC START# *482D91730258_47F351E50367_var*
//#UC END# *482D91730258_47F351E50367_var*
begin
//#UC START# *482D91730258_47F351E50367_impl*
 !!! Needs to be implemented !!!
//#UC END# *482D91730258_47F351E50367_impl*
end;//TevCustomProcessor.BeepOnParaLimit

function TevCustomProcessor.pm_GetBruttoCharLimit: Integer;
//#UC START# *47C6AD3B02E8_47F351E50367get_var*
//#UC END# *47C6AD3B02E8_47F351E50367get_var*
begin
//#UC START# *47C6AD3B02E8_47F351E50367get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6AD3B02E8_47F351E50367get_impl*
end;//TevCustomProcessor.pm_GetBruttoCharLimit

procedure TevCustomProcessor.pm_SetBruttoCharLimit(aValue: Integer);
//#UC START# *47C6AD3B02E8_47F351E50367set_var*
//#UC END# *47C6AD3B02E8_47F351E50367set_var*
begin
//#UC START# *47C6AD3B02E8_47F351E50367set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6AD3B02E8_47F351E50367set_impl*
end;//TevCustomProcessor.pm_SetBruttoCharLimit

function TevCustomProcessor.pm_GetTextParaLimit: Integer;
//#UC START# *47C6AD4F02BE_47F351E50367get_var*
//#UC END# *47C6AD4F02BE_47F351E50367get_var*
begin
//#UC START# *47C6AD4F02BE_47F351E50367get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6AD4F02BE_47F351E50367get_impl*
end;//TevCustomProcessor.pm_GetTextParaLimit

procedure TevCustomProcessor.pm_SetTextParaLimit(aValue: Integer);
//#UC START# *47C6AD4F02BE_47F351E50367set_var*
//#UC END# *47C6AD4F02BE_47F351E50367set_var*
begin
//#UC START# *47C6AD4F02BE_47F351E50367set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6AD4F02BE_47F351E50367set_impl*
end;//TevCustomProcessor.pm_SetTextParaLimit

procedure TevCustomProcessor.ClearStat;
//#UC START# *47C6AD7E0136_47F351E50367_var*
//#UC END# *47C6AD7E0136_47F351E50367_var*
begin
//#UC START# *47C6AD7E0136_47F351E50367_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6AD7E0136_47F351E50367_impl*
end;//TevCustomProcessor.ClearStat

function TevCustomProcessor.pm_GetTextParaCount: Integer;
//#UC START# *47C6AD8C01C2_47F351E50367get_var*
//#UC END# *47C6AD8C01C2_47F351E50367get_var*
begin
//#UC START# *47C6AD8C01C2_47F351E50367get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6AD8C01C2_47F351E50367get_impl*
end;//TevCustomProcessor.pm_GetTextParaCount

function TevCustomProcessor.pm_GetBruttoCharCount: Integer;
//#UC START# *47C6ADA101B8_47F351E50367get_var*
//#UC END# *47C6ADA101B8_47F351E50367get_var*
begin
//#UC START# *47C6ADA101B8_47F351E50367get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6ADA101B8_47F351E50367get_impl*
end;//TevCustomProcessor.pm_GetBruttoCharCount

function TevCustomProcessor.pm_GetNettoCharCount: Integer;
//#UC START# *47C6ADAE0303_47F351E50367get_var*
//#UC END# *47C6ADAE0303_47F351E50367get_var*
begin
//#UC START# *47C6ADAE0303_47F351E50367get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6ADAE0303_47F351E50367get_impl*
end;//TevCustomProcessor.pm_GetNettoCharCount

function TevCustomProcessor.pm_GetBitmapParaCount: Integer;
//#UC START# *4D077BE80280_47F351E50367get_var*
//#UC END# *4D077BE80280_47F351E50367get_var*
begin
//#UC START# *4D077BE80280_47F351E50367get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D077BE80280_47F351E50367get_impl*
end;//TevCustomProcessor.pm_GetBitmapParaCount

function TevCustomUndoProcessor.GetNeedReplaceQuotes: Boolean;
//#UC START# *4843D3020153_47F3521002C7_var*
//#UC END# *4843D3020153_47F3521002C7_var*
begin
//#UC START# *4843D3020153_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4843D3020153_47F3521002C7_impl*
end;//TevCustomUndoProcessor.GetNeedReplaceQuotes

procedure TevCustomUndoProcessor.DoCheckParaOp(aParent: Tl3Variant;
 var aChild: Tl3Variant;
 anOp: Tl3Operation;
 anIndex: TnevParaIndex);
 {* проверить операцию с параграфом }
//#UC START# *48E4CB990000_47F3521002C7_var*
//#UC END# *48E4CB990000_47F3521002C7_var*
begin
//#UC START# *48E4CB990000_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E4CB990000_47F3521002C7_impl*
end;//TevCustomUndoProcessor.DoCheckParaOp

procedure TevCustomUndoProcessor.DoAfterUndoRedo;
//#UC START# *48E4CBD6038B_47F3521002C7_var*
//#UC END# *48E4CBD6038B_47F3521002C7_var*
begin
//#UC START# *48E4CBD6038B_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E4CBD6038B_47F3521002C7_impl*
end;//TevCustomUndoProcessor.DoAfterUndoRedo

procedure TevCustomUndoProcessor.DoParaOp(Parent: Tl3Variant;
 Child: Tl3Variant;
 Op: Tl3Operation);
 {* завершить операцию с параграфом }
//#UC START# *48E4CBE8018B_47F3521002C7_var*
//#UC END# *48E4CBE8018B_47F3521002C7_var*
begin
//#UC START# *48E4CBE8018B_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E4CBE8018B_47F3521002C7_impl*
end;//TevCustomUndoProcessor.DoParaOp

procedure TevCustomUndoProcessor.Subscribe(const aRecipient: Il3Notify);
 {* подписка на извещения. }
//#UC START# *46A44F6B035E_47F3521002C7_var*
//#UC END# *46A44F6B035E_47F3521002C7_var*
begin
//#UC START# *46A44F6B035E_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A44F6B035E_47F3521002C7_impl*
end;//TevCustomUndoProcessor.Subscribe

procedure TevCustomUndoProcessor.Unsubscribe(const aRecipient: Il3Notify);
 {* "отписка" от извещений. }
//#UC START# *46A44FFE0143_47F3521002C7_var*
//#UC END# *46A44FFE0143_47F3521002C7_var*
begin
//#UC START# *46A44FFE0143_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A44FFE0143_47F3521002C7_impl*
end;//TevCustomUndoProcessor.Unsubscribe

function TevCustomUndoProcessor.StartOp(OpCode: Integer = 0;
 DoLock: Boolean = True): Il3OpPack;
 {* начать операцию. }
//#UC START# *46A5BC28010A_47F3521002C7_var*
//#UC END# *46A5BC28010A_47F3521002C7_var*
begin
//#UC START# *46A5BC28010A_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BC28010A_47F3521002C7_impl*
end;//TevCustomUndoProcessor.StartOp

function TevCustomUndoProcessor.FinishOp(anOp: TObject): Boolean;
 {* закончить операцию. }
//#UC START# *46A5BC7F0065_47F3521002C7_var*
//#UC END# *46A5BC7F0065_47F3521002C7_var*
begin
//#UC START# *46A5BC7F0065_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BC7F0065_47F3521002C7_impl*
end;//TevCustomUndoProcessor.FinishOp

function TevCustomUndoProcessor.LastOp: Il3OpPack;
 {* предыдущая операция. }
//#UC START# *46A5BCC4008C_47F3521002C7_var*
//#UC END# *46A5BCC4008C_47F3521002C7_var*
begin
//#UC START# *46A5BCC4008C_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BCC4008C_47F3521002C7_impl*
end;//TevCustomUndoProcessor.LastOp

function TevCustomUndoProcessor.InOp: Boolean;
 {* Пачка операций открыта. }
//#UC START# *46A5BCF5008C_47F3521002C7_var*
//#UC END# *46A5BCF5008C_47F3521002C7_var*
begin
//#UC START# *46A5BCF5008C_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BCF5008C_47F3521002C7_impl*
end;//TevCustomUndoProcessor.InOp

procedure TevCustomUndoProcessor.Lock;
 {* закрыть. }
//#UC START# *46A5BD1103B8_47F3521002C7_var*
//#UC END# *46A5BD1103B8_47F3521002C7_var*
begin
//#UC START# *46A5BD1103B8_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BD1103B8_47F3521002C7_impl*
end;//TevCustomUndoProcessor.Lock

procedure TevCustomUndoProcessor.Unlock;
 {* открыть. }
//#UC START# *46A5BD22025E_47F3521002C7_var*
//#UC END# *46A5BD22025E_47F3521002C7_var*
begin
//#UC START# *46A5BD22025E_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BD22025E_47F3521002C7_impl*
end;//TevCustomUndoProcessor.Unlock

function TevCustomUndoProcessor.Undo: Boolean;
 {* отменить предыдущую операцию. }
//#UC START# *46A5BD3B0390_47F3521002C7_var*
//#UC END# *46A5BD3B0390_47F3521002C7_var*
begin
//#UC START# *46A5BD3B0390_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BD3B0390_47F3521002C7_impl*
end;//TevCustomUndoProcessor.Undo

function TevCustomUndoProcessor.Redo: Boolean;
 {* вернуть отмененную операцию. }
//#UC START# *46A5BD570141_47F3521002C7_var*
//#UC END# *46A5BD570141_47F3521002C7_var*
begin
//#UC START# *46A5BD570141_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BD570141_47F3521002C7_impl*
end;//TevCustomUndoProcessor.Redo

procedure TevCustomUndoProcessor.CheckInsert(aParent: Tl3Variant;
 var aChild: Tl3Variant;
 var anIndex: Integer);
 {* проверить операцию с параграфом. }
//#UC START# *46A5BD730033_47F3521002C7_var*
//#UC END# *46A5BD730033_47F3521002C7_var*
begin
//#UC START# *46A5BD730033_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BD730033_47F3521002C7_impl*
end;//TevCustomUndoProcessor.CheckInsert

procedure TevCustomUndoProcessor.CheckDelete(aParent: Tl3Variant;
 aChild: Tl3Variant;
 anIndex: Integer);
 {* проверить операцию с параграфом. }
//#UC START# *46A5BE7101DD_47F3521002C7_var*
//#UC END# *46A5BE7101DD_47F3521002C7_var*
begin
//#UC START# *46A5BE7101DD_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BE7101DD_47F3521002C7_impl*
end;//TevCustomUndoProcessor.CheckDelete

procedure TevCustomUndoProcessor.NotifyCompleted(aList: Tl3Variant;
 aChild: Tl3Variant);
//#UC START# *46A5BEA30171_47F3521002C7_var*
//#UC END# *46A5BEA30171_47F3521002C7_var*
begin
//#UC START# *46A5BEA30171_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BEA30171_47F3521002C7_impl*
end;//TevCustomUndoProcessor.NotifyCompleted

procedure TevCustomUndoProcessor.NotifyInsert(aList: Tl3Variant;
 aProp: TObject;
 aChild: Tl3Variant;
 anIndex: Integer;
 const anOpPack: Il3OpPack);
//#UC START# *46A5BEBE0116_47F3521002C7_var*
//#UC END# *46A5BEBE0116_47F3521002C7_var*
begin
//#UC START# *46A5BEBE0116_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BEBE0116_47F3521002C7_impl*
end;//TevCustomUndoProcessor.NotifyInsert

procedure TevCustomUndoProcessor.NotifyDelete(aList: Tl3Variant;
 aProp: TObject;
 aChild: Tl3Variant;
 anIndex: Integer;
 const anOpPack: Il3OpPack);
//#UC START# *46A5BEF7038F_47F3521002C7_var*
//#UC END# *46A5BEF7038F_47F3521002C7_var*
begin
//#UC START# *46A5BEF7038F_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5BEF7038F_47F3521002C7_impl*
end;//TevCustomUndoProcessor.NotifyDelete

function TevCustomUndoProcessor.pm_GetDefaultStyle: Tl3StyleId;
//#UC START# *46A5CD010120_47F3521002C7get_var*
//#UC END# *46A5CD010120_47F3521002C7get_var*
begin
//#UC START# *46A5CD010120_47F3521002C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CD010120_47F3521002C7get_impl*
end;//TevCustomUndoProcessor.pm_GetDefaultStyle

procedure TevCustomUndoProcessor.pm_SetDefaultStyle(aValue: Tl3StyleId);
//#UC START# *46A5CD010120_47F3521002C7set_var*
//#UC END# *46A5CD010120_47F3521002C7set_var*
begin
//#UC START# *46A5CD010120_47F3521002C7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CD010120_47F3521002C7set_impl*
end;//TevCustomUndoProcessor.pm_SetDefaultStyle

function TevCustomUndoProcessor.pm_GetCanUndo: Boolean;
//#UC START# *46A5CD2E0161_47F3521002C7get_var*
//#UC END# *46A5CD2E0161_47F3521002C7get_var*
begin
//#UC START# *46A5CD2E0161_47F3521002C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CD2E0161_47F3521002C7get_impl*
end;//TevCustomUndoProcessor.pm_GetCanUndo

function TevCustomUndoProcessor.pm_GetCanRedo: Boolean;
//#UC START# *46A5CD5102A2_47F3521002C7get_var*
//#UC END# *46A5CD5102A2_47F3521002C7get_var*
begin
//#UC START# *46A5CD5102A2_47F3521002C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CD5102A2_47F3521002C7get_impl*
end;//TevCustomUndoProcessor.pm_GetCanRedo

procedure TevCustomUndoProcessor.MarkModified(aTarget: Tl3Variant);
//#UC START# *46A5CE3E009A_47F3521002C7_var*
//#UC END# *46A5CE3E009A_47F3521002C7_var*
begin
//#UC START# *46A5CE3E009A_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CE3E009A_47F3521002C7_impl*
end;//TevCustomUndoProcessor.MarkModified

procedure TevCustomUndoProcessor.InvertModified;
//#UC START# *46A5CE5C0057_47F3521002C7_var*
//#UC END# *46A5CE5C0057_47F3521002C7_var*
begin
//#UC START# *46A5CE5C0057_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CE5C0057_47F3521002C7_impl*
end;//TevCustomUndoProcessor.InvertModified

function TevCustomUndoProcessor.GetModified: Boolean;
//#UC START# *46A5CE6A00BB_47F3521002C7_var*
//#UC END# *46A5CE6A00BB_47F3521002C7_var*
begin
//#UC START# *46A5CE6A00BB_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CE6A00BB_47F3521002C7_impl*
end;//TevCustomUndoProcessor.GetModified

function TevCustomUndoProcessor.Get_InUndo: Boolean;
//#UC START# *46A5CE840343_47F3521002C7get_var*
//#UC END# *46A5CE840343_47F3521002C7get_var*
begin
//#UC START# *46A5CE840343_47F3521002C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CE840343_47F3521002C7get_impl*
end;//TevCustomUndoProcessor.Get_InUndo

function TevCustomUndoProcessor.Get_SaveUndo: Boolean;
//#UC START# *46A5CE9A03B3_47F3521002C7get_var*
//#UC END# *46A5CE9A03B3_47F3521002C7get_var*
begin
//#UC START# *46A5CE9A03B3_47F3521002C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CE9A03B3_47F3521002C7get_impl*
end;//TevCustomUndoProcessor.Get_SaveUndo

procedure TevCustomUndoProcessor.Set_SaveUndo(aValue: Boolean);
//#UC START# *46A5CE9A03B3_47F3521002C7set_var*
//#UC END# *46A5CE9A03B3_47F3521002C7set_var*
begin
//#UC START# *46A5CE9A03B3_47F3521002C7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CE9A03B3_47F3521002C7set_impl*
end;//TevCustomUndoProcessor.Set_SaveUndo

function TevCustomUndoProcessor.pm_GetDeleteMapped: Boolean;
//#UC START# *46A5CEB0018E_47F3521002C7get_var*
//#UC END# *46A5CEB0018E_47F3521002C7get_var*
begin
//#UC START# *46A5CEB0018E_47F3521002C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CEB0018E_47F3521002C7get_impl*
end;//TevCustomUndoProcessor.pm_GetDeleteMapped

procedure TevCustomUndoProcessor.pm_SetDeleteMapped(aValue: Boolean);
//#UC START# *46A5CEB0018E_47F3521002C7set_var*
//#UC END# *46A5CEB0018E_47F3521002C7set_var*
begin
//#UC START# *46A5CEB0018E_47F3521002C7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CEB0018E_47F3521002C7set_impl*
end;//TevCustomUndoProcessor.pm_SetDeleteMapped

function TevCustomUndoProcessor.pm_GetOptimize: Boolean;
//#UC START# *46A5CEC900F4_47F3521002C7get_var*
//#UC END# *46A5CEC900F4_47F3521002C7get_var*
begin
//#UC START# *46A5CEC900F4_47F3521002C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CEC900F4_47F3521002C7get_impl*
end;//TevCustomUndoProcessor.pm_GetOptimize

procedure TevCustomUndoProcessor.pm_SetOptimize(aValue: Boolean);
//#UC START# *46A5CEC900F4_47F3521002C7set_var*
//#UC END# *46A5CEC900F4_47F3521002C7set_var*
begin
//#UC START# *46A5CEC900F4_47F3521002C7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CEC900F4_47F3521002C7set_impl*
end;//TevCustomUndoProcessor.pm_SetOptimize

function TevCustomUndoProcessor.pm_GetInIOProcess: Boolean;
//#UC START# *46A5CEF30267_47F3521002C7get_var*
//#UC END# *46A5CEF30267_47F3521002C7get_var*
begin
//#UC START# *46A5CEF30267_47F3521002C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CEF30267_47F3521002C7get_impl*
end;//TevCustomUndoProcessor.pm_GetInIOProcess

procedure TevCustomUndoProcessor.pm_SetInIOProcess(aValue: Boolean);
//#UC START# *46A5CEF30267_47F3521002C7set_var*
//#UC END# *46A5CEF30267_47F3521002C7set_var*
begin
//#UC START# *46A5CEF30267_47F3521002C7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CEF30267_47F3521002C7set_impl*
end;//TevCustomUndoProcessor.pm_SetInIOProcess

function TevCustomUndoProcessor.pm_GetProcessor: Ik2Processor;
//#UC START# *46A5CF0902C3_47F3521002C7get_var*
//#UC END# *46A5CF0902C3_47F3521002C7get_var*
begin
//#UC START# *46A5CF0902C3_47F3521002C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5CF0902C3_47F3521002C7get_impl*
end;//TevCustomUndoProcessor.pm_GetProcessor

function TevCustomUndoProcessor.NeedReplaceQuotes: Boolean;
 {* Опрелеляет - нужно ли заменять кавычки при вводе. }
//#UC START# *4843CBDB0253_47F3521002C7_var*
//#UC END# *4843CBDB0253_47F3521002C7_var*
begin
//#UC START# *4843CBDB0253_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4843CBDB0253_47F3521002C7_impl*
end;//TevCustomUndoProcessor.NeedReplaceQuotes

procedure TevCustomUndoProcessor.CheckReadOnly;
//#UC START# *48A4297E0341_47F3521002C7_var*
//#UC END# *48A4297E0341_47F3521002C7_var*
begin
//#UC START# *48A4297E0341_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *48A4297E0341_47F3521002C7_impl*
end;//TevCustomUndoProcessor.CheckReadOnly

procedure TevCustomUndoProcessor.DisableReadonly;
 {* Выключает режим проверки ReadOnly }
//#UC START# *48A564120005_47F3521002C7_var*
//#UC END# *48A564120005_47F3521002C7_var*
begin
//#UC START# *48A564120005_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *48A564120005_47F3521002C7_impl*
end;//TevCustomUndoProcessor.DisableReadonly

procedure TevCustomUndoProcessor.EnableReadOnly;
 {* Включает режим проверки ReadOnly }
//#UC START# *48A564160056_47F3521002C7_var*
//#UC END# *48A564160056_47F3521002C7_var*
begin
//#UC START# *48A564160056_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *48A564160056_47F3521002C7_impl*
end;//TevCustomUndoProcessor.EnableReadOnly

procedure TevCustomUndoProcessor.pm_SetReadOnly(aValue: Boolean);
//#UC START# *48A570180217_47F3521002C7set_var*
//#UC END# *48A570180217_47F3521002C7set_var*
begin
//#UC START# *48A570180217_47F3521002C7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *48A570180217_47F3521002C7set_impl*
end;//TevCustomUndoProcessor.pm_SetReadOnly

function TevCustomUndoProcessor.Get_UndoBuffer: Ik2UndoBuffer;
//#UC START# *4919465D0139_47F3521002C7get_var*
//#UC END# *4919465D0139_47F3521002C7get_var*
begin
//#UC START# *4919465D0139_47F3521002C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4919465D0139_47F3521002C7get_impl*
end;//TevCustomUndoProcessor.Get_UndoBuffer

procedure TevCustomUndoProcessor.NotifyPropChanged(aProp: TObject;
 aValues;
 const anOp: Il3OpPack);
 {* Сообщает об изменении свойства объекта }
//#UC START# *4A68941501A3_47F3521002C7_var*
//#UC END# *4A68941501A3_47F3521002C7_var*
begin
//#UC START# *4A68941501A3_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A68941501A3_47F3521002C7_impl*
end;//TevCustomUndoProcessor.NotifyPropChanged

procedure TevCustomUndoProcessor.CheckOn;
//#UC START# *4CEBD62101DA_47F3521002C7_var*
//#UC END# *4CEBD62101DA_47F3521002C7_var*
begin
//#UC START# *4CEBD62101DA_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CEBD62101DA_47F3521002C7_impl*
end;//TevCustomUndoProcessor.CheckOn

procedure TevCustomUndoProcessor.CheckOff;
//#UC START# *4CEBD62D01E8_47F3521002C7_var*
//#UC END# *4CEBD62D01E8_47F3521002C7_var*
begin
//#UC START# *4CEBD62D01E8_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CEBD62D01E8_47F3521002C7_impl*
end;//TevCustomUndoProcessor.CheckOff

function TevCustomUndoProcessor.IsCheckOff: Boolean;
//#UC START# *4CECE9470154_47F3521002C7_var*
//#UC END# *4CECE9470154_47F3521002C7_var*
begin
//#UC START# *4CECE9470154_47F3521002C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CECE9470154_47F3521002C7_impl*
end;//TevCustomUndoProcessor.IsCheckOff

end.
