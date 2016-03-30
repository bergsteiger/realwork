unit nevAnchor;
 {* Якорь для абстрактного параграфа }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevAnchor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevAnchor" MUID: (49DE393900D3)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevTools
 , nevBase
 , l3Variant
 , l3Core
 , k2TagPointer
 , k2Base
;

type
 {$Include w:\common\components\gui\Garant\Everest\new\nevAnchor.imp.pas}
 _nevAnchorModify_Parent_ = _nevAnchor_;
 {$Include w:\common\components\gui\Garant\Everest\nevAnchorModify.imp.pas}
 TnevAnchor = class(_nevAnchorModify_, InevBasePoint, InevAnchor)
  {* Якорь для абстрактного параграфа }
  private
   f_View: Pointer;
   f_LockScroll: Integer;
   f_NeedSignal: Boolean;
  protected
   function pm_GetHasInner: Boolean; virtual;
   function GetAtStart: Boolean; virtual; abstract;
   function GetAtEnd(const aView: InevView): Boolean; virtual; abstract;
   function GetAsLeaf: InevLeafPoint; virtual;
   function GetPosition: TnevPosition; virtual;
   function GetVertPosition(const aView: InevView;
    aMap: TnevFormatInfoPrim): TnevParaIndex; virtual; abstract;
   function GetInner: InevBasePoint; virtual;
   procedure SetInner(const aValue: InevBasePoint); virtual;
   function GetInnerFor(const aChild: InevObject;
    var aRealTop: InevBasePoint): InevBasePoint; virtual;
   function DoHasBaseLine: Boolean; virtual;
   function DoGetInnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
    aForDrawing: TnevInnerType): InevBasePoint; virtual;
   function GetInnerTop(const aChild: InevObject): InevBasePoint; virtual;
   procedure DoAssignPoint(const aView: InevView;
    const aPoint: InevBasePoint); virtual;
   procedure DoAddInner(const aView: InevView;
    const anInner: InevBaseLine4Anchor;
    anIndex: Integer;
    var aFirst: Boolean;
    aMode: TnevAddInnerMode); virtual;
   procedure DoCompareWithOtherInner(const aView: InevView;
    anMaxID: Integer = -1); virtual;
   procedure DoInitByCursor(const aView: InevView;
    const anInnerPoint: InevBasePoint); virtual;
    {* Инициализируем базовую линию по курсору. }
   function Range: InevRange;
   function pm_GetFormatting: InevDataFormatting;
   function VertPosition(const aView: InevView;
    aMap: TnevFormatInfoPrim): TnevParaIndex;
   function NeedWindowsCaret: Boolean;
   function ClonePoint(const aView: InevView): InevBasePoint;
   function DeltaX(const aView: InevView;
    const aMap: InevMap): Integer;
   function pm_GetInner: InevBasePoint;
   procedure pm_SetInner(const aValue: InevBasePoint);
   function Get_Position: TnevPosition;
   function LinkListener(const aView: InevScrollListener): InevScrollListener;
   procedure UnlinkListener(const aControl: InevScrollListener);
   function InnerFor(const aChild: InevObject;
    var aRealTop: InevBasePoint): InevBasePoint;
   function pm_GetAfterEnd: Boolean;
   function Get_AsLeaf: InevLeafPoint;
   function AtEnd(const aView: InevView): Boolean;
   function AtStart: Boolean;
   function pm_GetText: InevText;
   function Get_HasInner: Boolean;
   function Get_ShowCollapsed: Boolean;
   procedure Set_ShowCollapsed(aValue: Boolean);
   function Compare(const aPoint: InevBasePoint): Integer;
   procedure CheckPos(const anOp: InevOp);
    {* Избавляемся от рассинхронизации позиции курсора и дочернего параграфа. Заплатка конечно }
   function ReadOnly: Boolean;
   function AsPoint: InevBasePoint;
   function AsCursor(const aView: InevView): InevPoint;
   {$If Defined(evNeedMarkers)}
   function Get_MarkersSource: IevMarkersSource;
   {$IfEnd} // Defined(evNeedMarkers)
   function ProcessMessage(const aView: InevControlView;
    var aMessage: TMessage;
    aTime: Cardinal): Boolean;
   function Get_Listener: InevPointListener;
   function GetBlockLength: Integer;
   procedure MergeTo(const aView: InevView;
    const aBaseLine: InevBasePoint);
    {* Объединяем значения отрисованных частей. }
   function InnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
    aForDrawing: TnevInnerType): InevBasePoint;
    {* Получаем первый параграф, по которому можно получить вложенную точку. }
   function HasBaseLine: Boolean;
    {* Проверяет есть ли возможность работы с базовой линией на точке }
   procedure AddInner(const aView: InevView;
    const anInner: InevBaseLine4Anchor;
    anIndex: Integer;
    var aFirst: Boolean;
    aMode: TnevAddInnerMode);
   procedure CompareWithOtherInner(const aView: InevView;
    anMaxID: Integer = -1);
    {* После применения AnchorByPoint могут остаться "неинициализированные" (будут указывать на начало ячейки) дочерние точки в базовой линии. }
   function InnerHead(aPID: Integer): InevBasePoint;
    {* Аналог InnerFor, но для частей объдеиненных ячеек, попадающих на данную строку (пока используется только для печати). }
   function HasHeadPart: Boolean;
    {* Строка содержит продолжение объединенных ячеек. }
   procedure AddHeadInner(const aHeadInner: InevBasePoint);
    {* Служит для добавления в базовую линию продолжений объединенных ячеек (используется только для печати). }
   procedure CopyHeadParts(const aFrom: InevBasePoint);
    {* Копирует только части продолжений ячеек, если они есть. }
   procedure InitByCursor(const aView: InevView;
    const anInnerPoint: InevBasePoint);
    {* Инициализируем базовую линию по курсору. }
   procedure InitBaseLineInner(const aView: InevView;
    const anItem: InevPara);
   function InnerTop(const aChild: InevObject): InevBasePoint;
    {* Возвращает указатель на первоначальную позицию для точки. Для обычных точек - всегда nil. }
   function pm_GetBeforeStart: Boolean;
   {$If Defined(evUseVisibleCursors)}
   procedure DoSignalScroll; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   {$If Defined(evUseVisibleCursors)}
   procedure DoLockScroll; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   {$If Defined(evUseVisibleCursors)}
   procedure DoUnlockScroll; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
  public
   class function Make(aTag: Tl3Variant): InevAnchor; reintroduce;
   procedure AssignPoint(const aView: InevView;
    const aPoint: InevBasePoint);
   procedure DisableListener;
    {* Отключает нотификацию об изменении }
   procedure EnableListener;
    {* Включает нотификацию об изменении }
   procedure CorrectMoveRight(const aView: InevView;
    const aPoint: InevBasePoint;
    const anOp: InevOp);
  protected
   property HasInner: Boolean
    read pm_GetHasInner;
 end;//TnevAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , afwInterfaces
 , k2Tags
 , SysUtils
