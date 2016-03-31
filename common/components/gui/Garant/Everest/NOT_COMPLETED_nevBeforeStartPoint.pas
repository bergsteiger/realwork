unit NOT_COMPLETED_nevBeforeStartPoint;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_nevBeforeStartPoint.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevBeforeStartPoint" MUID: (4EC3AD980264)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , nevTools
 , nevBase
 , l3Core
 , k2TagPointer
 , l3Variant
 , k2Base
;

type
 {$Include w:\common\components\gui\Garant\Everest\nevPrimPoint.imp.pas}
 TnevBeforeStartPoint = class(_nevPrimPoint_, InevPoint, InevBasePoint)
  protected
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
   function InnerFor(const aChild: InevObject;
    var aRealTop: InevBasePoint): InevBasePoint;
   function pm_GetAfterEnd: Boolean;
   function Get_AsLeaf: InevLeafPoint;
   function Get_LinkedPoint: InevLinkedPoint;
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
   function GetViewBounds(const aView: InevView;
    const aMap: InevMap): TnevRect; override;
  public
   constructor Create(const aPoint: InevBasePoint); reintroduce;
   class function Make(const aView: InevView;
    const aPoint: InevBasePoint): InevBasePoint;
   class function DoMake(const aPoint: InevBasePoint): InevPoint; reintroduce;
   procedure AssignPoint(const aView: InevView;
    const aPoint: InevBasePoint);
   procedure Bottom(const aView: InevView);
   function IncLine(const aView: InevView;
    var theLine: Integer;
    aByLine: Boolean): Integer;
    {* сдвигает якорь на указанное число строк. Возвращает количество параграфов на которое сдвинулся якорь. }
   function Diff(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Integer;
    {* сравнивает курсор с "якорем" по вертикали. }
   procedure DisableListener;
    {* Отключает нотификацию об изменении }
   procedure EnableListener;
    {* Включает нотификацию об изменении }
   function PartiallyVisible(const aView: InevView;
    const aPoint: InevBasePoint;
    const aMap: TnevFormatInfoPrim): Boolean;
    {* Определяет может ли точка "частично видимой" относительно другой точки (aPoint). Сделано для определения видимости начальной ячейки относительно якоря. }
   procedure CorrectMoveRight(const aView: InevView;
    const aPoint: InevBasePoint;
    const anOp: InevOp);
 end;//TnevBeforeStartPoint
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , SysUtils
;

type _Instance_R_ = TnevBeforeStartPoint;

{$Include w:\common\components\gui\Garant\Everest\nevPrimPoint.imp.pas}

constructor TnevBeforeStartPoint.Create(const aPoint: InevBasePoint);
//#UC START# *4EC3AE6D0321_4EC3AD980264_var*
//#UC END# *4EC3AE6D0321_4EC3AD980264_var*
begin
//#UC START# *4EC3AE6D0321_4EC3AD980264_impl*
 inherited Create(aPoint.Obj^.AsObject);
//#UC END# *4EC3AE6D0321_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.Create

class function TnevBeforeStartPoint.Make(const aView: InevView;
 const aPoint: InevBasePoint): InevBasePoint;
//#UC START# *4EC3AEA1001B_4EC3AD980264_var*
//#UC END# *4EC3AEA1001B_4EC3AD980264_var*
begin
//#UC START# *4EC3AEA1001B_4EC3AD980264_impl*
 Result := DoMake(aPoint);
//#UC END# *4EC3AEA1001B_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.Make

class function TnevBeforeStartPoint.DoMake(const aPoint: InevBasePoint): InevPoint;
var
 l_Inst : TnevBeforeStartPoint;
begin
 l_Inst := Create(aPoint);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevBeforeStartPoint.DoMake

function TnevBeforeStartPoint.Range: InevRange;
//#UC START# *47C5B55D00B4_4EC3AD980264_var*
//#UC END# *47C5B55D00B4_4EC3AD980264_var*
begin
//#UC START# *47C5B55D00B4_4EC3AD980264_impl*
 Result := nil;
 Assert(False);
//#UC END# *47C5B55D00B4_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.Range

function TnevBeforeStartPoint.pm_GetFormatting: InevDataFormatting;
//#UC START# *47C5B603039F_4EC3AD980264get_var*
//#UC END# *47C5B603039F_4EC3AD980264get_var*
begin
//#UC START# *47C5B603039F_4EC3AD980264get_impl*
 Result := nil;
 Assert(false);
//#UC END# *47C5B603039F_4EC3AD980264get_impl*
end;//TnevBeforeStartPoint.pm_GetFormatting

function TnevBeforeStartPoint.VertPosition(const aView: InevView;
 aMap: TnevFormatInfoPrim): TnevParaIndex;
//#UC START# *47C5B65D0195_4EC3AD980264_var*
//#UC END# *47C5B65D0195_4EC3AD980264_var*
begin
//#UC START# *47C5B65D0195_4EC3AD980264_impl*
 Result := -1;
//#UC END# *47C5B65D0195_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.VertPosition

function TnevBeforeStartPoint.NeedWindowsCaret: Boolean;
//#UC START# *47C5B6D30128_4EC3AD980264_var*
//#UC END# *47C5B6D30128_4EC3AD980264_var*
begin
//#UC START# *47C5B6D30128_4EC3AD980264_impl*
 Result := true;
 //Assert(false);
//#UC END# *47C5B6D30128_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.NeedWindowsCaret

function TnevBeforeStartPoint.ClonePoint(const aView: InevView): InevBasePoint;
//#UC START# *47C5B6E503C3_4EC3AD980264_var*
//#UC END# *47C5B6E503C3_4EC3AD980264_var*
begin
//#UC START# *47C5B6E503C3_4EC3AD980264_impl*
 Result := TnevBeforeStartPoint.DoMake(ParaX.MakePoint);
//#UC END# *47C5B6E503C3_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.ClonePoint

function TnevBeforeStartPoint.DeltaX(const aView: InevView;
 const aMap: InevMap): Integer;
//#UC START# *47C5B6F202A0_4EC3AD980264_var*
//#UC END# *47C5B6F202A0_4EC3AD980264_var*
begin
//#UC START# *47C5B6F202A0_4EC3AD980264_impl*
 Result := 0;
 Assert(false);
//#UC END# *47C5B6F202A0_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.DeltaX

function TnevBeforeStartPoint.pm_GetInner: InevBasePoint;
//#UC START# *47C5B7400152_4EC3AD980264get_var*
//#UC END# *47C5B7400152_4EC3AD980264get_var*
begin
//#UC START# *47C5B7400152_4EC3AD980264get_impl*
 Result := nil;
 //Assert(false);
//#UC END# *47C5B7400152_4EC3AD980264get_impl*
end;//TnevBeforeStartPoint.pm_GetInner

procedure TnevBeforeStartPoint.pm_SetInner(const aValue: InevBasePoint);
//#UC START# *47C5B7400152_4EC3AD980264set_var*
//#UC END# *47C5B7400152_4EC3AD980264set_var*
begin
//#UC START# *47C5B7400152_4EC3AD980264set_impl*
 Assert(false);
//#UC END# *47C5B7400152_4EC3AD980264set_impl*
end;//TnevBeforeStartPoint.pm_SetInner

function TnevBeforeStartPoint.Get_Position: TnevPosition;
//#UC START# *47C5B75F00AF_4EC3AD980264get_var*
//#UC END# *47C5B75F00AF_4EC3AD980264get_var*
begin
//#UC START# *47C5B75F00AF_4EC3AD980264get_impl*
 Result := -1;
//#UC END# *47C5B75F00AF_4EC3AD980264get_impl*
end;//TnevBeforeStartPoint.Get_Position

procedure TnevBeforeStartPoint.AssignPoint(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *47C5C25C022F_4EC3AD980264_var*
//#UC END# *47C5C25C022F_4EC3AD980264_var*
begin
//#UC START# *47C5C25C022F_4EC3AD980264_impl*
 Assert(false);
//#UC END# *47C5C25C022F_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.AssignPoint

procedure TnevBeforeStartPoint.Bottom(const aView: InevView);
//#UC START# *47C5C2970095_4EC3AD980264_var*
//#UC END# *47C5C2970095_4EC3AD980264_var*
begin
//#UC START# *47C5C2970095_4EC3AD980264_impl*
 Assert(false);
//#UC END# *47C5C2970095_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.Bottom

function TnevBeforeStartPoint.IncLine(const aView: InevView;
 var theLine: Integer;
 aByLine: Boolean): Integer;
 {* сдвигает якорь на указанное число строк. Возвращает количество параграфов на которое сдвинулся якорь. }
//#UC START# *47C5C2A40309_4EC3AD980264_var*
//#UC END# *47C5C2A40309_4EC3AD980264_var*
begin
//#UC START# *47C5C2A40309_4EC3AD980264_impl*
 Assert(false);
 Result := 0;
//#UC END# *47C5C2A40309_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.IncLine

function TnevBeforeStartPoint.InnerFor(const aChild: InevObject;
 var aRealTop: InevBasePoint): InevBasePoint;
//#UC START# *47F5FDA303BC_4EC3AD980264_var*
//#UC END# *47F5FDA303BC_4EC3AD980264_var*
begin
//#UC START# *47F5FDA303BC_4EC3AD980264_impl*
 Result := nil;
 Assert(false);
//#UC END# *47F5FDA303BC_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.InnerFor

function TnevBeforeStartPoint.pm_GetAfterEnd: Boolean;
//#UC START# *47F618A90162_4EC3AD980264get_var*
//#UC END# *47F618A90162_4EC3AD980264get_var*
begin
//#UC START# *47F618A90162_4EC3AD980264get_impl*
 Result := False;
//#UC END# *47F618A90162_4EC3AD980264get_impl*
end;//TnevBeforeStartPoint.pm_GetAfterEnd

function TnevBeforeStartPoint.Get_AsLeaf: InevLeafPoint;
//#UC START# *47FB32280262_4EC3AD980264get_var*
//#UC END# *47FB32280262_4EC3AD980264get_var*
begin
//#UC START# *47FB32280262_4EC3AD980264get_impl*
 Result := nil;
//#UC END# *47FB32280262_4EC3AD980264get_impl*
end;//TnevBeforeStartPoint.Get_AsLeaf

function TnevBeforeStartPoint.Get_LinkedPoint: InevLinkedPoint;
//#UC START# *47FCC68B03B1_4EC3AD980264get_var*
//#UC END# *47FCC68B03B1_4EC3AD980264get_var*
begin
//#UC START# *47FCC68B03B1_4EC3AD980264get_impl*
 Result := nil;
//#UC END# *47FCC68B03B1_4EC3AD980264get_impl*
end;//TnevBeforeStartPoint.Get_LinkedPoint

function TnevBeforeStartPoint.AtEnd(const aView: InevView): Boolean;
//#UC START# *47FF3F1800FE_4EC3AD980264_var*
//#UC END# *47FF3F1800FE_4EC3AD980264_var*
begin
//#UC START# *47FF3F1800FE_4EC3AD980264_impl*
  Result := False;
//#UC END# *47FF3F1800FE_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.AtEnd

function TnevBeforeStartPoint.AtStart: Boolean;
//#UC START# *47FF414E039D_4EC3AD980264_var*
//#UC END# *47FF414E039D_4EC3AD980264_var*
begin
//#UC START# *47FF414E039D_4EC3AD980264_impl*
  Result := true;
//#UC END# *47FF414E039D_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.AtStart

function TnevBeforeStartPoint.Diff(const aView: InevView;
 const aPoint: InevBasePoint;
 aMap: TnevFormatInfoPrim): Integer;
 {* сравнивает курсор с "якорем" по вертикали. }
//#UC START# *49DF51870234_4EC3AD980264_var*
//#UC END# *49DF51870234_4EC3AD980264_var*
begin
//#UC START# *49DF51870234_4EC3AD980264_impl*
 Assert(False);
//#UC END# *49DF51870234_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.Diff

function TnevBeforeStartPoint.pm_GetText: InevText;
//#UC START# *49E6FB10002A_4EC3AD980264get_var*
//#UC END# *49E6FB10002A_4EC3AD980264get_var*
begin
//#UC START# *49E6FB10002A_4EC3AD980264get_impl*
 Result := nil;
 Assert(false);
//#UC END# *49E6FB10002A_4EC3AD980264get_impl*
end;//TnevBeforeStartPoint.pm_GetText

procedure TnevBeforeStartPoint.DisableListener;
 {* Отключает нотификацию об изменении }
//#UC START# *4A4C856300DF_4EC3AD980264_var*
//#UC END# *4A4C856300DF_4EC3AD980264_var*
begin
//#UC START# *4A4C856300DF_4EC3AD980264_impl*
 Assert(false);
//#UC END# *4A4C856300DF_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.DisableListener

procedure TnevBeforeStartPoint.EnableListener;
 {* Включает нотификацию об изменении }
//#UC START# *4A4C8581014B_4EC3AD980264_var*
//#UC END# *4A4C8581014B_4EC3AD980264_var*
begin
//#UC START# *4A4C8581014B_4EC3AD980264_impl*
 Assert(false);
//#UC END# *4A4C8581014B_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.EnableListener

function TnevBeforeStartPoint.Get_HasInner: Boolean;
//#UC START# *4A58B79A0360_4EC3AD980264get_var*
//#UC END# *4A58B79A0360_4EC3AD980264get_var*
begin
//#UC START# *4A58B79A0360_4EC3AD980264get_impl*
 Result := false;
//#UC END# *4A58B79A0360_4EC3AD980264get_impl*
end;//TnevBeforeStartPoint.Get_HasInner

function TnevBeforeStartPoint.Get_ShowCollapsed: Boolean;
//#UC START# *4A5B48A701A9_4EC3AD980264get_var*
//#UC END# *4A5B48A701A9_4EC3AD980264get_var*
begin
//#UC START# *4A5B48A701A9_4EC3AD980264get_impl*
 Result := true;
//#UC END# *4A5B48A701A9_4EC3AD980264get_impl*
end;//TnevBeforeStartPoint.Get_ShowCollapsed

procedure TnevBeforeStartPoint.Set_ShowCollapsed(aValue: Boolean);
//#UC START# *4A5B48A701A9_4EC3AD980264set_var*
//#UC END# *4A5B48A701A9_4EC3AD980264set_var*
begin
//#UC START# *4A5B48A701A9_4EC3AD980264set_impl*
 Assert(aValue);
//#UC END# *4A5B48A701A9_4EC3AD980264set_impl*
end;//TnevBeforeStartPoint.Set_ShowCollapsed

function TnevBeforeStartPoint.Compare(const aPoint: InevBasePoint): Integer;
//#UC START# *4A5B60870158_4EC3AD980264_var*
//#UC END# *4A5B60870158_4EC3AD980264_var*
begin
//#UC START# *4A5B60870158_4EC3AD980264_impl*
 Result := -1;
 Assert(false);
//#UC END# *4A5B60870158_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.Compare

procedure TnevBeforeStartPoint.CheckPos(const anOp: InevOp);
 {* Избавляемся от рассинхронизации позиции курсора и дочернего параграфа. Заплатка конечно }
//#UC START# *4A5B6D370262_4EC3AD980264_var*
//#UC END# *4A5B6D370262_4EC3AD980264_var*
begin
//#UC START# *4A5B6D370262_4EC3AD980264_impl*
//#UC END# *4A5B6D370262_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.CheckPos

function TnevBeforeStartPoint.ReadOnly: Boolean;
//#UC START# *4A5C66200185_4EC3AD980264_var*
//#UC END# *4A5C66200185_4EC3AD980264_var*
begin
//#UC START# *4A5C66200185_4EC3AD980264_impl*
 Result := false;
 Assert(false);
//#UC END# *4A5C66200185_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.ReadOnly

function TnevBeforeStartPoint.AsPoint: InevBasePoint;
//#UC START# *4A5C6DB4014D_4EC3AD980264_var*
//#UC END# *4A5C6DB4014D_4EC3AD980264_var*
begin
//#UC START# *4A5C6DB4014D_4EC3AD980264_impl*
 Result := Self;
//#UC END# *4A5C6DB4014D_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.AsPoint

function TnevBeforeStartPoint.AsCursor(const aView: InevView): InevPoint;
//#UC START# *4A5C750E01F7_4EC3AD980264_var*
//#UC END# *4A5C750E01F7_4EC3AD980264_var*
begin
//#UC START# *4A5C750E01F7_4EC3AD980264_impl*
 Result := Self;
//#UC END# *4A5C750E01F7_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.AsCursor

{$If Defined(evNeedMarkers)}
function TnevBeforeStartPoint.Get_MarkersSource: IevMarkersSource;
//#UC START# *4A5C7D2F0079_4EC3AD980264get_var*
//#UC END# *4A5C7D2F0079_4EC3AD980264get_var*
begin
//#UC START# *4A5C7D2F0079_4EC3AD980264get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4A5C7D2F0079_4EC3AD980264get_impl*
end;//TnevBeforeStartPoint.Get_MarkersSource
{$IfEnd} // Defined(evNeedMarkers)

function TnevBeforeStartPoint.ProcessMessage(const aView: InevControlView;
 var aMessage: TMessage;
 aTime: Cardinal): Boolean;
//#UC START# *4A5C8A9D0324_4EC3AD980264_var*
//#UC END# *4A5C8A9D0324_4EC3AD980264_var*
begin
//#UC START# *4A5C8A9D0324_4EC3AD980264_impl*
 Result := false;
 Assert(false);
//#UC END# *4A5C8A9D0324_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.ProcessMessage

function TnevBeforeStartPoint.Get_Listener: InevPointListener;
//#UC START# *4A5C9138035D_4EC3AD980264get_var*
//#UC END# *4A5C9138035D_4EC3AD980264get_var*
begin
//#UC START# *4A5C9138035D_4EC3AD980264get_impl*
 Result := nil;
 // - не надо никому ни о чём сообщать
//#UC END# *4A5C9138035D_4EC3AD980264get_impl*
end;//TnevBeforeStartPoint.Get_Listener

function TnevBeforeStartPoint.GetBlockLength: Integer;
//#UC START# *4A5C913F0235_4EC3AD980264_var*
//#UC END# *4A5C913F0235_4EC3AD980264_var*
begin
//#UC START# *4A5C913F0235_4EC3AD980264_impl*
 Result := 0;
 Assert(false);
//#UC END# *4A5C913F0235_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.GetBlockLength

procedure TnevBeforeStartPoint.MergeTo(const aView: InevView;
 const aBaseLine: InevBasePoint);
 {* Объединяем значения отрисованных частей. }
//#UC START# *4A810F81018E_4EC3AD980264_var*
//#UC END# *4A810F81018E_4EC3AD980264_var*
begin
//#UC START# *4A810F81018E_4EC3AD980264_impl*
 Assert(False);
//#UC END# *4A810F81018E_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.MergeTo

function TnevBeforeStartPoint.InnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
 aForDrawing: TnevInnerType): InevBasePoint;
 {* Получаем первый параграф, по которому можно получить вложенную точку. }
//#UC START# *4AA76AE00147_4EC3AD980264_var*
//#UC END# *4AA76AE00147_4EC3AD980264_var*
begin
//#UC START# *4AA76AE00147_4EC3AD980264_impl*
 Result := nil;
//#UC END# *4AA76AE00147_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.InnerForChildThatNotAfterEnd

function TnevBeforeStartPoint.HasBaseLine: Boolean;
 {* Проверяет есть ли возможность работы с базовой линией на точке }
//#UC START# *4AA76AF90174_4EC3AD980264_var*
//#UC END# *4AA76AF90174_4EC3AD980264_var*
begin
//#UC START# *4AA76AF90174_4EC3AD980264_impl*
 Result := False;
//#UC END# *4AA76AF90174_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.HasBaseLine

procedure TnevBeforeStartPoint.AddInner(const aView: InevView;
 const anInner: InevBaseLine4Anchor;
 anIndex: Integer;
 var aFirst: Boolean;
 aMode: TnevAddInnerMode);
//#UC START# *4B90DA600047_4EC3AD980264_var*
//#UC END# *4B90DA600047_4EC3AD980264_var*
begin
//#UC START# *4B90DA600047_4EC3AD980264_impl*
 Assert(False);
//#UC END# *4B90DA600047_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.AddInner

procedure TnevBeforeStartPoint.CompareWithOtherInner(const aView: InevView;
 anMaxID: Integer = -1);
 {* После применения AnchorByPoint могут остаться "неинициализированные" (будут указывать на начало ячейки) дочерние точки в базовой линии. }
//#UC START# *4B9623150178_4EC3AD980264_var*
//#UC END# *4B9623150178_4EC3AD980264_var*
begin
//#UC START# *4B9623150178_4EC3AD980264_impl*
 Assert(False);
//#UC END# *4B9623150178_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.CompareWithOtherInner

function TnevBeforeStartPoint.PartiallyVisible(const aView: InevView;
 const aPoint: InevBasePoint;
 const aMap: TnevFormatInfoPrim): Boolean;
 {* Определяет может ли точка "частично видимой" относительно другой точки (aPoint). Сделано для определения видимости начальной ячейки относительно якоря. }
//#UC START# *4BBB0DDD026D_4EC3AD980264_var*
//#UC END# *4BBB0DDD026D_4EC3AD980264_var*
begin
//#UC START# *4BBB0DDD026D_4EC3AD980264_impl*
 Result := False;
 Assert(False);
//#UC END# *4BBB0DDD026D_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.PartiallyVisible

function TnevBeforeStartPoint.InnerHead(aPID: Integer): InevBasePoint;
 {* Аналог InnerFor, но для частей объдеиненных ячеек, попадающих на данную строку (пока используется только для печати). }
//#UC START# *4C456C8E027F_4EC3AD980264_var*
//#UC END# *4C456C8E027F_4EC3AD980264_var*
begin
//#UC START# *4C456C8E027F_4EC3AD980264_impl*
 Result := nil;
//#UC END# *4C456C8E027F_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.InnerHead

function TnevBeforeStartPoint.HasHeadPart: Boolean;
 {* Строка содержит продолжение объединенных ячеек. }
//#UC START# *4C456CEA01DE_4EC3AD980264_var*
//#UC END# *4C456CEA01DE_4EC3AD980264_var*
begin
//#UC START# *4C456CEA01DE_4EC3AD980264_impl*
 Result := False;
//#UC END# *4C456CEA01DE_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.HasHeadPart

procedure TnevBeforeStartPoint.AddHeadInner(const aHeadInner: InevBasePoint);
 {* Служит для добавления в базовую линию продолжений объединенных ячеек (используется только для печати). }
//#UC START# *4C456D220317_4EC3AD980264_var*
//#UC END# *4C456D220317_4EC3AD980264_var*
begin
//#UC START# *4C456D220317_4EC3AD980264_impl*
//#UC END# *4C456D220317_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.AddHeadInner

procedure TnevBeforeStartPoint.CopyHeadParts(const aFrom: InevBasePoint);
 {* Копирует только части продолжений ячеек, если они есть. }
//#UC START# *4C457D0502E1_4EC3AD980264_var*
//#UC END# *4C457D0502E1_4EC3AD980264_var*
begin
//#UC START# *4C457D0502E1_4EC3AD980264_impl*
//#UC END# *4C457D0502E1_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.CopyHeadParts

procedure TnevBeforeStartPoint.InitByCursor(const aView: InevView;
 const anInnerPoint: InevBasePoint);
 {* Инициализируем базовую линию по курсору. }
//#UC START# *4C735E600112_4EC3AD980264_var*
//#UC END# *4C735E600112_4EC3AD980264_var*
begin
//#UC START# *4C735E600112_4EC3AD980264_impl*
//#UC END# *4C735E600112_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.InitByCursor

procedure TnevBeforeStartPoint.InitBaseLineInner(const aView: InevView;
 const anItem: InevPara);
//#UC START# *4D9C113C0320_4EC3AD980264_var*
//#UC END# *4D9C113C0320_4EC3AD980264_var*
begin
//#UC START# *4D9C113C0320_4EC3AD980264_impl*
 Assert(False);
//#UC END# *4D9C113C0320_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.InitBaseLineInner

function TnevBeforeStartPoint.InnerTop(const aChild: InevObject): InevBasePoint;
 {* Возвращает указатель на первоначальную позицию для точки. Для обычных точек - всегда nil. }
//#UC START# *4DDCD59301D5_4EC3AD980264_var*
//#UC END# *4DDCD59301D5_4EC3AD980264_var*
begin
//#UC START# *4DDCD59301D5_4EC3AD980264_impl*
 Result := nil;
 Assert(False);
//#UC END# *4DDCD59301D5_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.InnerTop

function TnevBeforeStartPoint.pm_GetBeforeStart: Boolean;
//#UC START# *4EC3B0330271_4EC3AD980264get_var*
//#UC END# *4EC3B0330271_4EC3AD980264get_var*
begin
//#UC START# *4EC3B0330271_4EC3AD980264get_impl*
 Result := True;
//#UC END# *4EC3B0330271_4EC3AD980264get_impl*
end;//TnevBeforeStartPoint.pm_GetBeforeStart

procedure TnevBeforeStartPoint.CorrectMoveRight(const aView: InevView;
 const aPoint: InevBasePoint;
 const anOp: InevOp);
//#UC START# *50DAA7010050_4EC3AD980264_var*
//#UC END# *50DAA7010050_4EC3AD980264_var*
begin
//#UC START# *50DAA7010050_4EC3AD980264_impl*
 Assert(False);
//#UC END# *50DAA7010050_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.CorrectMoveRight

function TnevBeforeStartPoint.GetViewBounds(const aView: InevView;
 const aMap: InevMap): TnevRect;
//#UC START# *4A5CCD9D028D_4EC3AD980264_var*
//#UC END# *4A5CCD9D028D_4EC3AD980264_var*
begin
//#UC START# *4A5CCD9D028D_4EC3AD980264_impl*
 Result := inherited GetViewBounds(aView, aMap);
 Assert(false);
//#UC END# *4A5CCD9D028D_4EC3AD980264_impl*
end;//TnevBeforeStartPoint.GetViewBounds
{$IfEnd} // Defined(evUseVisibleCursors)

end.
