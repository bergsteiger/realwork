unit nevParaListAnchor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevParaListAnchor.pas"
// Начат: 12.04.2005 15:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Anchors::TnevParaListAnchor
//
// Якорь для списков параграфов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\new\nevDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  nevTools,
  nevAnchor,
  l3Variant,
  nevBase
  {$If defined(evUseVisibleCursors)}
  ,
  nevParaListAnchorModifyTypes
  {$IfEnd} //evUseVisibleCursors
  ,
  k2Interfaces
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 _nevParaListTool_Parent_ = TnevAnchor;
 {$Include ..\new\nevParaListTool.imp.pas}
 _nevParaListViewBounds_Parent_ = _nevParaListTool_;
 {$Include w:\common\components\gui\Garant\Everest\nevParaListViewBounds.imp.pas}
 _nevParaListAnchorModify_Parent_ = _nevParaListViewBounds_;
 {$Include w:\common\components\gui\Garant\Everest\nevParaListAnchorModify.imp.pas}
 TnevParaListAnchor = class(_nevParaListAnchorModify_)
  {* Якорь для списков параграфов }
 private
 // private fields
   f_PID : Integer;
   f_Inner : InevBasePoint;
 private
 // private methods
   procedure ClearInner;
 protected
 // realized methods
   function GetAtStart: Boolean; override;
   function GetAtEnd(const aView: InevView): Boolean; override;
   function GetVertPosition(const aView: InevView;
    aMap: TnevFormatInfoPrim): TnevParaIndex; override;
   {$If defined(evUseVisibleCursors)}
   procedure SetPID(aValue: Integer); override;
   {$IfEnd} //evUseVisibleCursors
   {$If defined(evUseVisibleCursors)}
   function GetPID: Integer; override;
   {$IfEnd} //evUseVisibleCursors
 protected
 // overridden property methods
   function pm_GetHasInner: Boolean; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure DoFire(const anEvent: Tk2Event;
    const anOp: Ik2Op); override;
   function GetPosition: TnevPosition; override;
   function GetInner: InevBasePoint; override;
   procedure SetInner(const aValue: InevBasePoint); override;
   function NeedEvents: Boolean; override;
     {* Нужно ли подписываться на события тегов }
   procedure DoAssignPoint(const aView: InevView;
    const aPoint: InevBasePoint); override;
 public
 // overridden public methods
   constructor Create(aTag: Tl3Variant); override;
 protected
 // protected methods
   procedure CheckInner; virtual;
   procedure ClearInnerInFire; virtual;
 end;//TnevParaListAnchor
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  k2Tags,
  SysUtils,
  l3MinMax,
  Table_Const
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

{$Include ..\new\nevParaListTool.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevParaListViewBounds.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevParaListAnchorModify.imp.pas}

// start class TnevParaListAnchor

procedure TnevParaListAnchor.ClearInner;
//#UC START# *55376B0B01DC_4A3F457A0129_var*
//#UC END# *55376B0B01DC_4A3F457A0129_var*
begin
//#UC START# *55376B0B01DC_4A3F457A0129_impl*
 if (f_Inner <> nil) then
 begin
  f_Inner.Outer := nil;
  f_Inner := nil;
 end; // if (f_Inner <> nil) then*)
//#UC END# *55376B0B01DC_4A3F457A0129_impl*
end;//TnevParaListAnchor.ClearInner

procedure TnevParaListAnchor.CheckInner;
//#UC START# *4A58C42A029C_4A3F457A0129_var*
//#UC END# *4A58C42A029C_4A3F457A0129_var*
begin
//#UC START# *4A58C42A029C_4A3F457A0129_impl*
 if (f_Inner = nil) AND (f_PID >= 0) then
 begin
  f_Inner := ParaX[f_PID].MakeAnchor;
  if (f_Inner <> nil) then
   f_Inner.Outer := Self;
 end;//f_Inner = nil
//#UC END# *4A58C42A029C_4A3F457A0129_impl*
end;//TnevParaListAnchor.CheckInner

procedure TnevParaListAnchor.ClearInnerInFire;
//#UC START# *55376B1B00F8_4A3F457A0129_var*
//#UC END# *55376B1B00F8_4A3F457A0129_var*
begin
//#UC START# *55376B1B00F8_4A3F457A0129_impl*
 ClearInner;
//#UC END# *55376B1B00F8_4A3F457A0129_impl*
end;//TnevParaListAnchor.ClearInnerInFire

function TnevParaListAnchor.GetAtStart: Boolean;
//#UC START# *4A3B707700C9_4A3F457A0129_var*
//#UC END# *4A3B707700C9_4A3F457A0129_var*
begin
//#UC START# *4A3B707700C9_4A3F457A0129_impl*
 Result := (f_PID <= 0);
