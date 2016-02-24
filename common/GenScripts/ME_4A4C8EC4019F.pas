unit evDocumentCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\evDocumentCursor.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaListCursor
 , nevTools
 , l3IID
 , nevBase
;

type
 TevDocumentCursor = class(TevParaListCursor, InevLinkedPoint)
  private
   f_Listener: Pointer;
   f_ListenerDisabled: Integer;
  protected
   function CanInsertParaOnMove: Boolean; virtual;
   procedure LinkListener(const aListener: InevPointListener);
   procedure UnlinkListener(const aListener: InevPointListener);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetLinkedPoint: InevLinkedPoint; override;
   function pm_GetListener: InevPointListener; override;
   function DoMovePrim(const aView: InevView;
    aCode: Integer;
    const anOp: InevOp;
    aCount: Integer): TnevMoveResult; override;
   {$If Defined(evNeedMarkers)}
   procedure DoGetMarkers(const aView: InevView;
    const aList: IevMarkersList); override;
   {$IfEnd} // Defined(evNeedMarkers)
   procedure DoDisableListener; override;
   procedure DoEnableListener; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   function CheckFirst(aChildPID: Integer): Boolean; override;
 end;//TevDocumentCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evMarker
 , evDocumentMarkers
 , nevInterfaces
 , k2Tags
 , TextPara_Const
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , evOp
 , k2Base
 , evInternalInterfaces
 , Block_Const
;

function TevDocumentCursor.CanInsertParaOnMove: Boolean;
//#UC START# *4BFFD9C80181_4A4C8EC4019F_var*
//#UC END# *4BFFD9C80181_4A4C8EC4019F_var*
begin
//#UC START# *4BFFD9C80181_4A4C8EC4019F_impl*
 Result := true;
//#UC END# *4BFFD9C80181_4A4C8EC4019F_impl*
end;//TevDocumentCursor.CanInsertParaOnMove

procedure TevDocumentCursor.LinkListener(const aListener: InevPointListener);
//#UC START# *47FCCB6E018E_4A4C8EC4019F_var*
//#UC END# *47FCCB6E018E_4A4C8EC4019F_var*
begin
//#UC START# *47FCCB6E018E_4A4C8EC4019F_impl*
 Assert((f_Listener = nil) OR (f_Listener = Pointer(aListener)));
 f_Listener := Pointer(aListener);
//#UC END# *47FCCB6E018E_4A4C8EC4019F_impl*
end;//TevDocumentCursor.LinkListener

procedure TevDocumentCursor.UnlinkListener(const aListener: InevPointListener);
//#UC START# *47FCCB7902AA_4A4C8EC4019F_var*
//#UC END# *47FCCB7902AA_4A4C8EC4019F_var*
begin
//#UC START# *47FCCB7902AA_4A4C8EC4019F_impl*
 Assert((f_Listener = nil) OR (f_Listener = Pointer(aListener)));
 f_Listener := nil;
//#UC END# *47FCCB7902AA_4A4C8EC4019F_impl*
end;//TevDocumentCursor.UnlinkListener

procedure TevDocumentCursor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A4C8EC4019F_var*
//#UC END# *479731C50290_4A4C8EC4019F_var*
begin
//#UC START# *479731C50290_4A4C8EC4019F_impl*
 f_Listener := nil;
 inherited;
//#UC END# *479731C50290_4A4C8EC4019F_impl*
end;//TevDocumentCursor.Cleanup

function TevDocumentCursor.pm_GetLinkedPoint: InevLinkedPoint;
//#UC START# *49E2F6CE0055_4A4C8EC4019Fget_var*
//#UC END# *49E2F6CE0055_4A4C8EC4019Fget_var*
begin
//#UC START# *49E2F6CE0055_4A4C8EC4019Fget_impl*
 Result := Self;
//#UC END# *49E2F6CE0055_4A4C8EC4019Fget_impl*
end;//TevDocumentCursor.pm_GetLinkedPoint

function TevDocumentCursor.pm_GetListener: InevPointListener;
//#UC START# *49E3136001F0_4A4C8EC4019Fget_var*
//#UC END# *49E3136001F0_4A4C8EC4019Fget_var*
begin
//#UC START# *49E3136001F0_4A4C8EC4019Fget_impl*
 if (f_Listener = nil) then
  Result := inherited pm_GetListener
 else
 if (f_ListenerDisabled > 0) then
  Result := nil
 else 
  Result := InevPointListener(f_Listener);
//#UC END# *49E3136001F0_4A4C8EC4019Fget_impl*
end;//TevDocumentCursor.pm_GetListener

function TevDocumentCursor.DoMovePrim(const aView: InevView;
 aCode: Integer;
 const anOp: InevOp;
 aCount: Integer): TnevMoveResult;