;

type _Instance_R_ = TnevAnchor;

{$Include w:\common\components\gui\Garant\Everest\new\nevAnchor.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevAnchorModify.imp.pas}

function TnevAnchor.pm_GetHasInner: Boolean;
//#UC START# *4A58BA550111_49DE393900D3get_var*
//#UC END# *4A58BA550111_49DE393900D3get_var*
begin
//#UC START# *4A58BA550111_49DE393900D3get_impl*
 Result := false;
//#UC END# *4A58BA550111_49DE393900D3get_impl*
end;//TnevAnchor.pm_GetHasInner

class function TnevAnchor.Make(aTag: Tl3Variant): InevAnchor;
var
 l_Inst : TnevAnchor;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevAnchor.Make

function TnevAnchor.GetAsLeaf: InevLeafPoint;
//#UC START# *4A3B7E35010E_49DE393900D3_var*
//#UC END# *4A3B7E35010E_49DE393900D3_var*
begin
//#UC START# *4A3B7E35010E_49DE393900D3_impl*
 Result := nil;
//#UC END# *4A3B7E35010E_49DE393900D3_impl*
end;//TnevAnchor.GetAsLeaf

function TnevAnchor.GetPosition: TnevPosition;
//#UC START# *4A3B7E540378_49DE393900D3_var*
//#UC END# *4A3B7E540378_49DE393900D3_var*
begin
//#UC START# *4A3B7E540378_49DE393900D3_impl*
 Result := VertPosition(nil, nil);
//#UC END# *4A3B7E540378_49DE393900D3_impl*
end;//TnevAnchor.GetPosition

function TnevAnchor.GetInner: InevBasePoint;
//#UC START# *4A3B826402B8_49DE393900D3_var*
//#UC END# *4A3B826402B8_49DE393900D3_var*
begin
//#UC START# *4A3B826402B8_49DE393900D3_impl*
 Result := nil;
//#UC END# *4A3B826402B8_49DE393900D3_impl*
end;//TnevAnchor.GetInner

procedure TnevAnchor.SetInner(const aValue: InevBasePoint);
//#UC START# *4A3B82710255_49DE393900D3_var*
//#UC END# *4A3B82710255_49DE393900D3_var*
begin
//#UC START# *4A3B82710255_49DE393900D3_impl*
 Assert(aValue <> nil);
//#UC END# *4A3B82710255_49DE393900D3_impl*
end;//TnevAnchor.SetInner

function TnevAnchor.GetInnerFor(const aChild: InevObject;
 var aRealTop: InevBasePoint): InevBasePoint;
//#UC START# *4A3B848302A5_49DE393900D3_var*
//#UC END# *4A3B848302A5_49DE393900D3_var*
begin
//#UC START# *4A3B848302A5_49DE393900D3_impl*
 aRealTop := nil;
 Result := GetInner;
 if (Result <> nil) AND not Result.AsObject.IsSame(aChild.AsObject) then
  Result := nil;