//#UC END# *4A3B707700C9_4A3F457A0129_impl*
end;//TnevParaListAnchor.GetAtStart

function TnevParaListAnchor.GetAtEnd(const aView: InevView): Boolean;
//#UC START# *4A3B708900C4_4A3F457A0129_var*
//#UC END# *4A3B708900C4_4A3F457A0129_var*
begin
//#UC START# *4A3B708900C4_4A3F457A0129_impl*
 if ParaX.IsVertical then
  Result := (f_PID >= Pred(Limit))
 else
  Result := (f_Inner <> nil);
//#UC END# *4A3B708900C4_4A3F457A0129_impl*
end;//TnevParaListAnchor.GetAtEnd

function TnevParaListAnchor.GetVertPosition(const aView: InevView;
  aMap: TnevFormatInfoPrim): TnevParaIndex;
//#UC START# *4A3B7F2E01CE_4A3F457A0129_var*
//#UC END# *4A3B7F2E01CE_4A3F457A0129_var*
begin
//#UC START# *4A3B7F2E01CE_4A3F457A0129_impl*
 Result := f_PID;
//#UC END# *4A3B7F2E01CE_4A3F457A0129_impl*
end;//TnevParaListAnchor.GetVertPosition

{$If defined(evUseVisibleCursors)}
procedure TnevParaListAnchor.SetPID(aValue: Integer);
//#UC START# *4B1D16510174_4A3F457A0129_var*
//#UC END# *4B1D16510174_4A3F457A0129_var*
begin
//#UC START# *4B1D16510174_4A3F457A0129_impl*
 if (f_PID <> aValue) then
 begin
  if aValue >= Pred(High(Integer)) then // из курсора приползло...
   if ParaX.IsVertical then
    f_PID := Pred(Limit)
   else
    if Limit = 0 then
     f_PID := -1
    else
     f_PID := 0
  else
   f_PID := aValue;
  ClearInner;
 end;//f_PID <> aValue
//#UC END# *4B1D16510174_4A3F457A0129_impl*
end;//TnevParaListAnchor.SetPID
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
function TnevParaListAnchor.GetPID: Integer;
//#UC START# *4B1D1957015A_4A3F457A0129_var*
//#UC END# *4B1D1957015A_4A3F457A0129_var*
begin
//#UC START# *4B1D1957015A_4A3F457A0129_impl*
 Result := f_PID;
//#UC END# *4B1D1957015A_4A3F457A0129_impl*
end;//TnevParaListAnchor.GetPID
{$IfEnd} //evUseVisibleCursors

procedure TnevParaListAnchor.Cleanup;
//#UC START# *479731C50290_4A3F457A0129_var*
//#UC END# *479731C50290_4A3F457A0129_var*
begin
//#UC START# *479731C50290_4A3F457A0129_impl*
 f_PID := 0;
 ClearInner;
 inherited;
//#UC END# *479731C50290_4A3F457A0129_impl*
end;//TnevParaListAnchor.Cleanup

procedure TnevParaListAnchor.DoFire(const anEvent: Tk2Event;
  const anOp: Ik2Op);
//#UC START# *48CF73CE00B5_4A3F457A0129_var*
//#UC END# *48CF73CE00B5_4A3F457A0129_var*
begin
//#UC START# *48CF73CE00B5_4A3F457A0129_impl*
 inherited;
 Case anEvent.ID of
  k2_eidChildrenDeleted:
  begin
   if (anEvent.Point <= f_PID) and (f_PID + 1 >= ParaX.AsObject.ChildrenCount) then
   begin
    ClearInnerInFire;
    Dec(f_PID);
   end // if (anEvent.Point <= f_PID) and (f_PID + 1 >= ParaX.ChildrenCount) then
   else
   if (anEvent.Point = f_PID) then
    ClearInnerInFire;
  end;//k2_eidChildrenDeleted
  k2_eidChildrenAdded,
  k2_eidChildrenInserted:
  begin
   if (anEvent.Point - 1 = f_PID) then
    ClearInnerInFire;
  end;//k2_eidChildrenAdded
 end;//Case anEvent.ID
//#UC END# *48CF73CE00B5_4A3F457A0129_impl*
end;//TnevParaListAnchor.DoFire

function TnevParaListAnchor.GetPosition: TnevPosition;
//#UC START# *4A3B7E540378_4A3F457A0129_var*
//#UC END# *4A3B7E540378_4A3F457A0129_var*
begin
//#UC START# *4A3B7E540378_4A3F457A0129_impl*
 Result := Succ(inherited GetPosition);
