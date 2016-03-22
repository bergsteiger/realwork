unit ChromeLikeBaseVisualObjectPrim;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseVisualObjectPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TChromeLikeBaseVisualObjectPrim" MUID: (5506A3B0036E)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3ProtoObject
 , ChromeLikeTabSetTypes
 , Types
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
;

type
 TChromeLikeMargins = class(Tl3ProtoObject)
  private
   f_RectData: TRect;
   f_OnChange: TNotifyEvent;
    {* Поле для свойства OnChange }
  private
   procedure Changed;
  protected
   function pm_GetLeft: Integer;
   procedure pm_SetLeft(aValue: Integer);
   function pm_GetTop: Integer;
   procedure pm_SetTop(aValue: Integer);
   function pm_GetRight: Integer;
   procedure pm_SetRight(aValue: Integer);
   function pm_GetBottom: Integer;
   procedure pm_SetBottom(aValue: Integer);
  public
   constructor Create(aLeft: Integer = 0;
    aTop: Integer = 0;
    aRight: Integer = 0;
    aBottom: Integer = 0); reintroduce;
  public
   property Left: Integer
    read pm_GetLeft
    write pm_SetLeft;
   property Top: Integer
    read pm_GetTop
    write pm_SetTop;
   property Right: Integer
    read pm_GetRight
    write pm_SetRight;
   property Bottom: Integer
    read pm_GetBottom
    write pm_SetBottom;
   property OnChange: TNotifyEvent
    read f_OnChange
    write f_OnChange;
 end;//TChromeLikeMargins

 TChromeLikeBaseVisualObjectPrim = class(Tl3ProtoObject, IChromeLikeTabSetAnimable)
  private
   f_StartTicks: Cardinal;
   f_CurrentTickCount: Integer;
   f_AnimationTime: Integer;
   f_StartRect: TRect;
   f_EndRect: TRect;
   f_EaseType: TChromeLikeTabEaseType;
   f_PositionInitialised: Boolean;
   f_PositionRect: TRect;
    {* Поле для свойства PositionRect }
   f_Parent: TChromeLikeBaseVisualObjectPrim;
    {* Поле для свойства Parent }
   f_Align: TAlign;
    {* Поле для свойства Align }
   f_HintText: WideString;
    {* Поле для свойства HintText }
   f_State: TChromeLikeVisualObjectState;
    {* Поле для свойства State }
   f_OnClick: TNotifyEvent;
    {* Поле для свойства OnClick }
   f_Behaviours: TChromeLikeVisualObjectBehaviours;
    {* Поле для свойства Behaviours }
   f_InAnimation: Boolean;
    {* Поле для свойства InAnimation }
   f_Margins: TChromeLikeMargins;
    {* Поле для свойства Margins }
   f_Visible: Boolean;
    {* Поле для свойства Visible }
  private
   procedure PaintChildren(const aContext: IChromeLkeTabSetDrawingContext);
   procedure LayoutChildren(const aRect: TRect);
   procedure DoOnMarginsChanged(aSender: TObject);
   procedure AnimationFinished;
   function DoAnimateMovement: Boolean;
  protected
   function pm_GetChildren(Index: Integer): TChromeLikeBaseVisualObjectPrim; virtual;
   function pm_GetPositionRect: TRect;
   procedure pm_SetPositionRect(const aValue: TRect);
   function pm_GetParent: TChromeLikeBaseVisualObjectPrim;
   procedure pm_SetParent(aValue: TChromeLikeBaseVisualObjectPrim);
   function pm_GetAlign: TAlign;
   procedure pm_SetAlign(aValue: TAlign);
   function pm_GetHintText: WideString;
   procedure pm_SetHintText(const aValue: WideString);
   function pm_GetState: TChromeLikeVisualObjectState;
   procedure pm_SetState(aValue: TChromeLikeVisualObjectState);
   function pm_GetVisible: Boolean;
   procedure pm_SetVisible(aValue: Boolean);
   function pm_GetChildrenCount: Integer; virtual;
   procedure RemoveChild(aIndex: Integer); virtual;
   procedure DeleteChildren;
   procedure InsertObject(aObject: TChromeLikeBaseVisualObjectPrim); virtual;
   procedure Invalidate; virtual;
   procedure DoPaint(const aContext: IChromeLkeTabSetDrawingContext); virtual;
   procedure DoMouseMove(const aPoint: TPoint); virtual;
   procedure DoClick(const aPoint: TPoint); virtual;
   procedure PositionChanged; virtual;
   procedure StateChanged; virtual;
   function IsMovable: Boolean;
   function IsUndockable: Boolean;
   function IsClickable: Boolean;
   function IsAnimable: Boolean;
   procedure Layout(var aRect: TRect);
   function MeasureSize: TSize; virtual;
   function MakeBehaviourParams: TChromeLikeVisualObjectBehaviours; virtual;
   procedure MakeChildControls; virtual;
   function DoGetCanMove(const aPoint: TPoint): Boolean; virtual;
   function Intersects(const aPoint: TPoint): Boolean;
   procedure DoMouseLeave; virtual;
   procedure DoMiddleButtonClick(const aPoint: TPoint); virtual;
   function AnimateMovement: Boolean;
   procedure FinishAnimationImmediately;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   function CanMove(const aPoint: TPoint): Boolean;
   function HitTest(const aPoint: TPoint): TChromeLikeBaseVisualObjectPrim;
   procedure SetPosition(const aRect: TRect;
    aAnimationTime: Cardinal;
    aEaseType: TChromeLikeTabEaseType);
   procedure SetHeight(aValue: Integer;
    aAnimationTime: Cardinal;
    aEaseType: TChromeLikeTabEaseType);
   procedure SetWidth(aValue: Integer;
    aAnimationTime: Cardinal;
    aEaseType: TChromeLikeTabEaseType);
   procedure SetLeft(aValue: Integer;
    aAnimationTime: Cardinal;
    aEaseType: TChromeLikeTabEaseType);
   procedure SetTop(aValue: Integer;
    aAnimationTime: Cardinal;
    aEaseType: TChromeLikeTabEaseType);
   procedure Paint(const aContext: IChromeLkeTabSetDrawingContext);
   procedure MouseMove(const aPoint: TPoint);
   procedure Click(const aPoint: TPoint);
   procedure RequestLayoutChildren;
   constructor Create(aParent: TChromeLikeBaseVisualObjectPrim); reintroduce; virtual;
   procedure MouseLeave;
   procedure MiddleButtonClick(const aPoint: TPoint);
  public
   property Children[Index: Integer]: TChromeLikeBaseVisualObjectPrim
    read pm_GetChildren;
   property PositionRect: TRect
    read pm_GetPositionRect
    write pm_SetPositionRect;
   property Parent: TChromeLikeBaseVisualObjectPrim
    read pm_GetParent
    write pm_SetParent;
   property Align: TAlign
    read pm_GetAlign
    write pm_SetAlign;
   property HintText: WideString
    read pm_GetHintText
    write pm_SetHintText;
   property State: TChromeLikeVisualObjectState
    read pm_GetState
    write pm_SetState;
   property OnClick: TNotifyEvent
    read f_OnClick
    write f_OnClick;
   property Behaviours: TChromeLikeVisualObjectBehaviours
    read f_Behaviours;
   property InAnimation: Boolean
    read f_InAnimation;
   property Margins: TChromeLikeMargins
    read f_Margins;
   property Visible: Boolean
    read pm_GetVisible
    write pm_SetVisible;
   property ChildrenCount: Integer
    read pm_GetChildrenCount;
 end;//TChromeLikeBaseVisualObjectPrim
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , ChromeLikeBaseVisualObject
 , SysUtils
 , ChromeLikeTabSetAnimationManager
 , Windows
 , ChromeLikeTabSetUtils
 , Math