//#UC START# *49E31657038E_4A4C8EC4019F_var*
var
 l_Flags     : TevInsertParaFlags;
{$IfDef Nemesis}
 l_Container : InevDocumentContainer;
 l_Ed        : IevF1LikeEditor;
{$EndIf Nemesis}
//#UC END# *49E31657038E_4A4C8EC4019F_var*
begin
//#UC START# *49E31657038E_4A4C8EC4019F_impl*
 l_Flags := []; 
 Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
 if (Result <> ev_dcDoneOk) AND CanInsertParaOnMove then
 begin
  {$IfDef Nemesis}
  l_Container := ParaX.DocumentContainer;
  if (l_Container <> nil) then
  begin
   if (l_Container.TextSource <> nil) then
    if l_Container.TextSource.CastAnyEditorTo(IevF1LikeEditor, l_Ed) AND
       not l_Ed.CanInsertParaOnMove then
     Exit;
  end;//l_Container <> nil
  {$EndIf Nemesis}
  Case aCode of
   ev_ocParaLeft, ev_ocParaUp,
   ev_ocParaRight, ev_ocParaDown :
   begin
    Case aCode of
     ev_ocParaLeft, ev_ocParaUp: ;
     else
      l_Flags := [ev_ipfAtEnd];
    end;{Case aCode}
    if Self.HasInner AND not Self.GetInner.Obj.AsObject.IsKindOf(k2_typTextPara) then
    begin
     evInsertPara(anOp, Self, Tk2Type(GetRedirect.TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject, l_Flags);
     inherited DoMovePrim(aView, aCode, anOp, aCount);
     Result := ev_dcDoneOk;
    end;//not..k2_idTextPara..
   end;//ev_ocParaLeft, ev_ocParaUp..
  end;//Case aCode
 end;//Result <> ev_dcDoneOk
//#UC END# *49E31657038E_4A4C8EC4019F_impl*
end;//TevDocumentCursor.DoMovePrim

{$If Defined(evNeedMarkers)}
procedure TevDocumentCursor.DoGetMarkers(const aView: InevView;
 const aList: IevMarkersList);
//#UC START# *4A38AA5C019F_4A4C8EC4019F_var*
//#UC END# *4A38AA5C019F_4A4C8EC4019F_var*
begin
//#UC START# *4A38AA5C019F_4A4C8EC4019F_impl*
 AddMarker(aView, aList, k2_tiLeftIndent, ev_pmsPageLeftIndent,
  str_nevmhLeftDocMargin.AsCStr);
 AddMarker(aView, aList, k2_tiWidth, ev_pmsPageSize,
  str_nevmhPaperSize.AsCStr);
 AddMarker(aView, aList, k2_tiRightIndent, ev_pmsPageRightIndent,
  str_nevmhRightDocMargin.AsCStr,
  TevDocumentRightMarginMarker);
//#UC END# *4A38AA5C019F_4A4C8EC4019F_impl*
end;//TevDocumentCursor.DoGetMarkers
{$IfEnd} // Defined(evNeedMarkers)

procedure TevDocumentCursor.DoDisableListener;
//#UC START# *4A4C86B202B2_4A4C8EC4019F_var*
//#UC END# *4A4C86B202B2_4A4C8EC4019F_var*
begin
//#UC START# *4A4C86B202B2_4A4C8EC4019F_impl*
 Inc(f_ListenerDisabled);
//#UC END# *4A4C86B202B2_4A4C8EC4019F_impl*
end;//TevDocumentCursor.DoDisableListener

procedure TevDocumentCursor.DoEnableListener;
//#UC START# *4A4C86C103BF_4A4C8EC4019F_var*
//#UC END# *4A4C86C103BF_4A4C8EC4019F_var*
begin
//#UC START# *4A4C86C103BF_4A4C8EC4019F_impl*
 Dec(f_ListenerDisabled);
//#UC END# *4A4C86C103BF_4A4C8EC4019F_impl*
end;//TevDocumentCursor.DoEnableListener

function TevDocumentCursor.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4A4C8EC4019F_var*
var
 l_SubList : InevSubList;
//#UC END# *4A60B23E00C3_4A4C8EC4019F_var*
begin
//#UC START# *4A60B23E00C3_4A4C8EC4019F_impl*
 if IID.EQ(IevSub) then
 begin
  l_SubList := ParaX.MainSubList;
  if (l_SubList <> nil) then
   try
    Result.SetOk;
    IevSub(Obj) := l_SubList.Sub[GetRedirect.rLong(k2_tiHandle, -1)];
    if (IevSub(Obj) = nil) then
     Result.SetNOINTERFACE;
   finally
    l_SubList := nil;
   end//try..finally
  else
   Result.SetNOINTERFACE;
 end//IID.EQ(IevSub)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4A4C8EC4019F_impl*
end;//TevDocumentCursor.COMQueryInterface

function TevDocumentCursor.CheckFirst(aChildPID: Integer): Boolean;
//#UC START# *4FFC353A03C4_4A4C8EC4019F_var*
//#UC END# *4FFC353A03C4_4A4C8EC4019F_var*
begin
//#UC START# *4FFC353A03C4_4A4C8EC4019F_impl*
 Result := (aChildPID = 0) and HasInner and GetInner.AsObject.IsKindOf(k2_typBlock);
//#UC END# *4FFC353A03C4_4A4C8EC4019F_impl*
end;//TevDocumentCursor.CheckFirst
{$IfEnd} // Defined(evUseVisibleCursors)

end.
