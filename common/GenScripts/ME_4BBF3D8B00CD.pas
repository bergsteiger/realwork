unit k2ProcessorTagTool;

// Модуль: "w:\common\components\rtl\Garant\K2\k2ProcessorTagTool.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2TagTool
 , k2PureMixIns
 , k2Interfaces
 , l3Variant
 , l3IID
;

type
 Tk2ProcessorTagTool = class(Tk2TagTool)
  private
   f_Processor: Ik2Processor;
    {* Поле для свойства Processor }
  protected
   function pm_GetProcessor: Ik2Processor;
   function GetProcessor: Ik2Processor; virtual;
   function StartOp(OpCode: Integer = 0;
    DoLock: Boolean = True): Ik2Op;
   function Get_Processor: Ik2Processor;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoFire(const anEvent: Tk2Event;
    const anOp: Ik2Op); override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure ClearFields; override;
  public
   constructor Create(aTag: Tl3Variant;
    const aProcessor: Ik2Processor); reintroduce;
   class function Make(aTag: Tl3Variant;
    const aProcessor: Ik2Processor): Ik2TagTool; reintroduce;
  protected
   property Processor: Ik2Processor
    read pm_GetProcessor;
 end;//Tk2ProcessorTagTool

implementation

uses
 l3ImplUses
;

function Tk2ProcessorTagTool.pm_GetProcessor: Ik2Processor;
//#UC START# *54BD169902EF_4BBF3D8B00CDget_var*
//#UC END# *54BD169902EF_4BBF3D8B00CDget_var*
begin
//#UC START# *54BD169902EF_4BBF3D8B00CDget_impl*
 Result := GetProcessor;
//#UC END# *54BD169902EF_4BBF3D8B00CDget_impl*
end;//Tk2ProcessorTagTool.pm_GetProcessor

constructor Tk2ProcessorTagTool.Create(aTag: Tl3Variant;
 const aProcessor: Ik2Processor);
//#UC START# *4BBF40C603BD_4BBF3D8B00CD_var*
//#UC END# *4BBF40C603BD_4BBF3D8B00CD_var*
begin
//#UC START# *4BBF40C603BD_4BBF3D8B00CD_impl*
 inherited Create(aTag);
 f_Processor := aProcessor;
//#UC END# *4BBF40C603BD_4BBF3D8B00CD_impl*
end;//Tk2ProcessorTagTool.Create

function Tk2ProcessorTagTool.GetProcessor: Ik2Processor;
//#UC START# *54BD0F310322_4BBF3D8B00CD_var*
//#UC END# *54BD0F310322_4BBF3D8B00CD_var*
begin
//#UC START# *54BD0F310322_4BBF3D8B00CD_impl*
 Result := f_Processor;
//#UC END# *54BD0F310322_4BBF3D8B00CD_impl*
end;//Tk2ProcessorTagTool.GetProcessor

function Tk2ProcessorTagTool.StartOp(OpCode: Integer = 0;
 DoLock: Boolean = True): Ik2Op;
//#UC START# *54BD16B6032F_4BBF3D8B00CD_var*
//#UC END# *54BD16B6032F_4BBF3D8B00CD_var*
begin
//#UC START# *54BD16B6032F_4BBF3D8B00CD_impl*
 if (Processor = nil) then
  Result := nil
 else
  Result := Processor.StartOp(OpCode, DoLock);
//#UC END# *54BD16B6032F_4BBF3D8B00CD_impl*
end;//Tk2ProcessorTagTool.StartOp

class function Tk2ProcessorTagTool.Make(aTag: Tl3Variant;
 const aProcessor: Ik2Processor): Ik2TagTool;
var
 l_Inst : Tk2ProcessorTagTool;
begin
 l_Inst := Create(aTag, aProcessor);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tk2ProcessorTagTool.Make

function Tk2ProcessorTagTool.Get_Processor: Ik2Processor;
//#UC START# *4BBF42BF004D_4BBF3D8B00CDget_var*
//#UC END# *4BBF42BF004D_4BBF3D8B00CDget_var*
begin
//#UC START# *4BBF42BF004D_4BBF3D8B00CDget_impl*
 Result := GetProcessor;
//#UC END# *4BBF42BF004D_4BBF3D8B00CDget_impl*
end;//Tk2ProcessorTagTool.Get_Processor

procedure Tk2ProcessorTagTool.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4BBF3D8B00CD_var*
//#UC END# *479731C50290_4BBF3D8B00CD_var*
begin
//#UC START# *479731C50290_4BBF3D8B00CD_impl*
 f_Processor := nil;
 inherited;
//#UC END# *479731C50290_4BBF3D8B00CD_impl*
end;//Tk2ProcessorTagTool.Cleanup

procedure Tk2ProcessorTagTool.DoFire(const anEvent: Tk2Event;
 const anOp: Ik2Op);
//#UC START# *48CF73CE00B5_4BBF3D8B00CD_var*
//#UC END# *48CF73CE00B5_4BBF3D8B00CD_var*
begin
//#UC START# *48CF73CE00B5_4BBF3D8B00CD_impl*
 inherited;
 if (anEvent.ID = k2_eidTypeTableWillBeDestroyed) then
  f_Processor := nil;
//#UC END# *48CF73CE00B5_4BBF3D8B00CD_impl*
end;//Tk2ProcessorTagTool.DoFire

function Tk2ProcessorTagTool.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4BBF3D8B00CD_var*
//#UC END# *4A60B23E00C3_4BBF3D8B00CD_var*
begin
//#UC START# *4A60B23E00C3_4BBF3D8B00CD_impl*
 if IID.EQ(Ik2Processor) then
 begin
  Result.SetOk;
  Ik2Processor(Obj) := Processor;
 end//IID.EQ(Ik2Processor)
 else
  Result := inherited COMQueryInterface(IID, Obj)
//#UC END# *4A60B23E00C3_4BBF3D8B00CD_impl*
end;//Tk2ProcessorTagTool.COMQueryInterface

procedure Tk2ProcessorTagTool.ClearFields;
begin
 f_Processor := nil;
 inherited;
end;//Tk2ProcessorTagTool.ClearFields

end.