;

function TChromeLikeMargins.pm_GetLeft: Integer;
//#UC START# *5506AC7800C3_5506AC0F0361get_var*
//#UC END# *5506AC7800C3_5506AC0F0361get_var*
begin
//#UC START# *5506AC7800C3_5506AC0F0361get_impl*
 Result := f_RectData.Left;
//#UC END# *5506AC7800C3_5506AC0F0361get_impl*
end;//TChromeLikeMargins.pm_GetLeft

procedure TChromeLikeMargins.pm_SetLeft(aValue: Integer);
//#UC START# *5506AC7800C3_5506AC0F0361set_var*
//#UC END# *5506AC7800C3_5506AC0F0361set_var*
begin
//#UC START# *5506AC7800C3_5506AC0F0361set_impl*
 if (aValue <> f_RectData.Left) then
 begin
  f_RectData.Left := aValue;
  Changed;
 end;
//#UC END# *5506AC7800C3_5506AC0F0361set_impl*
end;//TChromeLikeMargins.pm_SetLeft

function TChromeLikeMargins.pm_GetTop: Integer;
//#UC START# *5506AC830083_5506AC0F0361get_var*
//#UC END# *5506AC830083_5506AC0F0361get_var*
begin
//#UC START# *5506AC830083_5506AC0F0361get_impl*
 Result := f_RectData.Top;
//#UC END# *5506AC830083_5506AC0F0361get_impl*
end;//TChromeLikeMargins.pm_GetTop

procedure TChromeLikeMargins.pm_SetTop(aValue: Integer);
//#UC START# *5506AC830083_5506AC0F0361set_var*
//#UC END# *5506AC830083_5506AC0F0361set_var*
begin
//#UC START# *5506AC830083_5506AC0F0361set_impl*
 if (aValue <> f_RectData.Top) then
 begin
  f_RectData.Top := aValue;
  Changed;
 end;
//#UC END# *5506AC830083_5506AC0F0361set_impl*
end;//TChromeLikeMargins.pm_SetTop

function TChromeLikeMargins.pm_GetRight: Integer;
//#UC START# *5506AC9101D3_5506AC0F0361get_var*
//#UC END# *5506AC9101D3_5506AC0F0361get_var*
begin
//#UC START# *5506AC9101D3_5506AC0F0361get_impl*
 Result := f_RectData.Right;
//#UC END# *5506AC9101D3_5506AC0F0361get_impl*
end;//TChromeLikeMargins.pm_GetRight

procedure TChromeLikeMargins.pm_SetRight(aValue: Integer);
//#UC START# *5506AC9101D3_5506AC0F0361set_var*
//#UC END# *5506AC9101D3_5506AC0F0361set_var*
begin
//#UC START# *5506AC9101D3_5506AC0F0361set_impl*
 if (aValue <> f_RectData.Right) then
 begin
  f_RectData.Right := aValue;
  Changed;
 end;
//#UC END# *5506AC9101D3_5506AC0F0361set_impl*
end;//TChromeLikeMargins.pm_SetRight

function TChromeLikeMargins.pm_GetBottom: Integer;
//#UC START# *5506AC9C0173_5506AC0F0361get_var*
//#UC END# *5506AC9C0173_5506AC0F0361get_var*
begin
//#UC START# *5506AC9C0173_5506AC0F0361get_impl*
 Result := f_RectData.Bottom;
//#UC END# *5506AC9C0173_5506AC0F0361get_impl*
end;//TChromeLikeMargins.pm_GetBottom

procedure TChromeLikeMargins.pm_SetBottom(aValue: Integer);
//#UC START# *5506AC9C0173_5506AC0F0361set_var*
//#UC END# *5506AC9C0173_5506AC0F0361set_var*
begin
//#UC START# *5506AC9C0173_5506AC0F0361set_impl*
 if (aValue <> f_RectData.Bottom) then
 begin
  f_RectData.Bottom := aValue;
  Changed;
 end;
//#UC END# *5506AC9C0173_5506AC0F0361set_impl*
end;//TChromeLikeMargins.pm_SetBottom

