unit evParaInterfaceFactoryPrim;

// Модуль: "w:\common\components\gui\Garant\Everest\evParaInterfaceFactoryPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevParaInterfaceFactoryPrim" MUID: (53D8DFA400E2)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2InterfaceFactory
 , l3Variant
 , l3IID
;

type
 TevParaInterfaceFactoryPrim = class(Tk2InterfaceFactory)
  protected
   function PreCOMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevParaInterfaceFactoryPrim

implementation

uses
 l3ImplUses
 , k2ToolPrim
 , nevTools
 , evdInterfaces
 , SysUtils
 , l3InterfacesMisc
 {$If Defined(evUseVisibleCursors)}
 , evSelection
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evUseVisibleCursors)}
 , evCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
;

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
