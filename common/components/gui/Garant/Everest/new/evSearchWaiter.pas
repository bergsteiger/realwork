unit evSearchWaiter;

// Модуль: "w:\common\components\gui\Garant\Everest\new\evSearchWaiter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevSearchWaiter" MUID: (4EA6A47C0260)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Tool
 , nevTools
 , l3Variant
;

type
 TevSearchWaiter = class(Tl3Tool, InevWaiter)
  private
   f_Searcher: IevSearcher;
   f_FoundBlock: InevDataObjectPrim2;
   f_Point: IevDocumentPoint;
   f_WasFound: Boolean;
  protected
   function TrySelect(const aContainer: InevDocumentContainer): Boolean;
   function TrySelectObj(const aContainer: InevDocumentContainer;
    aParent: Tl3Variant;
    aChild: Tl3Variant): Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aControl: InevControl;
    const aSearcher: IevSearcher); reintroduce;
   class function Make(const aControl: InevControl;
    const aSearcher: IevSearcher): InevWaiter;
 end;//TevSearchWaiter

implementation

uses
 l3ImplUses
 , l3Interfaces
 , l3Base
 , SysUtils
 , LeafPara_Const
 , evdInterfaces
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , k2Tags
 //#UC START# *4EA6A47C0260impl_uses*
 //#UC END# *4EA6A47C0260impl_uses*
;

constructor TevSearchWaiter.Create(const aControl: InevControl;
 const aSearcher: IevSearcher);
//#UC START# *4EA6A573010B_4EA6A47C0260_var*
//#UC END# *4EA6A573010B_4EA6A47C0260_var*
begin
//#UC START# *4EA6A573010B_4EA6A47C0260_impl*
 inherited Create(aControl As Il3ToolOwner);
 f_Searcher := aSearcher;
 f_FoundBlock := nil;
 f_Point := nil;
 f_WasFound := False;
//#UC END# *4EA6A573010B_4EA6A47C0260_impl*
end;//TevSearchWaiter.Create

class function TevSearchWaiter.Make(const aControl: InevControl;
 const aSearcher: IevSearcher): InevWaiter;
//#UC START# *4EA6A5C500A2_4EA6A47C0260_var*
var
 l_Waiter : TevSearchWaiter;
//#UC END# *4EA6A5C500A2_4EA6A47C0260_var*
begin
//#UC START# *4EA6A5C500A2_4EA6A47C0260_impl*
 l_Waiter := Create(aControl, aSearcher);
 try
  Result := l_Waiter;
 finally
  l3Free(l_Waiter);
 end;//try..finally
//#UC END# *4EA6A5C500A2_4EA6A47C0260_impl*
end;//TevSearchWaiter.Make

function TevSearchWaiter.TrySelect(const aContainer: InevDocumentContainer): Boolean;
//#UC START# *47C6B3040133_4EA6A47C0260_var*
var
 l_Sel     : InevSelection;
 l_Pt      : InevBasePoint;
 l_DocP    : IevDocumentPart;
 l_DocPt   : IevDocumentPoint;
 l_DPara   : InevPara;
 l_NewPt   : InevPoint;
 l_Start   : InevBasePoint;
 l_Finish  : InevBasePoint;
 l_NewSel  : InevRange;
 l_Control : InevControl;
//#UC END# *47C6B3040133_4EA6A47C0260_var*
begin
//#UC START# *47C6B3040133_4EA6A47C0260_impl*
 if (f_Owner = nil) then
 // - все уже нигде не надо позиционироваться
  Result := True
 else
  if f_FoundBlock <> nil then
  begin
   l_Control := (IUnknown(f_Owner) As InevControl);
   l_Sel := l_Control.Selection;
   if (l_Sel = nil) then
    Result := False
   else
   begin
    l_Pt := (f_Point as InevLocation).AsPoint;
    l_DocP := aContainer.Document.SubList.Block[l_Pt.Obj.Owner.IntA[k2_tiHandle]];
    if Supports(l_DocP, IevDocumentPoint, l_DocPt) then
    begin
     l_DPara := l_DocPt.Obj.AsPara;
     l_NewPt := l_DPara.MakePoint;
     l_NewPt.SetEntryPoint(l_Pt.Obj.PID + 1);
     l_Start := l_NewPt.ClonePoint(l_Control.View).Inner;
     l_Start.SetEntryPoint(f_FoundBlock.Borders.rStart);
     l_Start := l_Start.PointToParent;
     l_Finish := l_NewPt.ClonePoint(l_Control.View).Inner;
     l_Finish.SetEntryPoint(f_FoundBlock.Borders.rFinish);
     l_Finish := l_Finish.PointToParent;
     l_NewSel := l_Sel.GetBlock;
     (l_NewSel as InevRangeFactory).Init(l_Start, l_Finish);
     l_Sel.Select(l_NewSel, false);
    end; // if Supports(l_DocP, IevDocumentPoint, l_DocPt) then
    Result := True;
   end;
  end;
//#UC END# *47C6B3040133_4EA6A47C0260_impl*
end;//TevSearchWaiter.TrySelect

function TevSearchWaiter.TrySelectObj(const aContainer: InevDocumentContainer;
 aParent: Tl3Variant;
 aChild: Tl3Variant): Boolean;
//#UC START# *47C6B30F0277_4EA6A47C0260_var*
var
 l_Sel        : InevSelection;
 l_FoundBlock : IevdDataObject;
 l_Para       : InevObject;
 l_OutPara    : InevObject;
//#UC END# *47C6B30F0277_4EA6A47C0260_var*
begin
//#UC START# *47C6B30F0277_4EA6A47C0260_impl*
 Result := False;
 if (f_Owner = nil) then
 // - все уже нигде не надо позиционироваться
  Result := True
 else
 begin
  Result := False;
  if not f_WasFound and (f_Searcher <> nil) AND aChild.IsKindOf(k2_typLeafPara) then
   if aChild.QT(InevObject, l_Para) then
    try
     if evSearchPara(l_Para, f_Searcher, l_OutPara, False, @l_FoundBlock) then
     begin
      f_Point := l_OutPara.MakePoint As IevDocumentPoint;
      f_FoundBlock := l_FoundBlock As InevDataObjectPrim2;
      f_WasFound := True;
     end; // if evSearchPara(l_Para, f_Searcher, l_OutPara, False, @l_FoundBlock) then
    finally
     l_Para := nil;
    end//try..finally
   else
    Assert(false);
 end;   
//#UC END# *47C6B30F0277_4EA6A47C0260_impl*
end;//TevSearchWaiter.TrySelectObj

procedure TevSearchWaiter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4EA6A47C0260_var*
//#UC END# *479731C50290_4EA6A47C0260_var*
begin
//#UC START# *479731C50290_4EA6A47C0260_impl*
 f_Searcher := nil;
 f_FoundBlock := nil;
 f_Point := nil;
 f_WasFound := False;
 inherited;
//#UC END# *479731C50290_4EA6A47C0260_impl*
end;//TevSearchWaiter.Cleanup

end.