//#UC END# *4A3B848302A5_49DE393900D3_impl*
end;//TnevAnchor.GetInnerFor

function TnevAnchor.DoHasBaseLine: Boolean;
//#UC START# *4AA777B603B6_49DE393900D3_var*
//#UC END# *4AA777B603B6_49DE393900D3_var*
begin
//#UC START# *4AA777B603B6_49DE393900D3_impl*
 Result := False;
//#UC END# *4AA777B603B6_49DE393900D3_impl*
end;//TnevAnchor.DoHasBaseLine

function TnevAnchor.DoGetInnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
 aForDrawing: TnevInnerType): InevBasePoint;
//#UC START# *4AA7797701F5_49DE393900D3_var*
//#UC END# *4AA7797701F5_49DE393900D3_var*
begin
//#UC START# *4AA7797701F5_49DE393900D3_impl*
 Result := nil
//#UC END# *4AA7797701F5_49DE393900D3_impl*
end;//TnevAnchor.DoGetInnerForChildThatNotAfterEnd

function TnevAnchor.GetInnerTop(const aChild: InevObject): InevBasePoint;
//#UC START# *4AEC34960358_49DE393900D3_var*
//#UC END# *4AEC34960358_49DE393900D3_var*
begin
//#UC START# *4AEC34960358_49DE393900D3_impl*
 Result := nil;
//#UC END# *4AEC34960358_49DE393900D3_impl*
end;//TnevAnchor.GetInnerTop