procedure TChromeLikeMargins.Changed;
//#UC START# *5506ACBA0169_5506AC0F0361_var*
//#UC END# *5506ACBA0169_5506AC0F0361_var*
begin
//#UC START# *5506ACBA0169_5506AC0F0361_impl*
 if Assigned(f_OnChange) then
  f_OnChange(Self)
 else
  Assert(False);
//#UC END# *5506ACBA0169_5506AC0F0361_impl*
end;//TChromeLikeMargins.Changed

constructor TChromeLikeMargins.Create(aLeft: Integer = 0;
 aTop: Integer = 0;
 aRight: Integer = 0;
 aBottom: Integer = 0);
//#UC START# *5506ACCF00D0_5506AC0F0361_var*
//#UC END# *5506ACCF00D0_5506AC0F0361_var*
begin
//#UC START# *5506ACCF00D0_5506AC0F0361_impl*
 inherited Create;
 f_RectData.Top := aTop;
 f_RectData.Left := aLeft;
 f_RectData.Right := aRight;
 f_RectData.Bottom := aBottom;
//#UC END# *5506ACCF00D0_5506AC0F0361_impl*
end;//TChromeLikeMargins.Create

function TChromeLikeBaseVisualObjectPrim.pm_GetChildren(Index: Integer): TChromeLikeBaseVisualObjectPrim;
//#UC START# *5506A4F20013_5506A3B0036Eget_var*
//#UC END# *5506A4F20013_5506A3B0036Eget_var*
begin
//#UC START# *5506A4F20013_5506A3B0036Eget_impl*
 Assert(False);
//#UC END# *5506A4F20013_5506A3B0036Eget_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_GetChildren

function TChromeLikeBaseVisualObjectPrim.pm_GetPositionRect: TRect;
//#UC START# *5506A55103DB_5506A3B0036Eget_var*
//#UC END# *5506A55103DB_5506A3B0036Eget_var*
begin
//#UC START# *5506A55103DB_5506A3B0036Eget_impl*
 Result := f_PositionRect;
//#UC END# *5506A55103DB_5506A3B0036Eget_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_GetPositionRect

procedure TChromeLikeBaseVisualObjectPrim.pm_SetPositionRect(const aValue: TRect);
//#UC START# *5506A55103DB_5506A3B0036Eset_var*
//#UC END# *5506A55103DB_5506A3B0036Eset_var*
begin
//#UC START# *5506A55103DB_5506A3B0036Eset_impl*
 if (not SameRect(f_PositionRect, aValue)) then
 begin
  f_PositionRect := aValue;
//  f_PositionInitialized := True;
  PositionChanged;
  Invalidate;
 end;
//#UC END# *5506A55103DB_5506A3B0036Eset_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_SetPositionRect

function TChromeLikeBaseVisualObjectPrim.pm_GetParent: TChromeLikeBaseVisualObjectPrim;
//#UC START# *5506A56B01BB_5506A3B0036Eget_var*
//#UC END# *5506A56B01BB_5506A3B0036Eget_var*
begin
//#UC START# *5506A56B01BB_5506A3B0036Eget_impl*
 Result := f_Parent;
//#UC END# *5506A56B01BB_5506A3B0036Eget_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_GetParent

procedure TChromeLikeBaseVisualObjectPrim.pm_SetParent(aValue: TChromeLikeBaseVisualObjectPrim);
//#UC START# *5506A56B01BB_5506A3B0036Eset_var*
//#UC END# *5506A56B01BB_5506A3B0036Eset_var*
begin
//#UC START# *5506A56B01BB_5506A3B0036Eset_impl*
 if (aValue <> f_Parent) then
 begin
  f_Parent := aValue;
  f_Parent.InsertObject(Self);
 end;
//#UC END# *5506A56B01BB_5506A3B0036Eset_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_SetParent

function TChromeLikeBaseVisualObjectPrim.pm_GetAlign: TAlign;
//#UC START# *5506A596034A_5506A3B0036Eget_var*
//#UC END# *5506A596034A_5506A3B0036Eget_var*
begin
//#UC START# *5506A596034A_5506A3B0036Eget_impl*
 Result := f_Align;
//#UC END# *5506A596034A_5506A3B0036Eget_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_GetAlign

procedure TChromeLikeBaseVisualObjectPrim.pm_SetAlign(aValue: TAlign);
//#UC START# *5506A596034A_5506A3B0036Eset_var*
//#UC END# *5506A596034A_5506A3B0036Eset_var*
begin
//#UC START# *5506A596034A_5506A3B0036Eset_impl*
 if (aValue <> f_Align) then
 begin
  f_Align := aValue;
  if (f_Parent <> nil) then
   f_Parent.RequestLayoutChildren;
 end;
//#UC END# *5506A596034A_5506A3B0036Eset_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_SetAlign

function TChromeLikeBaseVisualObjectPrim.pm_GetHintText: WideString;
//#UC START# *5506A7C900D2_5506A3B0036Eget_var*
//#UC END# *5506A7C900D2_5506A3B0036Eget_var*
begin
//#UC START# *5506A7C900D2_5506A3B0036Eget_impl*
 Result := f_HintText;
//#UC END# *5506A7C900D2_5506A3B0036Eget_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_GetHintText

procedure TChromeLikeBaseVisualObjectPrim.pm_SetHintText(const aValue: WideString);
//#UC START# *5506A7C900D2_5506A3B0036Eset_var*
//#UC END# *5506A7C900D2_5506A3B0036Eset_var*
begin
//#UC START# *5506A7C900D2_5506A3B0036Eset_impl*
 if (aValue <> f_HintText) then
  f_HintText := aValue;
//#UC END# *5506A7C900D2_5506A3B0036Eset_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_SetHintText

function TChromeLikeBaseVisualObjectPrim.pm_GetState: TChromeLikeVisualObjectState;
//#UC START# *5506AA9C0043_5506A3B0036Eget_var*
//#UC END# *5506AA9C0043_5506A3B0036Eget_var*
begin
//#UC START# *5506AA9C0043_5506A3B0036Eget_impl*
 Result := f_State;
