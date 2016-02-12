unit evDocumentPartCursor;
 {* Курсор для блоков документа }

// Модуль: "w:\common\components\gui\Garant\Everest\evDocumentPartCursor.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaListCursor
 , nevTools
 , l3Types
 , l3IID
 , nevBase
 , l3Core
;

type
 TevDocumentPartCursor = class(TevParaListCursor)
  {* Курсор для блоков документа }
  private
   f_ShowCollapsed: Boolean;
  protected
   function ExpandOrCollapse(const aView: InevControlView;
    aExpandMode: Tl3Bool = l3_bUnknown): Boolean; virtual;
   procedure AfterCollapsed(const aView: InevControlView); virtual;
   function IsShowingDocumentParts(const aView: InevControlView): Boolean; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetShowCollapsed: Boolean; override;
   procedure pm_SetShowCollapsed(aValue: Boolean); override;
   function DoMovePrim(const aView: InevView;
    aCode: Integer;
    const anOp: InevOp;
    aCount: Integer): TnevMoveResult; override;
   function DoProcessMessage(const aView: InevControlView;
    var aMessage: TMessage;
    aTime: Cardinal): Boolean; override;
   function GetInner: InevBasePoint; override;
   {$If Defined(evNeedMarkers)}
   procedure DoGetMarkers(const aView: InevView;
    const aList: IevMarkersList); override;
   {$IfEnd} // Defined(evNeedMarkers)
   function pm_GetHasInner: Boolean; override;
   function DoDiff(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Integer; override;
  public
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
 end;//TevDocumentPartCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , k2Tags
 , k2OpMisc
 , evOp
 , evdTypes
 , OvcConst
 , OvcCmd
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
;

function TevDocumentPartCursor.ExpandOrCollapse(const aView: InevControlView;
 aExpandMode: Tl3Bool = l3_bUnknown): Boolean;
//#UC START# *4A3FA3CC00CC_4A3FA3290296_var*
var
 l_Value: Boolean;
//#UC END# *4A3FA3CC00CC_4A3FA3290296_var*
begin
//#UC START# *4A3FA3CC00CC_4A3FA3290296_impl*
 if IsShowingDocumentParts(aView) then
 begin
  case aExpandMode of
   l3_bUnknown:
    l_Value := not ParaX.AsObject.BoolA[k2_tiCollapsed];
   l3_bTrue:
    l_Value := False;
   l3_bFalse:
    l_Value := True;
   else
   begin
    Assert(false);
    l_Value := False;
   end;//else
  end;//case aExpandMode of
  ParaX.AsObject.BoolW[k2_tiCollapsed, k2StartOp(aView.Control.Processor)] := l_Value;
  AfterCollapsed(aView);
  Result := True;
 end//IsShowingDocumentParts(aView)
 else
  Result := False;
//#UC END# *4A3FA3CC00CC_4A3FA3290296_impl*
end;//TevDocumentPartCursor.ExpandOrCollapse

procedure TevDocumentPartCursor.AfterCollapsed(const aView: InevControlView);
//#UC START# *4A3FA3EB01D5_4A3FA3290296_var*
//#UC END# *4A3FA3EB01D5_4A3FA3290296_var*
begin
//#UC START# *4A3FA3EB01D5_4A3FA3290296_impl*

//#UC END# *4A3FA3EB01D5_4A3FA3290296_impl*
end;//TevDocumentPartCursor.AfterCollapsed

function TevDocumentPartCursor.IsShowingDocumentParts(const aView: InevControlView): Boolean;
//#UC START# *4A3FA3FA0033_4A3FA3290296_var*
//#UC END# *4A3FA3FA0033_4A3FA3290296_var*
begin
//#UC START# *4A3FA3FA0033_4A3FA3290296_impl*
 if (aView <> nil) then
  Result := aView.Metrics.ShowDocumentParts
 else
  Result := false;
//#UC END# *4A3FA3FA0033_4A3FA3290296_impl*
end;//TevDocumentPartCursor.IsShowingDocumentParts

procedure TevDocumentPartCursor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A3FA3290296_var*
//#UC END# *479731C50290_4A3FA3290296_var*
begin
//#UC START# *479731C50290_4A3FA3290296_impl*
 inherited;
 f_ShowCollapsed := false;
//#UC END# *479731C50290_4A3FA3290296_impl*
end;//TevDocumentPartCursor.Cleanup

function TevDocumentPartCursor.pm_GetShowCollapsed: Boolean;
//#UC START# *49E2F3E6036F_4A3FA3290296get_var*
//#UC END# *49E2F3E6036F_4A3FA3290296get_var*
begin
//#UC START# *49E2F3E6036F_4A3FA3290296get_impl*
 Result := f_ShowCollapsed;
//#UC END# *49E2F3E6036F_4A3FA3290296get_impl*
end;//TevDocumentPartCursor.pm_GetShowCollapsed

procedure TevDocumentPartCursor.pm_SetShowCollapsed(aValue: Boolean);
//#UC START# *49E2F3E6036F_4A3FA3290296set_var*
//#UC END# *49E2F3E6036F_4A3FA3290296set_var*
begin
//#UC START# *49E2F3E6036F_4A3FA3290296set_impl*
 f_ShowCollapsed := aValue;
//#UC END# *49E2F3E6036F_4A3FA3290296set_impl*
end;//TevDocumentPartCursor.pm_SetShowCollapsed

function TevDocumentPartCursor.DoMovePrim(const aView: InevView;
 aCode: Integer;
 const anOp: InevOp;
 aCount: Integer): TnevMoveResult;
//#UC START# *49E31657038E_4A3FA3290296_var*
//#UC END# *49E31657038E_4A3FA3290296_var*
begin
//#UC START# *49E31657038E_4A3FA3290296_impl*
 Case aCode of
  ev_ocParaUp,   ev_ocParaLeft,
  ev_ocParaDown, ev_ocParaRight:
  begin
   if not Self.HasInner then
   begin
    if (Self.pm_GetParentPoint <> nil) then
     Result := Self.pm_GetParentPoint.DoMove(aView, aCode, anOp, aCount)
    else
    begin
     Result := ev_dcDoneFail;
     Exit;
    end;//Self.pm_GetParentPoint <> nil
   end//not Self.HasInner
   else
    Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
  end;
  else
   Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
 end;//Case aCode
//#UC END# *49E31657038E_4A3FA3290296_impl*
end;//TevDocumentPartCursor.DoMovePrim

function TevDocumentPartCursor.DoProcessMessage(const aView: InevControlView;
 var aMessage: TMessage;
 aTime: Cardinal): Boolean;
//#UC START# *49E343F60057_4A3FA3290296_var*
var  
 l_Cmd : Word;
//#UC END# *49E343F60057_4A3FA3290296_var*
begin
//#UC START# *49E343F60057_4A3FA3290296_impl*
 Result := inherited DoProcessMessage(aView, aMessage, aTime);
 if not Result then
 begin
  l_Cmd := aView.Control.CommandProcessor.TranslateUsing(ovcListCommands, aMessage, aTime);
  Case l_Cmd of
   ccTreeExpand :
    Result := ExpandOrCollapse(aView);
   ccTreeCollapse:
    Result := ExpandOrCollapse(aView, l3_bFalse);
   ccShortCut:
    Result := true;
   else
    Result := false;
  end;//Case Cmd
 end;//not Result
//#UC END# *49E343F60057_4A3FA3290296_impl*
end;//TevDocumentPartCursor.DoProcessMessage

function TevDocumentPartCursor.GetInner: InevBasePoint;
//#UC START# *49E35A0402DB_4A3FA3290296_var*
//#UC END# *49E35A0402DB_4A3FA3290296_var*
begin
//#UC START# *49E35A0402DB_4A3FA3290296_impl*
 if f_ShowCollapsed then
  Result := inherited GetInner
 else
 if ParaX.AsObject.BoolA[k2_tiCollapsed] then
  if EvExpandedText(ParaX.AsObject) then
  begin
   Result := inherited GetInner;
   if (Result <> nil) and (Result.Obj.PID > 0) then
    Result := nil;
  end // if EvExpandedText(ParaX.AsObject) then
  else
   Result := nil
 else
  Result := inherited GetInner;
//#UC END# *49E35A0402DB_4A3FA3290296_impl*
end;//TevDocumentPartCursor.GetInner

{$If Defined(evNeedMarkers)}
procedure TevDocumentPartCursor.DoGetMarkers(const aView: InevView;
 const aList: IevMarkersList);
//#UC START# *4A38AA5C019F_4A3FA3290296_var*
//#UC END# *4A38AA5C019F_4A3FA3290296_var*
begin
//#UC START# *4A38AA5C019F_4A3FA3290296_impl*
//#UC END# *4A38AA5C019F_4A3FA3290296_impl*
end;//TevDocumentPartCursor.DoGetMarkers
{$IfEnd} // Defined(evNeedMarkers)

function TevDocumentPartCursor.pm_GetHasInner: Boolean;
//#UC START# *4A3A2E170304_4A3FA3290296get_var*
//#UC END# *4A3A2E170304_4A3FA3290296get_var*
begin
//#UC START# *4A3A2E170304_4A3FA3290296get_impl*
 if f_ShowCollapsed then
  Result := inherited pm_GetHasInner
 else
 if ParaX.AsObject.BoolA[k2_tiCollapsed] then
  Result := false
 else
  Result := inherited pm_GetHasInner;
//#UC END# *4A3A2E170304_4A3FA3290296get_impl*
end;//TevDocumentPartCursor.pm_GetHasInner

function TevDocumentPartCursor.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4A3FA3290296_var*
var
 l_SubList : InevSubList;
//#UC END# *4A60B23E00C3_4A3FA3290296_var*
begin
//#UC START# *4A60B23E00C3_4A3FA3290296_impl*
 if IID.EQ(IevSub) then
 begin
  l_SubList := ParaX.MainSubList;
  if (l_SubList <> nil) then
   try
    Result.SetOk;
    IevSub(Obj) := l_SubList.SubEx[ParaX.AsObject.rLong(k2_tiHandle, -1),
                                   ParaX.AsObject.rLong(k2_tiLayerID, Ord(ev_sbtSub))];
    if (IevSub(Obj) = nil) then
     Result.SetNoInterface;  
   finally
    l_SubList := nil;
   end//try..finally
  else
   Result.SetNOINTERFACE;
 end else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4A3FA3290296_impl*
end;//TevDocumentPartCursor.COMQueryInterface

function TevDocumentPartCursor.DoDiff(const aView: InevView;
 const aPoint: InevBasePoint;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *4AA785540310_4A3FA3290296_var*
var
 l_Inn: InevBasePoint;
//#UC END# *4AA785540310_4A3FA3290296_var*
begin
//#UC START# *4AA785540310_4A3FA3290296_impl*
 Result := inherited DoDiff(aView, aPoint, aMap);
 if (Result <> nev_PlusDiff) and (Result <> 0) and (Result <> nev_MinusDiff) then
 begin
  if aPoint.AsObject.BoolA[k2_tiCollapsed] and ParaX.AsObject.BoolA[k2_tiCollapsed] then
   Result := 0;
 end; // if (Result <> nev_PlusDiff) and (Result <> 0) and (Result <> nev_MinusDiff) then
//#UC END# *4AA785540310_4A3FA3290296_impl*
end;//TevDocumentPartCursor.DoDiff
{$IfEnd} // Defined(evUseVisibleCursors)

end.