procedure TnevAnchor.DoAssignPoint(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *4B1D0220010E_49DE393900D3_var*
//#UC END# *4B1D0220010E_49DE393900D3_var*
begin
//#UC START# *4B1D0220010E_49DE393900D3_impl*
 if (aPoint <> nil) then
 begin
  if (f_ParaX = nil) then
   f_ParaX := aPoint.Obj.AsPara
  else 
(*  if (f_Para.Shape.View = nil) AND (aPoint.Obj.Shape.View <> nil) then
   f_Para := aPoint.Obj.AsPara*);
 end;//aPoint <> nil
//#UC END# *4B1D0220010E_49DE393900D3_impl*
end;//TnevAnchor.DoAssignPoint

procedure TnevAnchor.DoAddInner(const aView: InevView;
 const anInner: InevBaseLine4Anchor;
 anIndex: Integer;
 var aFirst: Boolean;
 aMode: TnevAddInnerMode);
//#UC START# *4B90DBFE00EF_49DE393900D3_var*
//#UC END# *4B90DBFE00EF_49DE393900D3_var*
begin
//#UC START# *4B90DBFE00EF_49DE393900D3_impl*
 Assert(False)
//#UC END# *4B90DBFE00EF_49DE393900D3_impl*
end;//TnevAnchor.DoAddInner

procedure TnevAnchor.DoCompareWithOtherInner(const aView: InevView;
 anMaxID: Integer = -1);
//#UC START# *4B9625260325_49DE393900D3_var*
//#UC END# *4B9625260325_49DE393900D3_var*
begin
//#UC START# *4B9625260325_49DE393900D3_impl*
 Assert(False);
//#UC END# *4B9625260325_49DE393900D3_impl*
end;//TnevAnchor.DoCompareWithOtherInner

procedure TnevAnchor.DoInitByCursor(const aView: InevView;
 const anInnerPoint: InevBasePoint);
 {* Инициализируем базовую линию по курсору. }
//#UC START# *4C7361850250_49DE393900D3_var*
//#UC END# *4C7361850250_49DE393900D3_var*
begin
//#UC START# *4C7361850250_49DE393900D3_impl*
//#UC END# *4C7361850250_49DE393900D3_impl*
end;//TnevAnchor.DoInitByCursor

function TnevAnchor.Range: InevRange;
//#UC START# *47C5B55D00B4_49DE393900D3_var*
//#UC END# *47C5B55D00B4_49DE393900D3_var*
begin
//#UC START# *47C5B55D00B4_49DE393900D3_impl*
 Result := nil;
//#UC END# *47C5B55D00B4_49DE393900D3_impl*
end;//TnevAnchor.Range

function TnevAnchor.pm_GetFormatting: InevDataFormatting;
//#UC START# *47C5B603039F_49DE393900D3get_var*
//#UC END# *47C5B603039F_49DE393900D3get_var*
begin
//#UC START# *47C5B603039F_49DE393900D3get_impl*
 Result := Self.AsCursor(nil).Formatting;
 Assert(false);
//#UC END# *47C5B603039F_49DE393900D3get_impl*
end;//TnevAnchor.pm_GetFormatting

function TnevAnchor.VertPosition(const aView: InevView;
 aMap: TnevFormatInfoPrim): TnevParaIndex;
//#UC START# *47C5B65D0195_49DE393900D3_var*
//#UC END# *47C5B65D0195_49DE393900D3_var*
begin
//#UC START# *47C5B65D0195_49DE393900D3_impl*
 Result := GetVertPosition(aView, aMap);
//#UC END# *47C5B65D0195_49DE393900D3_impl*
end;//TnevAnchor.VertPosition

function TnevAnchor.NeedWindowsCaret: Boolean;
//#UC START# *47C5B6D30128_49DE393900D3_var*
//#UC END# *47C5B6D30128_49DE393900D3_var*
begin
//#UC START# *47C5B6D30128_49DE393900D3_impl*
 Result := false;
//#UC END# *47C5B6D30128_49DE393900D3_impl*
end;//TnevAnchor.NeedWindowsCaret

function TnevAnchor.ClonePoint(const aView: InevView): InevBasePoint;
//#UC START# *47C5B6E503C3_49DE393900D3_var*
//#UC END# *47C5B6E503C3_49DE393900D3_var*
begin
//#UC START# *47C5B6E503C3_49DE393900D3_impl*
 Result := ParaX.MakeAnchor;
 Result.AssignPoint(aView, InevAnchor(Self));
//#UC END# *47C5B6E503C3_49DE393900D3_impl*
end;//TnevAnchor.ClonePoint

function TnevAnchor.DeltaX(const aView: InevView;
 const aMap: InevMap): Integer;
//#UC START# *47C5B6F202A0_49DE393900D3_var*
//#UC END# *47C5B6F202A0_49DE393900D3_var*
begin
//#UC START# *47C5B6F202A0_49DE393900D3_impl*
 Result := 0;
//#UC END# *47C5B6F202A0_49DE393900D3_impl*
end;//TnevAnchor.DeltaX

function TnevAnchor.pm_GetInner: InevBasePoint;
//#UC START# *47C5B7400152_49DE393900D3get_var*
//#UC END# *47C5B7400152_49DE393900D3get_var*
begin
//#UC START# *47C5B7400152_49DE393900D3get_impl*
 Result := GetInner;
//#UC END# *47C5B7400152_49DE393900D3get_impl*
end;//TnevAnchor.pm_GetInner

procedure TnevAnchor.pm_SetInner(const aValue: InevBasePoint);
//#UC START# *47C5B7400152_49DE393900D3set_var*
//#UC END# *47C5B7400152_49DE393900D3set_var*
begin
//#UC START# *47C5B7400152_49DE393900D3set_impl*
 SetInner(aValue);
//#UC END# *47C5B7400152_49DE393900D3set_impl*
end;//TnevAnchor.pm_SetInner

function TnevAnchor.Get_Position: TnevPosition;
//#UC START# *47C5B75F00AF_49DE393900D3get_var*
//#UC END# *47C5B75F00AF_49DE393900D3get_var*
begin
//#UC START# *47C5B75F00AF_49DE393900D3get_impl*
 Result := GetPosition;
//#UC END# *47C5B75F00AF_49DE393900D3get_impl*
end;//TnevAnchor.Get_Position

function TnevAnchor.LinkListener(const aView: InevScrollListener): InevScrollListener;
//#UC START# *47C5C20D00DB_49DE393900D3_var*
//#UC END# *47C5C20D00DB_49DE393900D3_var*
begin
//#UC START# *47C5C20D00DB_49DE393900D3_impl*
 Result := IafwScrollListener(f_View);
 if (f_View <> Pointer(aView)) then
 begin
  f_View := Pointer(aView);
  SignalScroll;
 end;//f_View <> Pointer(aView);
//#UC END# *47C5C20D00DB_49DE393900D3_impl*
end;//TnevAnchor.LinkListener

procedure TnevAnchor.UnlinkListener(const aControl: InevScrollListener);
//#UC START# *47C5C21C03D8_49DE393900D3_var*
//#UC END# *47C5C21C03D8_49DE393900D3_var*
begin
//#UC START# *47C5C21C03D8_49DE393900D3_impl*
 if (f_View = Pointer(aControl)) then
  f_View := nil;
//#UC END# *47C5C21C03D8_49DE393900D3_impl*
end;//TnevAnchor.UnlinkListener

procedure TnevAnchor.AssignPoint(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *47C5C25C022F_49DE393900D3_var*
//#UC END# *47C5C25C022F_49DE393900D3_var*
begin
//#UC START# *47C5C25C022F_49DE393900D3_impl*
 LockScroll;
 try
  DoAssignPoint(aView, aPoint);
 finally
  UnlockScroll;
 end;//try..finally
//#UC END# *47C5C25C022F_49DE393900D3_impl*
end;//TnevAnchor.AssignPoint

function TnevAnchor.InnerFor(const aChild: InevObject;
 var aRealTop: InevBasePoint): InevBasePoint;
//#UC START# *47F5FDA303BC_49DE393900D3_var*
//#UC END# *47F5FDA303BC_49DE393900D3_var*
begin
//#UC START# *47F5FDA303BC_49DE393900D3_impl*
 Result := GetInnerFor(aChild, aRealTop);
//#UC END# *47F5FDA303BC_49DE393900D3_impl*
end;//TnevAnchor.InnerFor

function TnevAnchor.pm_GetAfterEnd: Boolean;
//#UC START# *47F618A90162_49DE393900D3get_var*
//#UC END# *47F618A90162_49DE393900D3get_var*
begin
//#UC START# *47F618A90162_49DE393900D3get_impl*
 Result := false;
//#UC END# *47F618A90162_49DE393900D3get_impl*
end;//TnevAnchor.pm_GetAfterEnd

function TnevAnchor.Get_AsLeaf: InevLeafPoint;
//#UC START# *47FB32280262_49DE393900D3get_var*
//#UC END# *47FB32280262_49DE393900D3get_var*
begin
//#UC START# *47FB32280262_49DE393900D3get_impl*
 Result := GetAsLeaf;
//#UC END# *47FB32280262_49DE393900D3get_impl*
end;//TnevAnchor.Get_AsLeaf

function TnevAnchor.AtEnd(const aView: InevView): Boolean;
//#UC START# *47FF3F1800FE_49DE393900D3_var*
var
 l_CA : InevBasePoint;
//#UC END# *47FF3F1800FE_49DE393900D3_var*
begin
//#UC START# *47FF3F1800FE_49DE393900D3_impl*
 if GetRedirect.BoolA[k2_tiCollapsed] then
  Result := True
 else
 begin
  Result := GetAtEnd(aView);
  if Result then
  begin
   l_CA := Self.GetInner;
   if (l_CA <> nil) AND l_CA.AsObject.IsValid AND not l_CA.AtEnd(aView) then
    Result := False;
  end;//Result
 end;//GetRedirect.BoolA[k2_tiCollapsed]
//#UC END# *47FF3F1800FE_49DE393900D3_impl*
end;//TnevAnchor.AtEnd

function TnevAnchor.AtStart: Boolean;
//#UC START# *47FF414E039D_49DE393900D3_var*
var
 l_CA : InevBasePoint;
//#UC END# *47FF414E039D_49DE393900D3_var*
begin
//#UC START# *47FF414E039D_49DE393900D3_impl*
 Result := GetAtStart;
 if Result then
 begin
  l_CA := Self.GetInner;
  if (l_CA <> nil) AND l_CA.AsObject.IsValid AND not l_CA.AtStart then
   Result := False;
 end;//Result
//#UC END# *47FF414E039D_49DE393900D3_impl*
end;//TnevAnchor.AtStart

function TnevAnchor.pm_GetText: InevText;
//#UC START# *49E6FB10002A_49DE393900D3get_var*
//#UC END# *49E6FB10002A_49DE393900D3get_var*
begin
//#UC START# *49E6FB10002A_49DE393900D3get_impl*
 Result := Self.AsCursor(nil).Text;
 Assert(false);
//#UC END# *49E6FB10002A_49DE393900D3get_impl*
end;//TnevAnchor.pm_GetText

procedure TnevAnchor.DisableListener;
 {* Отключает нотификацию об изменении }
//#UC START# *4A4C856300DF_49DE393900D3_var*
//#UC END# *4A4C856300DF_49DE393900D3_var*
begin
//#UC START# *4A4C856300DF_49DE393900D3_impl*
//#UC END# *4A4C856300DF_49DE393900D3_impl*
end;//TnevAnchor.DisableListener

procedure TnevAnchor.EnableListener;
 {* Включает нотификацию об изменении }
//#UC START# *4A4C8581014B_49DE393900D3_var*
//#UC END# *4A4C8581014B_49DE393900D3_var*
begin
//#UC START# *4A4C8581014B_49DE393900D3_impl*
//#UC END# *4A4C8581014B_49DE393900D3_impl*
end;//TnevAnchor.EnableListener

function TnevAnchor.Get_HasInner: Boolean;
//#UC START# *4A58B79A0360_49DE393900D3get_var*
//#UC END# *4A58B79A0360_49DE393900D3get_var*
begin
//#UC START# *4A58B79A0360_49DE393900D3get_impl*
 Result := HasInner;
//#UC END# *4A58B79A0360_49DE393900D3get_impl*
end;//TnevAnchor.Get_HasInner

function TnevAnchor.Get_ShowCollapsed: Boolean;
//#UC START# *4A5B48A701A9_49DE393900D3get_var*
//#UC END# *4A5B48A701A9_49DE393900D3get_var*
begin
//#UC START# *4A5B48A701A9_49DE393900D3get_impl*
 Result := true;
//#UC END# *4A5B48A701A9_49DE393900D3get_impl*
end;//TnevAnchor.Get_ShowCollapsed

procedure TnevAnchor.Set_ShowCollapsed(aValue: Boolean);
//#UC START# *4A5B48A701A9_49DE393900D3set_var*
//#UC END# *4A5B48A701A9_49DE393900D3set_var*
begin
//#UC START# *4A5B48A701A9_49DE393900D3set_impl*
 Assert(aValue)
//#UC END# *4A5B48A701A9_49DE393900D3set_impl*
end;//TnevAnchor.Set_ShowCollapsed

function TnevAnchor.Compare(const aPoint: InevBasePoint): Integer;
//#UC START# *4A5B60870158_49DE393900D3_var*
//#UC END# *4A5B60870158_49DE393900D3_var*
begin
//#UC START# *4A5B60870158_49DE393900D3_impl*
 // !!! Cut'n'Paste из курсоров. По уму - надо бы в примесь выделить.
 if (aPoint = nil) then
  Result := 1
 else
 if not aPoint.Obj.AsObject.IsSame(ParaX.AsObject) then
  Result := 1
 else
  Result := (GetPosition - aPoint.Position);
 if (Result = 0) then
 begin
  if Self.HasInner then
  begin
   // далее я правил, когда разбирался с изменением границы блока, но потом в этих изменениях
   // отпала необходимость, так что если из за них вылезут какие-то болты, то можно поправить обратно
   if not aPoint.HasInner then
    Result := +1
   else
    Result := Self.GetInner.Compare(aPoint.Inner);
  end//Self.HasInner
  else
  if aPoint.HasInner then
   Result := -1;
 end;//Result = 0
//#UC END# *4A5B60870158_49DE393900D3_impl*
end;//TnevAnchor.Compare

procedure TnevAnchor.CheckPos(const anOp: InevOp);
 {* Избавляемся от рассинхронизации позиции курсора и дочернего параграфа. Заплатка конечно }
//#UC START# *4A5B6D370262_49DE393900D3_var*
//#UC END# *4A5B6D370262_49DE393900D3_var*
begin
//#UC START# *4A5B6D370262_49DE393900D3_impl*
 Assert(false);
//#UC END# *4A5B6D370262_49DE393900D3_impl*
end;//TnevAnchor.CheckPos

function TnevAnchor.ReadOnly: Boolean;
//#UC START# *4A5C66200185_49DE393900D3_var*
//#UC END# *4A5C66200185_49DE393900D3_var*
begin
//#UC START# *4A5C66200185_49DE393900D3_impl*
 Result := true;
//#UC END# *4A5C66200185_49DE393900D3_impl*
end;//TnevAnchor.ReadOnly

function TnevAnchor.AsPoint: InevBasePoint;
//#UC START# *4A5C6DB4014D_49DE393900D3_var*
//#UC END# *4A5C6DB4014D_49DE393900D3_var*
begin
//#UC START# *4A5C6DB4014D_49DE393900D3_impl*
 Result := Self;
//#UC END# *4A5C6DB4014D_49DE393900D3_impl*
end;//TnevAnchor.AsPoint

function TnevAnchor.AsCursor(const aView: InevView): InevPoint;
//#UC START# *4A5C750E01F7_49DE393900D3_var*
//#UC END# *4A5C750E01F7_49DE393900D3_var*
begin
//#UC START# *4A5C750E01F7_49DE393900D3_impl*
 Result := ParaX.MakePoint;
 Result.AssignPoint(aView, Self);
//#UC END# *4A5C750E01F7_49DE393900D3_impl*
end;//TnevAnchor.AsCursor

{$If Defined(evNeedMarkers)}
function TnevAnchor.Get_MarkersSource: IevMarkersSource;
//#UC START# *4A5C7D2F0079_49DE393900D3get_var*
//#UC END# *4A5C7D2F0079_49DE393900D3get_var*
begin
//#UC START# *4A5C7D2F0079_49DE393900D3get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4A5C7D2F0079_49DE393900D3get_impl*
end;//TnevAnchor.Get_MarkersSource
{$IfEnd} // Defined(evNeedMarkers)

function TnevAnchor.ProcessMessage(const aView: InevControlView;
 var aMessage: TMessage;
 aTime: Cardinal): Boolean;
//#UC START# *4A5C8A9D0324_49DE393900D3_var*
//#UC END# *4A5C8A9D0324_49DE393900D3_var*
begin
//#UC START# *4A5C8A9D0324_49DE393900D3_impl*
 Result := false;
 Assert(false);
//#UC END# *4A5C8A9D0324_49DE393900D3_impl*
end;//TnevAnchor.ProcessMessage

function TnevAnchor.Get_Listener: InevPointListener;
//#UC START# *4A5C9138035D_49DE393900D3get_var*
//#UC END# *4A5C9138035D_49DE393900D3get_var*
begin
//#UC START# *4A5C9138035D_49DE393900D3get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4A5C9138035D_49DE393900D3get_impl*
end;//TnevAnchor.Get_Listener

function TnevAnchor.GetBlockLength: Integer;
//#UC START# *4A5C913F0235_49DE393900D3_var*
//#UC END# *4A5C913F0235_49DE393900D3_var*
begin
//#UC START# *4A5C913F0235_49DE393900D3_impl*
 Result := 0;
 Assert(false);
//#UC END# *4A5C913F0235_49DE393900D3_impl*
end;//TnevAnchor.GetBlockLength

procedure TnevAnchor.MergeTo(const aView: InevView;
 const aBaseLine: InevBasePoint);
 {* Объединяем значения отрисованных частей. }
//#UC START# *4A810F81018E_49DE393900D3_var*
//#UC END# *4A810F81018E_49DE393900D3_var*
begin
//#UC START# *4A810F81018E_49DE393900D3_impl*
 Assert(False);
//#UC END# *4A810F81018E_49DE393900D3_impl*
end;//TnevAnchor.MergeTo

function TnevAnchor.InnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
 aForDrawing: TnevInnerType): InevBasePoint;
 {* Получаем первый параграф, по которому можно получить вложенную точку. }
//#UC START# *4AA76AE00147_49DE393900D3_var*
//#UC END# *4AA76AE00147_49DE393900D3_var*
begin
//#UC START# *4AA76AE00147_49DE393900D3_impl*
 Result := DoGetInnerForChildThatNotAfterEnd(aFI, aForDrawing);
//#UC END# *4AA76AE00147_49DE393900D3_impl*
end;//TnevAnchor.InnerForChildThatNotAfterEnd

function TnevAnchor.HasBaseLine: Boolean;
 {* Проверяет есть ли возможность работы с базовой линией на точке }
//#UC START# *4AA76AF90174_49DE393900D3_var*
//#UC END# *4AA76AF90174_49DE393900D3_var*
begin
//#UC START# *4AA76AF90174_49DE393900D3_impl*
 Result := DoHasBaseLine;
//#UC END# *4AA76AF90174_49DE393900D3_impl*
end;//TnevAnchor.HasBaseLine

procedure TnevAnchor.AddInner(const aView: InevView;
 const anInner: InevBaseLine4Anchor;
 anIndex: Integer;
 var aFirst: Boolean;
 aMode: TnevAddInnerMode);
//#UC START# *4B90DA600047_49DE393900D3_var*
//#UC END# *4B90DA600047_49DE393900D3_var*
begin
//#UC START# *4B90DA600047_49DE393900D3_impl*
 DoAddInner(aView, anInner, anIndex, aFirst, aMode)
//#UC END# *4B90DA600047_49DE393900D3_impl*
end;//TnevAnchor.AddInner

procedure TnevAnchor.CompareWithOtherInner(const aView: InevView;
 anMaxID: Integer = -1);
 {* После применения AnchorByPoint могут остаться "неинициализированные" (будут указывать на начало ячейки) дочерние точки в базовой линии. }
//#UC START# *4B9623150178_49DE393900D3_var*
//#UC END# *4B9623150178_49DE393900D3_var*
begin
//#UC START# *4B9623150178_49DE393900D3_impl*
 DoCompareWithOtherInner(aView, anMaxID);
//#UC END# *4B9623150178_49DE393900D3_impl*
end;//TnevAnchor.CompareWithOtherInner

function TnevAnchor.InnerHead(aPID: Integer): InevBasePoint;
 {* Аналог InnerFor, но для частей объдеиненных ячеек, попадающих на данную строку (пока используется только для печати). }
//#UC START# *4C456C8E027F_49DE393900D3_var*
//#UC END# *4C456C8E027F_49DE393900D3_var*
begin
//#UC START# *4C456C8E027F_49DE393900D3_impl*
 Result := nil;
//#UC END# *4C456C8E027F_49DE393900D3_impl*
end;//TnevAnchor.InnerHead

function TnevAnchor.HasHeadPart: Boolean;
 {* Строка содержит продолжение объединенных ячеек. }
//#UC START# *4C456CEA01DE_49DE393900D3_var*
//#UC END# *4C456CEA01DE_49DE393900D3_var*
begin
//#UC START# *4C456CEA01DE_49DE393900D3_impl*
 Result := False;
//#UC END# *4C456CEA01DE_49DE393900D3_impl*
end;//TnevAnchor.HasHeadPart

procedure TnevAnchor.AddHeadInner(const aHeadInner: InevBasePoint);
 {* Служит для добавления в базовую линию продолжений объединенных ячеек (используется только для печати). }
//#UC START# *4C456D220317_49DE393900D3_var*
//#UC END# *4C456D220317_49DE393900D3_var*
begin
//#UC START# *4C456D220317_49DE393900D3_impl*
//#UC END# *4C456D220317_49DE393900D3_impl*
end;//TnevAnchor.AddHeadInner

procedure TnevAnchor.CopyHeadParts(const aFrom: InevBasePoint);
 {* Копирует только части продолжений ячеек, если они есть. }
//#UC START# *4C457D0502E1_49DE393900D3_var*
//#UC END# *4C457D0502E1_49DE393900D3_var*
begin
//#UC START# *4C457D0502E1_49DE393900D3_impl*
//#UC END# *4C457D0502E1_49DE393900D3_impl*
end;//TnevAnchor.CopyHeadParts

procedure TnevAnchor.InitByCursor(const aView: InevView;
 const anInnerPoint: InevBasePoint);
 {* Инициализируем базовую линию по курсору. }
//#UC START# *4C735E600112_49DE393900D3_var*
//#UC END# *4C735E600112_49DE393900D3_var*
begin
//#UC START# *4C735E600112_49DE393900D3_impl*
 DoInitByCursor(aView, anInnerPoint);
//#UC END# *4C735E600112_49DE393900D3_impl*
end;//TnevAnchor.InitByCursor

procedure TnevAnchor.InitBaseLineInner(const aView: InevView;
 const anItem: InevPara);
//#UC START# *4D9C113C0320_49DE393900D3_var*
//#UC END# *4D9C113C0320_49DE393900D3_var*
begin
//#UC START# *4D9C113C0320_49DE393900D3_impl*
 Assert(False);
//#UC END# *4D9C113C0320_49DE393900D3_impl*
end;//TnevAnchor.InitBaseLineInner

function TnevAnchor.InnerTop(const aChild: InevObject): InevBasePoint;
 {* Возвращает указатель на первоначальную позицию для точки. Для обычных точек - всегда nil. }
//#UC START# *4DDCD59301D5_49DE393900D3_var*
//#UC END# *4DDCD59301D5_49DE393900D3_var*
begin
//#UC START# *4DDCD59301D5_49DE393900D3_impl*
 Result := GetInnerTop(aChild);
//#UC END# *4DDCD59301D5_49DE393900D3_impl*
end;//TnevAnchor.InnerTop

function TnevAnchor.pm_GetBeforeStart: Boolean;
//#UC START# *4EC3B0330271_49DE393900D3get_var*
//#UC END# *4EC3B0330271_49DE393900D3get_var*
begin
//#UC START# *4EC3B0330271_49DE393900D3get_impl*
 Result := False;
//#UC END# *4EC3B0330271_49DE393900D3get_impl*
end;//TnevAnchor.pm_GetBeforeStart

procedure TnevAnchor.CorrectMoveRight(const aView: InevView;
 const aPoint: InevBasePoint;
 const anOp: InevOp);
//#UC START# *50DAA7010050_49DE393900D3_var*
//#UC END# *50DAA7010050_49DE393900D3_var*
begin
//#UC START# *50DAA7010050_49DE393900D3_impl*
 Assert(False);
//#UC END# *50DAA7010050_49DE393900D3_impl*
end;//TnevAnchor.CorrectMoveRight

{$If Defined(evUseVisibleCursors)}
procedure TnevAnchor.DoSignalScroll;
//#UC START# *4B1D08980098_49DE393900D3_var*
//#UC END# *4B1D08980098_49DE393900D3_var*
begin
//#UC START# *4B1D08980098_49DE393900D3_impl*
 if (f_View = nil) then
  f_NeedSignal := false
 else
 begin
  if (f_LockScroll = 0) then
  begin
   f_NeedSignal := false;
   IafwScrollListener(f_View).Signal;
  end//f_LockScroll = 0
  else
   f_NeedSignal := True; 
 end;//f_View <> nil
//#UC END# *4B1D08980098_49DE393900D3_impl*
end;//TnevAnchor.DoSignalScroll
{$IfEnd} // Defined(evUseVisibleCursors)

{$If Defined(evUseVisibleCursors)}
procedure TnevAnchor.DoLockScroll;
//#UC START# *4B1D08AA027C_49DE393900D3_var*
//#UC END# *4B1D08AA027C_49DE393900D3_var*
begin
//#UC START# *4B1D08AA027C_49DE393900D3_impl*
 Inc(f_LockScroll);
//#UC END# *4B1D08AA027C_49DE393900D3_impl*
end;//TnevAnchor.DoLockScroll
{$IfEnd} // Defined(evUseVisibleCursors)

{$If Defined(evUseVisibleCursors)}
procedure TnevAnchor.DoUnlockScroll;
//#UC START# *4B1D08E001CF_49DE393900D3_var*
//#UC END# *4B1D08E001CF_49DE393900D3_var*
begin
//#UC START# *4B1D08E001CF_49DE393900D3_impl*
 Dec(f_LockScroll);
 if f_NeedSignal then
  SignalScroll;
//#UC END# *4B1D08E001CF_49DE393900D3_impl*
end;//TnevAnchor.DoUnlockScroll
{$IfEnd} // Defined(evUseVisibleCursors)

{$IfEnd} // Defined(k2ForEditor)
end.