//#UC END# *5506AA9C0043_5506A3B0036Eget_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_GetState

procedure TChromeLikeBaseVisualObjectPrim.pm_SetState(aValue: TChromeLikeVisualObjectState);
//#UC START# *5506AA9C0043_5506A3B0036Eset_var*
//#UC END# *5506AA9C0043_5506A3B0036Eset_var*
begin
//#UC START# *5506AA9C0043_5506A3B0036Eset_impl*
 if (aValue <> f_State) then
 begin
  f_State := aValue;
  StateChanged;
 end;
//#UC END# *5506AA9C0043_5506A3B0036Eset_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_SetState

function TChromeLikeBaseVisualObjectPrim.pm_GetVisible: Boolean;
//#UC START# *5506ADD800E4_5506A3B0036Eget_var*
//#UC END# *5506ADD800E4_5506A3B0036Eget_var*
begin
//#UC START# *5506ADD800E4_5506A3B0036Eget_impl*
 Result := f_Visible;
//#UC END# *5506ADD800E4_5506A3B0036Eget_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_GetVisible

procedure TChromeLikeBaseVisualObjectPrim.pm_SetVisible(aValue: Boolean);
//#UC START# *5506ADD800E4_5506A3B0036Eset_var*
//#UC END# *5506ADD800E4_5506A3B0036Eset_var*
begin
//#UC START# *5506ADD800E4_5506A3B0036Eset_impl*
 if (aValue <> f_Visible) then
 begin
  f_Visible := aValue;
  Invalidate;
 end;
//#UC END# *5506ADD800E4_5506A3B0036Eset_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_SetVisible

function TChromeLikeBaseVisualObjectPrim.pm_GetChildrenCount: Integer;
//#UC START# *5506AF4E01FC_5506A3B0036Eget_var*
//#UC END# *5506AF4E01FC_5506A3B0036Eget_var*
begin
//#UC START# *5506AF4E01FC_5506A3B0036Eget_impl*
 Assert(False);
//#UC END# *5506AF4E01FC_5506A3B0036Eget_impl*
end;//TChromeLikeBaseVisualObjectPrim.pm_GetChildrenCount

procedure TChromeLikeBaseVisualObjectPrim.PaintChildren(const aContext: IChromeLkeTabSetDrawingContext);
//#UC START# *5506A3DF0209_5506A3B0036E_var*
var
 l_Index: Integer;
//#UC END# *5506A3DF0209_5506A3B0036E_var*
begin
//#UC START# *5506A3DF0209_5506A3B0036E_impl*
 for l_Index := 0 to Pred(ChildrenCount) do
  Children[l_Index].Paint(aContext);
//#UC END# *5506A3DF0209_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.PaintChildren

procedure TChromeLikeBaseVisualObjectPrim.LayoutChildren(const aRect: TRect);
//#UC START# *5506A447006A_5506A3B0036E_var*
var
 l_Index: Integer;
 l_Rect: TRect;
 l_Child: TChromeLikeBaseVisualObjectPrim;
//#UC END# *5506A447006A_5506A3B0036E_var*
begin
//#UC START# *5506A447006A_5506A3B0036E_impl*
 l_Rect := aRect;
 for l_Index := 0 to Pred(ChildrenCount) do
 begin
  l_Child := Children[l_Index];
  l_Child.Layout(l_Rect);
 end;
//#UC END# *5506A447006A_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.LayoutChildren

procedure TChromeLikeBaseVisualObjectPrim.RemoveChild(aIndex: Integer);
//#UC START# *5506A45102AC_5506A3B0036E_var*
//#UC END# *5506A45102AC_5506A3B0036E_var*
begin
//#UC START# *5506A45102AC_5506A3B0036E_impl*
 LayoutChildren(PositionRect);
//#UC END# *5506A45102AC_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.RemoveChild

procedure TChromeLikeBaseVisualObjectPrim.DeleteChildren;
//#UC START# *5506A45B0272_5506A3B0036E_var*
var
 l_Index: Integer;
 l_Child: TChromeLikeBaseVisualObjectPrim;
//#UC END# *5506A45B0272_5506A3B0036E_var*
begin
//#UC START# *5506A45B0272_5506A3B0036E_impl*
 for l_Index := Pred(ChildrenCount) downto 0 do
 begin
  l_Child := Children[l_Index];
  RemoveChild(l_Index);
  FreeAndNil(l_Child);
 end;
//#UC END# *5506A45B0272_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.DeleteChildren

procedure TChromeLikeBaseVisualObjectPrim.DoOnMarginsChanged(aSender: TObject);
//#UC START# *5506A46700C1_5506A3B0036E_var*
//#UC END# *5506A46700C1_5506A3B0036E_var*
begin
//#UC START# *5506A46700C1_5506A3B0036E_impl*
 if (f_Parent <> nil) then
  f_Parent.RequestLayoutChildren;
//#UC END# *5506A46700C1_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.DoOnMarginsChanged

procedure TChromeLikeBaseVisualObjectPrim.InsertObject(aObject: TChromeLikeBaseVisualObjectPrim);
//#UC START# *5506A438011F_5506A3B0036E_var*
//#UC END# *5506A438011F_5506A3B0036E_var*
begin
//#UC START# *5506A438011F_5506A3B0036E_impl*
 LayoutChildren(PositionRect);
//#UC END# *5506A438011F_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.InsertObject

procedure TChromeLikeBaseVisualObjectPrim.Invalidate;
//#UC START# *5506AE050362_5506A3B0036E_var*
//#UC END# *5506AE050362_5506A3B0036E_var*
begin
//#UC START# *5506AE050362_5506A3B0036E_impl*
 if (f_Parent <> nil) then
  f_Parent.Invalidate;
//#UC END# *5506AE050362_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.Invalidate

