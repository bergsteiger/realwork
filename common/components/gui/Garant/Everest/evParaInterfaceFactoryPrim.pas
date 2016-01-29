unit evParaInterfaceFactoryPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evParaInterfaceFactoryPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Standard::TevParaInterfaceFactoryPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2InterfaceFactory,
  l3IID,
  l3Variant
  ;

type
 TevParaInterfaceFactoryPrim = class(Tk2InterfaceFactory)
 protected
 // overridden protected methods
   function PreCOMQueryTool(aTag: Tl3Tag;
     const aIID: Tl3GUID;
     out theTool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TevParaInterfaceFactoryPrim

implementation

uses
  k2ToolPrim,
  nevTools,
  evdInterfaces,
  SysUtils,
  l3InterfacesMisc
  {$If defined(evUseVisibleCursors)}
  ,
  evSelection
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evCursor
  {$IfEnd} //evUseVisibleCursors
  
  ;

// start class TevParaInterfaceFactoryPrim

function TevParaInterfaceFactoryPrim.PreCOMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D8E1970262_53D8DFA400E2_var*
{$IfDef evUseVisibleCursors}
var
 l_Cursor : TevCursor;
 l_Block  : TevRange;
{$EndIf evUseVisibleCursors}
//#UC END# *53D8E1970262_53D8DFA400E2_var*
begin
//#UC START# *53D8E1970262_53D8DFA400E2_impl*
 Result := true;
 {$IfDef evUseVisibleCursors}
 if aIID.SomeOf([InevRangeFactory, InevStorable, IevdDataObject]) then
 begin
  if QueryTool(aTag, ev_iidBlock, Tk2ToolPrim(l_Block)) then
   try
    l_Block.Target := aTag;
    l_Block.DoInit(nil, nil, false);
    Result := l3IOk(l_Block.QueryInterface(aIID.IID, theTool));
   finally
    FreeAndNil(l_Block);
   end//try..finally
  else
   Result := false;
 end//IID.SomeOf([IevdDataObject..
 else
 if aIID.EQ(InevPoint) then
 begin
  l_Cursor := LoadTool(ev_iidCursor).Use;
  if (l_Cursor <> nil) then
   try
    l_Cursor.Target := aTag;
    InevPoint(l_Cursor).SetEntryPointPrim(0);
    Assert(not InevPoint(l_Cursor).HasInner);
    InevPoint(theTool) := l_Cursor;
   finally
    FreeAndNil(l_Cursor);
   end//try..finally
  else
  if QueryTool(aTag, ev_iidCursor, Tk2ToolPrim(l_Cursor)) then
   try
    l_Cursor.Target := aTag;
    StoreTool(ev_iidCursor, l_Cursor);
    InevPoint(theTool) := l_Cursor;
   finally
    FreeAndNil(l_Cursor);
   end//try..finally
  else
   Result := false;
 end//IID.EQ(InevPoint)
 else
 {$EndIf evUseVisibleCursors}
  Result := inherited PreCOMQueryTool(aTag, aIID, theTool, aProcessor);
//#UC END# *53D8E1970262_53D8DFA400E2_impl*
end;//TevParaInterfaceFactoryPrim.PreCOMQueryTool

end.