//#UC END# *4A3B7E540378_4A3F457A0129_impl*
end;//TnevParaListAnchor.GetPosition

function TnevParaListAnchor.GetInner: InevBasePoint;
//#UC START# *4A3B826402B8_4A3F457A0129_var*
//#UC END# *4A3B826402B8_4A3F457A0129_var*
begin
//#UC START# *4A3B826402B8_4A3F457A0129_impl*
 CheckInner;
 Result := f_Inner;
//#UC END# *4A3B826402B8_4A3F457A0129_impl*
end;//TnevParaListAnchor.GetInner

procedure TnevParaListAnchor.SetInner(const aValue: InevBasePoint);
//#UC START# *4A3B82710255_4A3F457A0129_var*
//#UC END# *4A3B82710255_4A3F457A0129_var*
begin
//#UC START# *4A3B82710255_4A3F457A0129_impl*
 if (f_Inner <> aValue) then
 begin
  if (f_Inner <> nil) then
   f_Inner.Outer := nil;
  f_Inner := aValue;
  if (f_Inner <> nil) then
  begin
   f_PID := aValue.Obj^.PID;
   f_Inner.Outer := Self;
  end; 
 end;//f_Inner <> aValue
//#UC END# *4A3B82710255_4A3F457A0129_impl*
end;//TnevParaListAnchor.SetInner

constructor TnevParaListAnchor.Create(aTag: Tl3Variant);
//#UC START# *4A3F4707018A_4A3F457A0129_var*
//#UC END# *4A3F4707018A_4A3F457A0129_var*
begin
//#UC START# *4A3F4707018A_4A3F457A0129_impl*
 inherited Create(aTag);
 if Limit = 0 then
  f_PID := -1
 else
  f_PID := 0;
//#UC END# *4A3F4707018A_4A3F457A0129_impl*
end;//TnevParaListAnchor.Create

function TnevParaListAnchor.NeedEvents: Boolean;
//#UC START# *4A48AFBD001D_4A3F457A0129_var*
//#UC END# *4A48AFBD001D_4A3F457A0129_var*
begin
//#UC START# *4A48AFBD001D_4A3F457A0129_impl*
 Result := True;
//#UC END# *4A48AFBD001D_4A3F457A0129_impl*
end;//TnevParaListAnchor.NeedEvents

function TnevParaListAnchor.pm_GetHasInner: Boolean;
//#UC START# *4A58BA550111_4A3F457A0129get_var*
//#UC END# *4A58BA550111_4A3F457A0129get_var*
begin
//#UC START# *4A58BA550111_4A3F457A0129get_impl*
 CheckInner;
 // - чтобы создать дочерний якорь
 Result := (f_Inner <> nil);
//#UC END# *4A58BA550111_4A3F457A0129get_impl*
end;//TnevParaListAnchor.pm_GetHasInner

procedure TnevParaListAnchor.DoAssignPoint(const aView: InevView;
  const aPoint: InevBasePoint);
//#UC START# *4B1D0220010E_4A3F457A0129_var*
var
 l_Pos : Integer;  
//#UC END# *4B1D0220010E_4A3F457A0129_var*
begin
//#UC START# *4B1D0220010E_4A3F457A0129_impl*
 inherited;
 if (aPoint <> nil) then
 begin
  {$IfDef Nemesis}
  if not ParaX.AsObject.IsSame(aPoint.Obj^.AsObject) then
   if not ((ParaX.ChildrenCount = 2) and aPoint.Obj.IsSame(ParaX.Child[0])) then // http://mdp.garant.ru/pages/viewpage.action?pageId=602702864 
    raise EnevMaybeBaseSwitched.Create('Наверное переключили базы. <K>: 200085315');
  // http://mdp.garant.ru/pages/viewpage.action?pageId=200085315&focusedCommentId=200088049#comment-200088049 
  {$Else  Nemesis}
  Assert(ParaX.IsSame(aPoint.Obj^.AsObject) or aPoint.HasBaseLine, Format('%s %s', [ParaX.TagType.AsString, aPoint.Obj^.TagType.AsString]));
  {$EndIf Nemesis}
  l_Pos := Pred(aPoint.Position);
  if (l_Pos > 0) AND not ParaX.IsVertical then
   SetPID(0)
  else
  begin
    SetPID(l_Pos);
    if Self.HasInner then
     Self.GetInner.AssignPoint(aView, aPoint.Inner);
  end;//l_Pos > 0..
  SignalScroll;
 end;//aPoint <> nil
//#UC END# *4B1D0220010E_4A3F457A0129_impl*
end;//TnevParaListAnchor.DoAssignPoint

{$IfEnd} //k2ForEditor

end.