procedure TChromeLikeBaseVisualObjectPrim.AnimationFinished;
//#UC START# *5506AE1D02F9_5506A3B0036E_var*
//#UC END# *5506AE1D02F9_5506A3B0036E_var*
begin
//#UC START# *5506AE1D02F9_5506A3B0036E_impl*
 TChromeLikeTabSetAnimationManager.Instance.RemoveAnimable(Self);
 f_InAnimation := False;
//#UC END# *5506AE1D02F9_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.AnimationFinished

procedure TChromeLikeBaseVisualObjectPrim.DoPaint(const aContext: IChromeLkeTabSetDrawingContext);
//#UC START# *5506AE35023A_5506A3B0036E_var*
//#UC END# *5506AE35023A_5506A3B0036E_var*
begin
//#UC START# *5506AE35023A_5506A3B0036E_impl*
 Assert(False);
//#UC END# *5506AE35023A_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.DoPaint

procedure TChromeLikeBaseVisualObjectPrim.DoMouseMove(const aPoint: TPoint);
//#UC START# *5506AE54016E_5506A3B0036E_var*
//#UC END# *5506AE54016E_5506A3B0036E_var*
begin
//#UC START# *5506AE54016E_5506A3B0036E_impl*
 // Ничего не делаем
//#UC END# *5506AE54016E_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.DoMouseMove

procedure TChromeLikeBaseVisualObjectPrim.DoClick(const aPoint: TPoint);
//#UC START# *5506AE90023B_5506A3B0036E_var*
//#UC END# *5506AE90023B_5506A3B0036E_var*
begin
//#UC START# *5506AE90023B_5506A3B0036E_impl*
 if Assigned(f_OnClick) then
  f_OnClick(Self);
//#UC END# *5506AE90023B_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.DoClick

procedure TChromeLikeBaseVisualObjectPrim.PositionChanged;
//#UC START# *5506AEB502A2_5506A3B0036E_var*
//#UC END# *5506AEB502A2_5506A3B0036E_var*
begin
//#UC START# *5506AEB502A2_5506A3B0036E_impl*
 LayoutChildren(PositionRect);
 Invalidate;
//#UC END# *5506AEB502A2_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.PositionChanged

procedure TChromeLikeBaseVisualObjectPrim.StateChanged;
//#UC START# *5506AEC501BC_5506A3B0036E_var*
//#UC END# *5506AEC501BC_5506A3B0036E_var*
begin
//#UC START# *5506AEC501BC_5506A3B0036E_impl*
 Invalidate;
//#UC END# *5506AEC501BC_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.StateChanged

function TChromeLikeBaseVisualObjectPrim.IsMovable: Boolean;
//#UC START# *5506AED800F4_5506A3B0036E_var*
//#UC END# *5506AED800F4_5506A3B0036E_var*
begin
//#UC START# *5506AED800F4_5506A3B0036E_impl*
 Result := (cltcbMovable in f_Behaviours);
//#UC END# *5506AED800F4_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.IsMovable

function TChromeLikeBaseVisualObjectPrim.IsUndockable: Boolean;
//#UC START# *5506AEEE02B8_5506A3B0036E_var*
//#UC END# *5506AEEE02B8_5506A3B0036E_var*
begin
//#UC START# *5506AEEE02B8_5506A3B0036E_impl*
 Result := (cltcbUndockable in f_Behaviours);
//#UC END# *5506AEEE02B8_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.IsUndockable

function TChromeLikeBaseVisualObjectPrim.IsClickable: Boolean;
//#UC START# *5506AF040179_5506A3B0036E_var*
//#UC END# *5506AF040179_5506A3B0036E_var*
begin
//#UC START# *5506AF040179_5506A3B0036E_impl*
 Result := (cltcbClickable in f_Behaviours);
//#UC END# *5506AF040179_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.IsClickable

function TChromeLikeBaseVisualObjectPrim.IsAnimable: Boolean;
//#UC START# *5506AF1A025E_5506A3B0036E_var*
//#UC END# *5506AF1A025E_5506A3B0036E_var*
begin
//#UC START# *5506AF1A025E_5506A3B0036E_impl*
 Result := (cltcbAnimable in f_Behaviours);
//#UC END# *5506AF1A025E_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.IsAnimable

procedure TChromeLikeBaseVisualObjectPrim.Layout(var aRect: TRect);
//#UC START# *5506AF8F0264_5506A3B0036E_var*

 function lp_SubtractRect(const aObject: TRect;
                          const aSubject: TRect): TRect;
 begin
  case Align of
   alLeft:
    Result := Rect(aSubject.Right,
                   aObject.Top,
                   aObject.Right,
                   aObject.Bottom);
   alTop:
    Result := Rect(aObject.Left,
                   aSubject.Top,
                   aObject.Right,
                   aObject.Bottom);
   alBottom:
    Result := Rect(aObject.Left,
                   aObject.Top,
                   aObject.Right,
                   aSubject.Top);
   alRight:
    Result := Rect(aObject.Left,
                   aObject.Top,
                   aSubject.Left,
                   aObject.Bottom);
  else
   SetRectEmpty(Result);
  end;
 end;//lp_SubtractRect

var
 l_ContentSize: TSize;
 l_AreaSize: TSize;
 l_AreaRect: TRect;
 l_ContentRect: TRect;
 l_RemainderRect: TRect;
