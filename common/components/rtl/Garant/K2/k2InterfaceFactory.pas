unit k2InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2InterfaceFactory
//
// Фабрика "старых" интерфейсов. Для поддержки старого кода, без настоящих интерфейсов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Interfaces,
  k2Interfaces,
  l3Types,
  l3IID,
  l3SimpleObject,
  k2ToolPrim,
  k2InterfaceCache,
  l3Variant
  ;

type
 Rk2InterfaceFactory = class of Tk2InterfaceFactory;

 Tk2InterfaceFactory = class(Tl3SimpleObject)
  {* Фабрика "старых" интерфейсов. Для поддержки старого кода, без настоящих интерфейсов. }
 private
 // private fields
   f_Interfaces : Tk2InterfaceCache;
    {* Поле для свойства Interfaces}
 public
 // realized methods
   {iterator} procedure IterateCursors(anAction: Mk2InterfaceFactory_IterateCursors_Action);
   {iterator} procedure IterateCursorsF(anAction: Mk2InterfaceFactory_IterateCursors_Action);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   function COMQueryTool(aTag: Tl3Tag;
     const aIID: Tl3GUID;
     out theTool;
     const aProcessor: Ik2Processor): Boolean; virtual;
   function PreCOMQueryTool(aTag: Tl3Tag;
     const aIID: Tl3GUID;
     out theTool;
     const aProcessor: Ik2Processor): Boolean; virtual;
 public
 // public methods
   function QueryTool(aTag: Tl3Variant;
     const ID: Tl3IID;
     out I: Tk2ToolPrim): Boolean; virtual;
   function LoadTool(const ID: Tl3IID): Tk2ToolPrim;
     {* загрузить инструмент }
   function StoreTool(const ID: Tl3IID;
     I: Tk2ToolPrim): Boolean;
     {* сохранить инструмент }
   function QueryToolN(aTag: Tl3Variant;
    const IID: TGUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean;
   procedure Iterate(Tag: Tl3Variant;
    Action: Tl3IteratorAction);
 public
 // public properties
   property Interfaces: Tk2InterfaceCache
     read f_Interfaces;
 end;//Tk2InterfaceFactory

implementation

uses
  k2Base,
  k2TagPointer,
  l3Base
  ;

// start class Tk2InterfaceFactory

function Tk2InterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4D63C2420229_var*
//#UC END# *4D63D26D033F_4D63C2420229_var*
begin
//#UC START# *4D63D26D033F_4D63C2420229_impl*
 I := nil;
 Result := false;
//#UC END# *4D63D26D033F_4D63C2420229_impl*
end;//Tk2InterfaceFactory.QueryTool

function Tk2InterfaceFactory.LoadTool(const ID: Tl3IID): Tk2ToolPrim;
//#UC START# *531F02030218_4D63C2420229_var*
//#UC END# *531F02030218_4D63C2420229_var*
begin
//#UC START# *531F02030218_4D63C2420229_impl*
 Result := f_Interfaces.GetInterface(ID);
//#UC END# *531F02030218_4D63C2420229_impl*
end;//Tk2InterfaceFactory.LoadTool

function Tk2InterfaceFactory.StoreTool(const ID: Tl3IID;
  I: Tk2ToolPrim): Boolean;
//#UC START# *531F022801F6_4D63C2420229_var*
//#UC END# *531F022801F6_4D63C2420229_var*
begin
//#UC START# *531F022801F6_4D63C2420229_impl*
 if I.StoreToOldCache then
 begin
  f_Interfaces.SetInterface(ID, I);
  Result := true;
 end//I.StoreToOldCache
 else
  Result := false;
//#UC END# *531F022801F6_4D63C2420229_impl*
end;//Tk2InterfaceFactory.StoreTool

function Tk2InterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4D63C2420229_var*
//#UC END# *53CCBDA5026D_4D63C2420229_var*
begin
//#UC START# *53CCBDA5026D_4D63C2420229_impl*
 IUnknown(theTool) := nil;
 Result := false;
//#UC END# *53CCBDA5026D_4D63C2420229_impl*
end;//Tk2InterfaceFactory.COMQueryTool

function Tk2InterfaceFactory.PreCOMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D8E1970262_4D63C2420229_var*
//#UC END# *53D8E1970262_4D63C2420229_var*
begin
//#UC START# *53D8E1970262_4D63C2420229_impl*
 IUnknown(theTool) := nil;
 Result := false;
//#UC END# *53D8E1970262_4D63C2420229_impl*
end;//Tk2InterfaceFactory.PreCOMQueryTool

function Tk2InterfaceFactory.QueryToolN(aTag: Tl3Variant;
  const IID: TGUID;
  out Tool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *469F9954029C_4D63C2420229_var*
//#UC END# *469F9954029C_4D63C2420229_var*
begin
//#UC START# *469F9954029C_4D63C2420229_impl*
 Result := PreCOMQueryTool(aTag, Tl3GUID_C(IID), Tool, aProcessor);
 if not Result then
  Result := COMQueryTool(aTag, Tl3GUID_C(IID), Tool, aProcessor);
//#UC END# *469F9954029C_4D63C2420229_impl*
end;//Tk2InterfaceFactory.QueryToolN

procedure Tk2InterfaceFactory.Iterate(Tag: Tl3Variant;
  Action: Tl3IteratorAction);
//#UC START# *47678ABF00C1_4D63C2420229_var*

 type
  Pk2TagPointer = ^Tk2TagPointer;

 function _IA(I: Pk2TagPointer; Index: Long): Bool;
 begin//_IA
  if I^.GetRedirect.IsSame(Tag) then
   Result := Action(I, Index)
  else
   Result := true;
 end;//_IA
 
var
 IA : Tl3IteratorAction;
//#UC END# *47678ABF00C1_4D63C2420229_var*
begin
//#UC START# *47678ABF00C1_4D63C2420229_impl*
 IA := l3L2IA(@_IA);
 try
  Tk2Type(Tag.TagType).InterfaceFactory.IterateCursors(IA);
 finally
  l3FreeIA(IA);
 end;{try..finally}
//#UC END# *47678ABF00C1_4D63C2420229_impl*
end;//Tk2InterfaceFactory.Iterate

{iterator} procedure Tk2InterfaceFactory.IterateCursors(anAction: Mk2InterfaceFactory_IterateCursors_Action);
//#UC START# *4BCC45AA02CE_4D63C2420229_var*
//#UC END# *4BCC45AA02CE_4D63C2420229_var*
begin
//#UC START# *4BCC45AA02CE_4D63C2420229_impl*
 f_Interfaces.IterateInterfaces(ev_iidCursor, anAction);
//#UC END# *4BCC45AA02CE_4D63C2420229_impl*
end;//Tk2InterfaceFactory.IterateCursors

{iterator} procedure Tk2InterfaceFactory.IterateCursorsF(anAction: Mk2InterfaceFactory_IterateCursors_Action);
var
 Hack : Pointer absolute anAction;
begin
 try
  IterateCursors(anAction);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;

procedure Tk2InterfaceFactory.Cleanup;
//#UC START# *479731C50290_4D63C2420229_var*
//#UC END# *479731C50290_4D63C2420229_var*
begin
//#UC START# *479731C50290_4D63C2420229_impl*
 f_Interfaces.Clear;
 inherited;
//#UC END# *479731C50290_4D63C2420229_impl*
end;//Tk2InterfaceFactory.Cleanup

procedure Tk2InterfaceFactory.ClearFields;
 {-}
begin
 Finalize(f_Interfaces);
 inherited;
end;//Tk2InterfaceFactory.ClearFields

end.