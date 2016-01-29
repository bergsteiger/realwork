unit k2ProcessorTagTool;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2ProcessorTagTool.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2TagTool::Tk2ProcessorTagTool
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Interfaces,
  k2TagTool,
  k2PureMixIns,
  l3Variant,
  l3Types,
  l3Interfaces,
  k2Prim,
  l3IID
  ;

type
 Tk2ProcessorTagTool = class(Tk2TagTool)
 private
 // private fields
   f_Processor : Ik2Processor;
    {* Поле для свойства Processor}
 protected
 // property methods
   function pm_GetProcessor: Ik2Processor;
 protected
 // realized methods
   function Get_Processor: Ik2Processor;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure DoFire(const anEvent: Tk2Event;
    const anOp: Ik2Op); override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   function GetProcessor: Ik2Processor; virtual;
   function StartOp(OpCode: Integer = 0;
     DoLock: Boolean = true): Ik2Op;
 public
 // public methods
   constructor Create(aTag: Tl3Variant;
     const aProcessor: Ik2Processor); reintroduce;
   class function Make(aTag: Tl3Variant;
     const aProcessor: Ik2Processor): Ik2TagTool; reintroduce;
     {* Сигнатура фабрики Tk2ProcessorTagTool.Make }
 protected
 // protected properties
   property Processor: Ik2Processor
     read pm_GetProcessor;
 end;//Tk2ProcessorTagTool

implementation

uses
  l3Base
  ;

// start class Tk2ProcessorTagTool

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
  DoLock: Boolean = true): Ik2Op;
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
end;

function Tk2ProcessorTagTool.pm_GetProcessor: Ik2Processor;
//#UC START# *54BD169902EF_4BBF3D8B00CDget_var*
//#UC END# *54BD169902EF_4BBF3D8B00CDget_var*
begin
//#UC START# *54BD169902EF_4BBF3D8B00CDget_impl*
 Result := GetProcessor;
//#UC END# *54BD169902EF_4BBF3D8B00CDget_impl*
end;//Tk2ProcessorTagTool.pm_GetProcessor

function Tk2ProcessorTagTool.Get_Processor: Ik2Processor;
//#UC START# *4BBF42BF004D_4BBF3D8B00CDget_var*
//#UC END# *4BBF42BF004D_4BBF3D8B00CDget_var*
begin
//#UC START# *4BBF42BF004D_4BBF3D8B00CDget_impl*
 Result := GetProcessor;
//#UC END# *4BBF42BF004D_4BBF3D8B00CDget_impl*
end;//Tk2ProcessorTagTool.Get_Processor

procedure Tk2ProcessorTagTool.Cleanup;
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
 {-}
begin
 f_Processor := nil;
 inherited;
end;//Tk2ProcessorTagTool.ClearFields

end.