//#UC END# *5506AF8F0264_5506A3B0036E_var*
begin
//#UC START# *5506AF8F0264_5506A3B0036E_impl*
 l_AreaSize := MeasureSize;
 // - размер области, занимаемой контролом
 l_ContentSize := l_AreaSize;
 // - размер содержимого, подлежащего отрисовке

 Inc(l_AreaSize.cx, Margins.Left + Margins.Right);
 Inc(l_AreaSize.cy, Margins.Top + Margins.Bottom);
 // - увеличием размер занимаемой области с учетом маргинации

 SetRectEmpty(l_AreaRect);
 SetRectEmpty(l_ContentRect);
 SetRectEmpty(l_RemainderRect);

 case Align of
  // откусываем нужный кусок прямоугольника с соответствующей стороны
  alNone:
   l_AreaRect := Types.Rect(0,
                            0,
                            Pred(l_AreaSize.cx),
                            Pred(l_AreaSize.cy));
  alTop:
   l_AreaRect := Types.Rect(aRect.Left,
                            aRect.Top,
                            aRect.Right,
                            Min(aRect.Top + l_AreaSize.cy, aRect.Top));
  alBottom:
   l_AreaRect := Types.Rect(aRect.Left,
                            Min(aRect.Bottom - Margins.Bottom - l_AreaSize.cy, aRect.Top),
                            aRect.Right,
                            aRect.Bottom);
  alLeft:
   l_AreaRect := Types.Rect(aRect.Left,
                           aRect.Top,
                           Min(aRect.Left + l_AreaSize.cx, aRect.Right),
                           aRect.Bottom);
  alRight:
   l_AreaRect := Types.Rect(Max(aRect.Right - l_AreaSize.cx, aRect.Left),
                            aRect.Top,
                            aRect.Right,
                            aRect.Bottom);
  alClient:
   l_AreaRect := aRect;
 end;

 if (Align <> alClient) then
  SetPosition(PlaceRectInCenter(l_ContentSize, l_AreaRect, Margins.Left,
    Margins.Top, Margins.Right, Margins.Bottom), 0, ttNone)
 else
  SetPosition(l_AreaRect, 0, ttNone);

 with l_AreaRect do
 begin
  Left := Max(aRect.Left, l_AreaRect.Left - Margins.Left);
  Top := Max(aRect.Top, l_AreaRect.Top - Margins.Top);
  Right := Min(aRect.Right, l_AreaRect.Right + Margins.Top);
  Bottom := Min(aRect.Bottom, l_AreaRect.Bottom + Margins.Bottom);
 end;
 l_RemainderRect := lp_SubtractRect(aRect, l_AreaRect);
 // - Вычитаем из поданного прямоугольника прямоугольник, занятый контролом
 // с учетом маргинации
 aRect := l_RemainderRect;
//#UC END# *5506AF8F0264_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.Layout

function TChromeLikeBaseVisualObjectPrim.MeasureSize: TSize;
//#UC START# *5506B04102C9_5506A3B0036E_var*
//#UC END# *5506B04102C9_5506A3B0036E_var*
begin
//#UC START# *5506B04102C9_5506A3B0036E_impl*
 FillChar(Result, SizeOf(Result), 0);
//#UC END# *5506B04102C9_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.MeasureSize

function TChromeLikeBaseVisualObjectPrim.MakeBehaviourParams: TChromeLikeVisualObjectBehaviours;
//#UC START# *5506B0630312_5506A3B0036E_var*
//#UC END# *5506B0630312_5506A3B0036E_var*
begin
//#UC START# *5506B0630312_5506A3B0036E_impl*
 Result := [cltcbClickable];
//#UC END# *5506B0630312_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.MakeBehaviourParams

procedure TChromeLikeBaseVisualObjectPrim.MakeChildControls;
//#UC START# *5506B0910208_5506A3B0036E_var*
//#UC END# *5506B0910208_5506A3B0036E_var*
begin
//#UC START# *5506B0910208_5506A3B0036E_impl*
 // Ничего не делаем
//#UC END# *5506B0910208_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.MakeChildControls

function TChromeLikeBaseVisualObjectPrim.DoGetCanMove(const aPoint: TPoint): Boolean;
//#UC START# *5506B0A5038A_5506A3B0036E_var*
//#UC END# *5506B0A5038A_5506A3B0036E_var*
begin
//#UC START# *5506B0A5038A_5506A3B0036E_impl*
 Result := IsMovable;
//#UC END# *5506B0A5038A_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.DoGetCanMove

function TChromeLikeBaseVisualObjectPrim.CanMove(const aPoint: TPoint): Boolean;
//#UC START# *5506B0C600DB_5506A3B0036E_var*
//#UC END# *5506B0C600DB_5506A3B0036E_var*
begin
//#UC START# *5506B0C600DB_5506A3B0036E_impl*
 Result := DoGetCanMove(aPoint);
//#UC END# *5506B0C600DB_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.CanMove

function TChromeLikeBaseVisualObjectPrim.DoAnimateMovement: Boolean;
//#UC START# *5506B0F5038D_5506A3B0036E_var*
var
 l_NewRect: TRect;
//#UC END# *5506B0F5038D_5506A3B0036E_var*
begin
//#UC START# *5506B0F5038D_5506A3B0036E_impl*
 Result := (f_StartTicks > 0) and (f_CurrentTickCount < f_AnimationTime);

 if Result then
 begin
  f_CurrentTickCount := GetTickCount - f_StartTicks;
  if f_CurrentTickCount > f_AnimationTime then
   f_CurrentTickCount := f_AnimationTime;

  l_NewRect := TransformRect(f_StartRect,
                             f_EndRect,
                             f_CurrentTickCount,
                             f_AnimationTime,
                             f_EaseType);

  PositionRect := l_NewRect;
  if SameRect(l_NewRect, f_EndRect) then
   AnimationFinished;
 end;
//#UC END# *5506B0F5038D_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.DoAnimateMovement

function TChromeLikeBaseVisualObjectPrim.HitTest(const aPoint: TPoint): TChromeLikeBaseVisualObjectPrim;
//#UC START# *5506B120003B_5506A3B0036E_var*
var
 l_Index: Integer;
//#UC END# *5506B120003B_5506A3B0036E_var*
begin
//#UC START# *5506B120003B_5506A3B0036E_impl*
 Result := nil;
 if f_Visible and
    Intersects(aPoint) then
 begin
  for l_Index := 0 to Pred(ChildrenCount) do
  begin
   Result := Children[l_Index].HitTest(aPoint);
   if (Result <> nil) then
    Break
  end;
  if (Result = nil) then
   Result := Self;
 end;
//#UC END# *5506B120003B_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.HitTest

procedure TChromeLikeBaseVisualObjectPrim.SetPosition(const aRect: TRect;
 aAnimationTime: Cardinal;
 aEaseType: TChromeLikeTabEaseType);
//#UC START# *5506B156039B_5506A3B0036E_var*
//#UC END# *5506B156039B_5506A3B0036E_var*
begin
//#UC START# *5506B156039B_5506A3B0036E_impl*
 f_EaseType := aEaseType;
 f_AnimationTime := aAnimationTime;

 if IsAnimable and
//    f_PositionInitialised and
    (aEaseType <> ttNone) then
 begin
  // Нужно начать анимацию или находимся в процессе анимации -
  // установим конечные границы и посчитаем инкремент анимации
  if not SameRect(f_EndRect, aRect) then
  begin
   f_InAnimation := True;
   TChromeLikeTabSetAnimationManager.Instance.AddAnimable(Self);
   f_EndRect := aRect;
   f_StartRect := f_PositionRect;

   f_StartTicks := GetTickCount;
   f_CurrentTickCount := 0;
   PositionChanged;
  end
  else
   f_InAnimation := False;
 end
 else
 begin
  f_PositionInitialised := True;

  f_InAnimation := False;

  f_PositionRect := aRect;
  f_StartRect := aRect;
  f_EndRect := aRect;
  f_StartTicks := f_AnimationTime;
  f_CurrentTickCount := f_StartTicks;
  PositionChanged;
 end;
//#UC END# *5506B156039B_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.SetPosition

procedure TChromeLikeBaseVisualObjectPrim.SetHeight(aValue: Integer;
 aAnimationTime: Cardinal;
 aEaseType: TChromeLikeTabEaseType);
//#UC START# *5506B17F0017_5506A3B0036E_var*
//#UC END# *5506B17F0017_5506A3B0036E_var*
begin
//#UC START# *5506B17F0017_5506A3B0036E_impl*
 SetPosition(Types.Rect(f_PositionRect.Left,
                        f_PositionRect.Top,
                        f_PositionRect.Right,
                        f_PositionRect.Top + aValue),
             aAnimationTime,
             aEaseType);
//#UC END# *5506B17F0017_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.SetHeight

procedure TChromeLikeBaseVisualObjectPrim.SetWidth(aValue: Integer;
 aAnimationTime: Cardinal;
 aEaseType: TChromeLikeTabEaseType);
//#UC START# *5506B2660232_5506A3B0036E_var*
//#UC END# *5506B2660232_5506A3B0036E_var*
begin
//#UC START# *5506B2660232_5506A3B0036E_impl*
 SetPosition(Types.Rect(f_PositionRect.Left,
                        f_PositionRect.Top,
                        f_PositionRect.Left + aValue,
                        f_PositionRect.Bottom),
             aAnimationTime,
             aEaseType);
//#UC END# *5506B2660232_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.SetWidth

procedure TChromeLikeBaseVisualObjectPrim.SetLeft(aValue: Integer;
 aAnimationTime: Cardinal;
 aEaseType: TChromeLikeTabEaseType);
//#UC START# *5506B2830242_5506A3B0036E_var*
//#UC END# *5506B2830242_5506A3B0036E_var*
begin
//#UC START# *5506B2830242_5506A3B0036E_impl*
 SetPosition(Types.Rect(aValue,
                        f_PositionRect.Top,
                        RectWidth(f_PositionRect) + aValue,
                        f_PositionRect.Bottom),
             aAnimationTime,
             aEaseType);
//#UC END# *5506B2830242_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.SetLeft

procedure TChromeLikeBaseVisualObjectPrim.SetTop(aValue: Integer;
 aAnimationTime: Cardinal;
 aEaseType: TChromeLikeTabEaseType);
//#UC START# *5506B29C034A_5506A3B0036E_var*
//#UC END# *5506B29C034A_5506A3B0036E_var*
begin
//#UC START# *5506B29C034A_5506A3B0036E_impl*
 SetPosition(Types.Rect(f_PositionRect.Left,
                        aValue,
                        f_PositionRect.Right,
                        RectHeight(f_PositionRect) + aValue),
             aAnimationTime,
             aEaseType);
//#UC END# *5506B29C034A_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.SetTop

procedure TChromeLikeBaseVisualObjectPrim.Paint(const aContext: IChromeLkeTabSetDrawingContext);
//#UC START# *5506B2B700BD_5506A3B0036E_var*
//#UC END# *5506B2B700BD_5506A3B0036E_var*
begin
//#UC START# *5506B2B700BD_5506A3B0036E_impl*
 if f_Visible then
 begin
  DoPaint(aContext);
  PaintChildren(aContext);
 end;
//#UC END# *5506B2B700BD_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.Paint

procedure TChromeLikeBaseVisualObjectPrim.MouseMove(const aPoint: TPoint);
//#UC START# *5506B2E902C4_5506A3B0036E_var*
var
 l_HitTestControl: TChromeLikeBaseVisualObjectPrim;
 l_Index: Integer;
//#UC END# *5506B2E902C4_5506A3B0036E_var*
begin
//#UC START# *5506B2E902C4_5506A3B0036E_impl*
 l_HitTestControl := HitTest(aPoint);

 if ((State = cltcsHovered) and (l_HitTestControl <> Self)) then
  pm_SetState(cltcsNormal)
 else
 if (cltcbHoverable in Behaviours) and (l_HitTestControl = Self) then
  pm_SetState(cltcsHovered);

 for l_Index := 0 to Pred(ChildrenCount) do
  Children[l_Index].MouseMove(aPoint);

 DoMouseMove(aPoint);
//#UC END# *5506B2E902C4_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.MouseMove

procedure TChromeLikeBaseVisualObjectPrim.Click(const aPoint: TPoint);
//#UC START# *5506B30003D3_5506A3B0036E_var*
var
 l_HitTestControl: TChromeLikeBaseVisualObjectPrim;
//#UC END# *5506B30003D3_5506A3B0036E_var*
begin
//#UC START# *5506B30003D3_5506A3B0036E_impl*
 if (cltcbClickable in Behaviours) then
 begin
  l_HitTestControl := HitTest(aPoint);
  if (l_HitTestControl <> nil) and
     (l_HitTestControl <> Self) and
     (l_HitTestControl.Visible) then
   l_HitTestControl.Click(aPoint)
  else
  if (l_HitTestControl = Self) then
   DoClick(aPoint);
 end;
//#UC END# *5506B30003D3_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.Click

procedure TChromeLikeBaseVisualObjectPrim.RequestLayoutChildren;
//#UC START# *5506B3150222_5506A3B0036E_var*
//#UC END# *5506B3150222_5506A3B0036E_var*
begin
//#UC START# *5506B3150222_5506A3B0036E_impl*
 LayoutChildren(PositionRect);
//#UC END# *5506B3150222_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.RequestLayoutChildren

constructor TChromeLikeBaseVisualObjectPrim.Create(aParent: TChromeLikeBaseVisualObjectPrim);
//#UC START# *5506B7960083_5506A3B0036E_var*
//#UC END# *5506B7960083_5506A3B0036E_var*
begin
//#UC START# *5506B7960083_5506A3B0036E_impl*
 inherited Create;
 f_Margins := TChromeLikeMargins.Create;
 f_Margins.OnChange := DoOnMarginsChanged;
 SetRectEmpty(f_PositionRect);
 f_StartTicks := 0;
 f_CurrentTickCount:= 0 ;
 f_AnimationTime := 0;
 SetRectEmpty(f_StartRect);
 SetRectEmpty(f_EndRect);
 f_EaseType := ttNone;
 f_Visible := True;
 f_Behaviours := MakeBehaviourParams;
 MakeChildControls;
//#UC END# *5506B7960083_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.Create

function TChromeLikeBaseVisualObjectPrim.Intersects(const aPoint: TPoint): Boolean;
//#UC START# *550FD78403C0_5506A3B0036E_var*
//#UC END# *550FD78403C0_5506A3B0036E_var*
begin
//#UC START# *550FD78403C0_5506A3B0036E_impl*
 Result := IsPtInRect(aPoint, PositionRect);
//#UC END# *550FD78403C0_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.Intersects

procedure TChromeLikeBaseVisualObjectPrim.DoMouseLeave;
//#UC START# *552638BD00A3_5506A3B0036E_var*
var
 l_Index: Integer;
//#UC END# *552638BD00A3_5506A3B0036E_var*
begin
//#UC START# *552638BD00A3_5506A3B0036E_impl*
 for l_Index := 0 to Pred(ChildrenCount) do
  Children[l_Index].MouseLeave;
//#UC END# *552638BD00A3_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.DoMouseLeave

procedure TChromeLikeBaseVisualObjectPrim.MouseLeave;
//#UC START# *552638E40107_5506A3B0036E_var*
//#UC END# *552638E40107_5506A3B0036E_var*
begin
//#UC START# *552638E40107_5506A3B0036E_impl*
 DoMouseLeave;
//#UC END# *552638E40107_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.MouseLeave

procedure TChromeLikeBaseVisualObjectPrim.MiddleButtonClick(const aPoint: TPoint);
//#UC START# *5541B8970334_5506A3B0036E_var*
var
 l_HitTestControl: TChromeLikeBaseVisualObjectPrim;
//#UC END# *5541B8970334_5506A3B0036E_var*
begin
//#UC START# *5541B8970334_5506A3B0036E_impl*
 if (cltcbMiddleButtonClickable in Behaviours) then
 begin
  l_HitTestControl := HitTest(aPoint);
  if (l_HitTestControl <> nil) and
     (l_HitTestControl <> Self) and
     (l_HitTestControl.Visible) and
     (cltcbMiddleButtonClickable in l_HitTestControl.Behaviours) then
   l_HitTestControl.MiddleButtonClick(aPoint)
  else
   DoMiddleButtonClick(aPoint);
 end;
//#UC END# *5541B8970334_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.MiddleButtonClick

procedure TChromeLikeBaseVisualObjectPrim.DoMiddleButtonClick(const aPoint: TPoint);
//#UC START# *5541B8C900EE_5506A3B0036E_var*
//#UC END# *5541B8C900EE_5506A3B0036E_var*
begin
//#UC START# *5541B8C900EE_5506A3B0036E_impl*
 // Ничего не делаем
//#UC END# *5541B8C900EE_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.DoMiddleButtonClick

function TChromeLikeBaseVisualObjectPrim.AnimateMovement: Boolean;
//#UC START# *550A65720020_5506A3B0036E_var*
//#UC END# *550A65720020_5506A3B0036E_var*
begin
//#UC START# *550A65720020_5506A3B0036E_impl*
 Result := DoAnimateMovement;
//#UC END# *550A65720020_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.AnimateMovement

procedure TChromeLikeBaseVisualObjectPrim.FinishAnimationImmediately;
//#UC START# *55ACE26F032B_5506A3B0036E_var*
//#UC END# *55ACE26F032B_5506A3B0036E_var*
begin
//#UC START# *55ACE26F032B_5506A3B0036E_impl*
 PositionRect := f_EndRect;
 AnimationFinished;
//#UC END# *55ACE26F032B_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.FinishAnimationImmediately

procedure TChromeLikeBaseVisualObjectPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5506A3B0036E_var*
//#UC END# *479731C50290_5506A3B0036E_var*
begin
//#UC START# *479731C50290_5506A3B0036E_impl*
 TChromeLikeTabSetAnimationManager.Instance.RemoveAnimable(Self);
 FreeAndNil(f_Margins);
 inherited;
//#UC END# *479731C50290_5506A3B0036E_impl*
end;//TChromeLikeBaseVisualObjectPrim.Cleanup

procedure TChromeLikeBaseVisualObjectPrim.ClearFields;
begin
 Finalize(f_PositionRect);
 HintText := '';
 inherited;
end;//TChromeLikeBaseVisualObjectPrim.ClearFields
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
