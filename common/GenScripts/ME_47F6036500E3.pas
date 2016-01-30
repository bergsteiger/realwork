unit nevAfterEndPoint;
 {* Точка, указывающая ЗА КОНЕЦ параграфа. }

// Модуль: "w:\common\components\gui\Garant\Everest\nevAfterEndPoint.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

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
 {$Include nevPrimPoint.imp.pas}
 TnevAfterEndPoint = class(_nevPrimPoint_, InevPoint, InevBasePoint)
  {* Точка, указывающая ЗА КОНЕЦ параграфа. }
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
   class function DoMake(const aPoint: InevBasePoint): InevPoint; reintroduce;
   class function Make(const aView: InevView;
    const aPoint: InevBasePoint): InevBasePoint;
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
 end;//TnevAfterEndPoint
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , SysUtils
;

type _Instance_R_ = TnevAfterEndPoint;

{$Include nevPrimPoint.imp.pas}

constructor TnevAfterEndPoint.Create(const aPoint: InevBasePoint);
//#UC START# *47F6046E01B1_47F6036500E3_var*
//#UC END# *47F6046E01B1_47F6036500E3_var*
begin
//#UC START# *47F6046E01B1_47F6036500E3_impl*
 inherited Create(aPoint.Obj^.AsObject);
//#UC END# *47F6046E01B1_47F6036500E3_impl*
end;//TnevAfterEndPoint.Create

class function TnevAfterEndPoint.DoMake(const aPoint: InevBasePoint): InevPoint;
var
 l_Inst : TnevAfterEndPoint;
begin
 l_Inst := Create(aPoint);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevAfterEndPoint.DoMake

class function TnevAfterEndPoint.Make(const aView: InevView;
 const aPoint: InevBasePoint): InevBasePoint;
//#UC START# *47F604A60159_47F6036500E3_var*
var
 l_Line   : Integer;
 l_Anchor : InevAnchor;
//#UC END# *47F604A60159_47F6036500E3_var*
begin
//#UC START# *47F604A60159_47F6036500E3_impl*
 l_Line := 1;
 l_Anchor := aPoint.Obj.MakeAnchor;
 l_Anchor.AssignPoint(aView, aPoint);
 l_Anchor.IncLine(aView, l_Line, true);
 if (l_Line = 1) then
  Result := DoMake(aPoint)
 else
 begin
  //Result := aPoint;
  Result := l_Anchor.Obj.MakePoint;
  Result.AssignPoint(aView, l_Anchor);
 end;//l_Line = 1
//#UC END# *47F604A60159_47F6036500E3_impl*
end;//TnevAfterEndPoint.Make

function TnevAfterEndPoint.Range: InevRange;
//#UC START# *47C5B55D00B4_47F6036500E3_var*
//#UC END# *47C5B55D00B4_47F6036500E3_var*
begin
//#UC START# *47C5B55D00B4_47F6036500E3_impl*
 Result := nil;
 Assert(false);
//#UC END# *47C5B55D00B4_47F6036500E3_impl*
end;//TnevAfterEndPoint.Range

function TnevAfterEndPoint.pm_GetFormatting: InevDataFormatting;
//#UC START# *47C5B603039F_47F6036500E3get_var*
//#UC END# *47C5B603039F_47F6036500E3get_var*
begin
//#UC START# *47C5B603039F_47F6036500E3get_impl*
 Result := nil;
 Assert(false);
//#UC END# *47C5B603039F_47F6036500E3get_impl*
end;//TnevAfterEndPoint.pm_GetFormatting

function TnevAfterEndPoint.VertPosition(const aView: InevView;
 aMap: TnevFormatInfoPrim): TnevParaIndex;
//#UC START# *47C5B65D0195_47F6036500E3_var*
//#UC END# *47C5B65D0195_47F6036500E3_var*
begin
//#UC START# *47C5B65D0195_47F6036500E3_impl*
 Result := High(Result);
//#UC END# *47C5B65D0195_47F6036500E3_impl*
end;//TnevAfterEndPoint.VertPosition

function TnevAfterEndPoint.NeedWindowsCaret: Boolean;
//#UC START# *47C5B6D30128_47F6036500E3_var*
//#UC END# *47C5B6D30128_47F6036500E3_var*
begin
//#UC START# *47C5B6D30128_47F6036500E3_impl*
 Result := true;
 //Assert(false);
//#UC END# *47C5B6D30128_47F6036500E3_impl*
end;//TnevAfterEndPoint.NeedWindowsCaret

function TnevAfterEndPoint.ClonePoint(const aView: InevView): InevBasePoint;
//#UC START# *47C5B6E503C3_47F6036500E3_var*
//#UC END# *47C5B6E503C3_47F6036500E3_var*
begin
//#UC START# *47C5B6E503C3_47F6036500E3_impl*
 Result := TnevAfterEndPoint.DoMake(ParaX.MakePoint);
//#UC END# *47C5B6E503C3_47F6036500E3_impl*
end;//TnevAfterEndPoint.ClonePoint

function TnevAfterEndPoint.DeltaX(const aView: InevView;
 const aMap: InevMap): Integer;
//#UC START# *47C5B6F202A0_47F6036500E3_var*
//#UC END# *47C5B6F202A0_47F6036500E3_var*
begin
//#UC START# *47C5B6F202A0_47F6036500E3_impl*
 Result := 0;
 Assert(false);
//#UC END# *47C5B6F202A0_47F6036500E3_impl*
end;//TnevAfterEndPoint.DeltaX

function TnevAfterEndPoint.pm_GetInner: InevBasePoint;
//#UC START# *47C5B7400152_47F6036500E3get_var*
//#UC END# *47C5B7400152_47F6036500E3get_var*
begin
//#UC START# *47C5B7400152_47F6036500E3get_impl*
 Result := nil;
 //Assert(false);
//#UC END# *47C5B7400152_47F6036500E3get_impl*
end;//TnevAfterEndPoint.pm_GetInner

procedure TnevAfterEndPoint.pm_SetInner(const aValue: InevBasePoint);
//#UC START# *47C5B7400152_47F6036500E3set_var*
//#UC END# *47C5B7400152_47F6036500E3set_var*
begin
//#UC START# *47C5B7400152_47F6036500E3set_impl*
 Assert(false);
//#UC END# *47C5B7400152_47F6036500E3set_impl*
end;//TnevAfterEndPoint.pm_SetInner

function TnevAfterEndPoint.Get_Position: TnevPosition;
//#UC START# *47C5B75F00AF_47F6036500E3get_var*
//#UC END# *47C5B75F00AF_47F6036500E3get_var*
begin
//#UC START# *47C5B75F00AF_47F6036500E3get_impl*
 Result := High(Result);
//#UC END# *47C5B75F00AF_47F6036500E3get_impl*
end;//TnevAfterEndPoint.Get_Position

procedure TnevAfterEndPoint.AssignPoint(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *47C5C25C022F_47F6036500E3_var*
//#UC END# *47C5C25C022F_47F6036500E3_var*
begin
//#UC START# *47C5C25C022F_47F6036500E3_impl*
 Assert(false);
//#UC END# *47C5C25C022F_47F6036500E3_impl*
end;//TnevAfterEndPoint.AssignPoint

procedure TnevAfterEndPoint.Bottom(const aView: InevView);
//#UC START# *47C5C2970095_47F6036500E3_var*
//#UC END# *47C5C2970095_47F6036500E3_var*
begin
//#UC START# *47C5C2970095_47F6036500E3_impl*
 Assert(false);
//#UC END# *47C5C2970095_47F6036500E3_impl*
end;//TnevAfterEndPoint.Bottom

function TnevAfterEndPoint.IncLine(const aView: InevView;
 var theLine: Integer;
 aByLine: Boolean): Integer;
 {* сдвигает якорь на указанное число строк. Возвращает количество параграфов на которое сдвинулся якорь. }
//#UC START# *47C5C2A40309_47F6036500E3_var*
//#UC END# *47C5C2A40309_47F6036500E3_var*
begin
//#UC START# *47C5C2A40309_47F6036500E3_impl*
 Assert(false);
 Result := 0;
//#UC END# *47C5C2A40309_47F6036500E3_impl*
end;//TnevAfterEndPoint.IncLine

function TnevAfterEndPoint.InnerFor(const aChild: InevObject;
 var aRealTop: InevBasePoint): InevBasePoint;
//#UC START# *47F5FDA303BC_47F6036500E3_var*
//#UC END# *47F5FDA303BC_47F6036500E3_var*
begin
//#UC START# *47F5FDA303BC_47F6036500E3_impl*
 Result := nil;
 Assert(false);
//#UC END# *47F5FDA303BC_47F6036500E3_impl*
end;//TnevAfterEndPoint.InnerFor

function TnevAfterEndPoint.pm_GetAfterEnd: Boolean;
//#UC START# *47F618A90162_47F6036500E3get_var*
//#UC END# *47F618A90162_47F6036500E3get_var*
begin
//#UC START# *47F618A90162_47F6036500E3get_impl*
 Result := true;
//#UC END# *47F618A90162_47F6036500E3get_impl*
end;//TnevAfterEndPoint.pm_GetAfterEnd

function TnevAfterEndPoint.Get_AsLeaf: InevLeafPoint;
//#UC START# *47FB32280262_47F6036500E3get_var*
//#UC END# *47FB32280262_47F6036500E3get_var*
begin
//#UC START# *47FB32280262_47F6036500E3get_impl*
 Result := nil;
//#UC END# *47FB32280262_47F6036500E3get_impl*
end;//TnevAfterEndPoint.Get_AsLeaf

function TnevAfterEndPoint.Get_LinkedPoint: InevLinkedPoint;
//#UC START# *47FCC68B03B1_47F6036500E3get_var*
//#UC END# *47FCC68B03B1_47F6036500E3get_var*
begin
//#UC START# *47FCC68B03B1_47F6036500E3get_impl*
 Result := nil;
//#UC END# *47FCC68B03B1_47F6036500E3get_impl*
end;//TnevAfterEndPoint.Get_LinkedPoint

function TnevAfterEndPoint.AtEnd(const aView: InevView): Boolean;
//#UC START# *47FF3F1800FE_47F6036500E3_var*
//#UC END# *47FF3F1800FE_47F6036500E3_var*
begin
//#UC START# *47FF3F1800FE_47F6036500E3_impl*
  Result := true;
 // - мы стоим ЗА КОНЦОМ параграфа, значит КОНЕЦ включён 
//#UC END# *47FF3F1800FE_47F6036500E3_impl*
end;//TnevAfterEndPoint.AtEnd

function TnevAfterEndPoint.AtStart: Boolean;
//#UC START# *47FF414E039D_47F6036500E3_var*
//#UC END# *47FF414E039D_47F6036500E3_var*
begin
//#UC START# *47FF414E039D_47F6036500E3_impl*
  Result := false;
 // - мы стоим ЗА КОНЦОМ параграфа, значит на начале никак не можем стоять 
//#UC END# *47FF414E039D_47F6036500E3_impl*
end;//TnevAfterEndPoint.AtStart

function TnevAfterEndPoint.Diff(const aView: InevView;
 const aPoint: InevBasePoint;
 aMap: TnevFormatInfoPrim): Integer;
 {* сравнивает курсор с "якорем" по вертикали. }
//#UC START# *49DF51870234_47F6036500E3_var*
//#UC END# *49DF51870234_47F6036500E3_var*
begin
//#UC START# *49DF51870234_47F6036500E3_impl*
 if (aPoint = nil) then
  Result := +1
 else
 begin
  Assert(ParaX.AsObject.IsSame(aPoint.Obj^.AsObject));
  if aPoint.AfterEnd then
   Result := 0
  else
   Result := +1;
 end;//aPoint = nil
//#UC END# *49DF51870234_47F6036500E3_impl*
end;//TnevAfterEndPoint.Diff

function TnevAfterEndPoint.pm_GetText: InevText;
//#UC START# *49E6FB10002A_47F6036500E3get_var*
//#UC END# *49E6FB10002A_47F6036500E3get_var*
begin
//#UC START# *49E6FB10002A_47F6036500E3get_impl*
 Result := nil;
 Assert(false);
//#UC END# *49E6FB10002A_47F6036500E3get_impl*
end;//TnevAfterEndPoint.pm_GetText

procedure TnevAfterEndPoint.DisableListener;
 {* Отключает нотификацию об изменении }
//#UC START# *4A4C856300DF_47F6036500E3_var*
//#UC END# *4A4C856300DF_47F6036500E3_var*
begin
//#UC START# *4A4C856300DF_47F6036500E3_impl*
 Assert(false);
//#UC END# *4A4C856300DF_47F6036500E3_impl*
end;//TnevAfterEndPoint.DisableListener

procedure TnevAfterEndPoint.EnableListener;
 {* Включает нотификацию об изменении }
//#UC START# *4A4C8581014B_47F6036500E3_var*
//#UC END# *4A4C8581014B_47F6036500E3_var*
begin
//#UC START# *4A4C8581014B_47F6036500E3_impl*
 Assert(false);
//#UC END# *4A4C8581014B_47F6036500E3_impl*
end;//TnevAfterEndPoint.EnableListener

function TnevAfterEndPoint.Get_HasInner: Boolean;
//#UC START# *4A58B79A0360_47F6036500E3get_var*
//#UC END# *4A58B79A0360_47F6036500E3get_var*
begin
//#UC START# *4A58B79A0360_47F6036500E3get_impl*
 Result := false;
//#UC END# *4A58B79A0360_47F6036500E3get_impl*
end;//TnevAfterEndPoint.Get_HasInner

function TnevAfterEndPoint.Get_ShowCollapsed: Boolean;
//#UC START# *4A5B48A701A9_47F6036500E3get_var*
//#UC END# *4A5B48A701A9_47F6036500E3get_var*
begin
//#UC START# *4A5B48A701A9_47F6036500E3get_impl*
 Result := true;
//#UC END# *4A5B48A701A9_47F6036500E3get_impl*
end;//TnevAfterEndPoint.Get_ShowCollapsed

procedure TnevAfterEndPoint.Set_ShowCollapsed(aValue: Boolean);
//#UC START# *4A5B48A701A9_47F6036500E3set_var*
//#UC END# *4A5B48A701A9_47F6036500E3set_var*
begin
//#UC START# *4A5B48A701A9_47F6036500E3set_impl*
 Assert(aValue);
//#UC END# *4A5B48A701A9_47F6036500E3set_impl*
end;//TnevAfterEndPoint.Set_ShowCollapsed

function TnevAfterEndPoint.Compare(const aPoint: InevBasePoint): Integer;
//#UC START# *4A5B60870158_47F6036500E3_var*
//#UC END# *4A5B60870158_47F6036500E3_var*
begin
//#UC START# *4A5B60870158_47F6036500E3_impl*
 Result := -1;
 Assert(false);
//#UC END# *4A5B60870158_47F6036500E3_impl*
end;//TnevAfterEndPoint.Compare

procedure TnevAfterEndPoint.CheckPos(const anOp: InevOp);
 {* Избавляемся от рассинхронизации позиции курсора и дочернего параграфа. Заплатка конечно }
//#UC START# *4A5B6D370262_47F6036500E3_var*
//#UC END# *4A5B6D370262_47F6036500E3_var*
begin
//#UC START# *4A5B6D370262_47F6036500E3_impl*
 // ничего не делаем
//#UC END# *4A5B6D370262_47F6036500E3_impl*
end;//TnevAfterEndPoint.CheckPos

function TnevAfterEndPoint.ReadOnly: Boolean;
//#UC START# *4A5C66200185_47F6036500E3_var*
//#UC END# *4A5C66200185_47F6036500E3_var*
begin
//#UC START# *4A5C66200185_47F6036500E3_impl*
 Result := false;
 Assert(false);
//#UC END# *4A5C66200185_47F6036500E3_impl*
end;//TnevAfterEndPoint.ReadOnly

function TnevAfterEndPoint.AsPoint: InevBasePoint;
//#UC START# *4A5C6DB4014D_47F6036500E3_var*
//#UC END# *4A5C6DB4014D_47F6036500E3_var*
begin
//#UC START# *4A5C6DB4014D_47F6036500E3_impl*
 Result := Self;
//#UC END# *4A5C6DB4014D_47F6036500E3_impl*
end;//TnevAfterEndPoint.AsPoint

function TnevAfterEndPoint.AsCursor(const aView: InevView): InevPoint;
//#UC START# *4A5C750E01F7_47F6036500E3_var*
//#UC END# *4A5C750E01F7_47F6036500E3_var*
begin
//#UC START# *4A5C750E01F7_47F6036500E3_impl*
 Result := Self;
//#UC END# *4A5C750E01F7_47F6036500E3_impl*
end;//TnevAfterEndPoint.AsCursor

{$If Defined(evNeedMarkers)}
function TnevAfterEndPoint.Get_MarkersSource: IevMarkersSource;
//#UC START# *4A5C7D2F0079_47F6036500E3get_var*
//#UC END# *4A5C7D2F0079_47F6036500E3get_var*
begin
//#UC START# *4A5C7D2F0079_47F6036500E3get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4A5C7D2F0079_47F6036500E3get_impl*
end;//TnevAfterEndPoint.Get_MarkersSource
{$IfEnd} // Defined(evNeedMarkers)

function TnevAfterEndPoint.ProcessMessage(const aView: InevControlView;
 var aMessage: TMessage;
 aTime: Cardinal): Boolean;
//#UC START# *4A5C8A9D0324_47F6036500E3_var*
//#UC END# *4A5C8A9D0324_47F6036500E3_var*
begin
//#UC START# *4A5C8A9D0324_47F6036500E3_impl*
 Result := false;
 Assert(false);
//#UC END# *4A5C8A9D0324_47F6036500E3_impl*
end;//TnevAfterEndPoint.ProcessMessage

function TnevAfterEndPoint.Get_Listener: InevPointListener;
//#UC START# *4A5C9138035D_47F6036500E3get_var*
//#UC END# *4A5C9138035D_47F6036500E3get_var*
begin
//#UC START# *4A5C9138035D_47F6036500E3get_impl*
 Result := nil;
 // - не надо никому ни о чём сообщать
//#UC END# *4A5C9138035D_47F6036500E3get_impl*
end;//TnevAfterEndPoint.Get_Listener

function TnevAfterEndPoint.GetBlockLength: Integer;
//#UC START# *4A5C913F0235_47F6036500E3_var*
//#UC END# *4A5C913F0235_47F6036500E3_var*
begin
//#UC START# *4A5C913F0235_47F6036500E3_impl*
 Result := 0;
 Assert(false);
//#UC END# *4A5C913F0235_47F6036500E3_impl*
end;//TnevAfterEndPoint.GetBlockLength

procedure TnevAfterEndPoint.MergeTo(const aView: InevView;
 const aBaseLine: InevBasePoint);
 {* Объединяем значения отрисованных частей. }
//#UC START# *4A810F81018E_47F6036500E3_var*
//#UC END# *4A810F81018E_47F6036500E3_var*
begin
//#UC START# *4A810F81018E_47F6036500E3_impl*
 Assert(False);
//#UC END# *4A810F81018E_47F6036500E3_impl*
end;//TnevAfterEndPoint.MergeTo

function TnevAfterEndPoint.InnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
 aForDrawing: TnevInnerType): InevBasePoint;
 {* Получаем первый параграф, по которому можно получить вложенную точку. }
//#UC START# *4AA76AE00147_47F6036500E3_var*
//#UC END# *4AA76AE00147_47F6036500E3_var*
begin
//#UC START# *4AA76AE00147_47F6036500E3_impl*
 Result := nil;
//#UC END# *4AA76AE00147_47F6036500E3_impl*
end;//TnevAfterEndPoint.InnerForChildThatNotAfterEnd

function TnevAfterEndPoint.HasBaseLine: Boolean;
 {* Проверяет есть ли возможность работы с базовой линией на точке }
//#UC START# *4AA76AF90174_47F6036500E3_var*
//#UC END# *4AA76AF90174_47F6036500E3_var*
begin
//#UC START# *4AA76AF90174_47F6036500E3_impl*
 Result := False;
//#UC END# *4AA76AF90174_47F6036500E3_impl*
end;//TnevAfterEndPoint.HasBaseLine

procedure TnevAfterEndPoint.AddInner(const aView: InevView;
 const anInner: InevBaseLine4Anchor;
 anIndex: Integer;
 var aFirst: Boolean;
 aMode: TnevAddInnerMode);
//#UC START# *4B90DA600047_47F6036500E3_var*
//#UC END# *4B90DA600047_47F6036500E3_var*
begin
//#UC START# *4B90DA600047_47F6036500E3_impl*
 Assert(False);
//#UC END# *4B90DA600047_47F6036500E3_impl*
end;//TnevAfterEndPoint.AddInner

procedure TnevAfterEndPoint.CompareWithOtherInner(const aView: InevView;
 anMaxID: Integer = -1);
 {* После применения AnchorByPoint могут остаться "неинициализированные" (будут указывать на начало ячейки) дочерние точки в базовой линии. }
//#UC START# *4B9623150178_47F6036500E3_var*
//#UC END# *4B9623150178_47F6036500E3_var*
begin
//#UC START# *4B9623150178_47F6036500E3_impl*
 Assert(False);
//#UC END# *4B9623150178_47F6036500E3_impl*
end;//TnevAfterEndPoint.CompareWithOtherInner

function TnevAfterEndPoint.PartiallyVisible(const aView: InevView;
 const aPoint: InevBasePoint;
 const aMap: TnevFormatInfoPrim): Boolean;
 {* Определяет может ли точка "частично видимой" относительно другой точки (aPoint). Сделано для определения видимости начальной ячейки относительно якоря. }
//#UC START# *4BBB0DDD026D_47F6036500E3_var*
//#UC END# *4BBB0DDD026D_47F6036500E3_var*
begin
//#UC START# *4BBB0DDD026D_47F6036500E3_impl*
 Result := False;
 Assert(False);
//#UC END# *4BBB0DDD026D_47F6036500E3_impl*
end;//TnevAfterEndPoint.PartiallyVisible

function TnevAfterEndPoint.InnerHead(aPID: Integer): InevBasePoint;
 {* Аналог InnerFor, но для частей объдеиненных ячеек, попадающих на данную строку (пока используется только для печати). }
//#UC START# *4C456C8E027F_47F6036500E3_var*
//#UC END# *4C456C8E027F_47F6036500E3_var*
begin
//#UC START# *4C456C8E027F_47F6036500E3_impl*
 Result := nil;
//#UC END# *4C456C8E027F_47F6036500E3_impl*
end;//TnevAfterEndPoint.InnerHead

function TnevAfterEndPoint.HasHeadPart: Boolean;
 {* Строка содержит продолжение объединенных ячеек. }
//#UC START# *4C456CEA01DE_47F6036500E3_var*
//#UC END# *4C456CEA01DE_47F6036500E3_var*
begin
//#UC START# *4C456CEA01DE_47F6036500E3_impl*
 Result := False;
//#UC END# *4C456CEA01DE_47F6036500E3_impl*
end;//TnevAfterEndPoint.HasHeadPart

procedure TnevAfterEndPoint.AddHeadInner(const aHeadInner: InevBasePoint);
 {* Служит для добавления в базовую линию продолжений объединенных ячеек (используется только для печати). }
//#UC START# *4C456D220317_47F6036500E3_var*
//#UC END# *4C456D220317_47F6036500E3_var*
begin
//#UC START# *4C456D220317_47F6036500E3_impl*
//#UC END# *4C456D220317_47F6036500E3_impl*
end;//TnevAfterEndPoint.AddHeadInner

procedure TnevAfterEndPoint.CopyHeadParts(const aFrom: InevBasePoint);
 {* Копирует только части продолжений ячеек, если они есть. }
//#UC START# *4C457D0502E1_47F6036500E3_var*
//#UC END# *4C457D0502E1_47F6036500E3_var*
begin
//#UC START# *4C457D0502E1_47F6036500E3_impl*
//#UC END# *4C457D0502E1_47F6036500E3_impl*
end;//TnevAfterEndPoint.CopyHeadParts

procedure TnevAfterEndPoint.InitByCursor(const aView: InevView;
 const anInnerPoint: InevBasePoint);
 {* Инициализируем базовую линию по курсору. }
//#UC START# *4C735E600112_47F6036500E3_var*
//#UC END# *4C735E600112_47F6036500E3_var*
begin
//#UC START# *4C735E600112_47F6036500E3_impl*
//#UC END# *4C735E600112_47F6036500E3_impl*
end;//TnevAfterEndPoint.InitByCursor

procedure TnevAfterEndPoint.InitBaseLineInner(const aView: InevView;
 const anItem: InevPara);
//#UC START# *4D9C113C0320_47F6036500E3_var*
//#UC END# *4D9C113C0320_47F6036500E3_var*
begin
//#UC START# *4D9C113C0320_47F6036500E3_impl*
 Assert(False);
//#UC END# *4D9C113C0320_47F6036500E3_impl*
end;//TnevAfterEndPoint.InitBaseLineInner

function TnevAfterEndPoint.InnerTop(const aChild: InevObject): InevBasePoint;
 {* Возвращает указатель на первоначальную позицию для точки. Для обычных точек - всегда nil. }
//#UC START# *4DDCD59301D5_47F6036500E3_var*
//#UC END# *4DDCD59301D5_47F6036500E3_var*
begin
//#UC START# *4DDCD59301D5_47F6036500E3_impl*
 Result := nil;
 Assert(False);
//#UC END# *4DDCD59301D5_47F6036500E3_impl*
end;//TnevAfterEndPoint.InnerTop

function TnevAfterEndPoint.pm_GetBeforeStart: Boolean;
//#UC START# *4EC3B0330271_47F6036500E3get_var*
//#UC END# *4EC3B0330271_47F6036500E3get_var*
begin
//#UC START# *4EC3B0330271_47F6036500E3get_impl*
 Result := False;
//#UC END# *4EC3B0330271_47F6036500E3get_impl*
end;//TnevAfterEndPoint.pm_GetBeforeStart

procedure TnevAfterEndPoint.CorrectMoveRight(const aView: InevView;
 const aPoint: InevBasePoint;
 const anOp: InevOp);
//#UC START# *50DAA7010050_47F6036500E3_var*
//#UC END# *50DAA7010050_47F6036500E3_var*
begin
//#UC START# *50DAA7010050_47F6036500E3_impl*
 Assert(False);
//#UC END# *50DAA7010050_47F6036500E3_impl*
end;//TnevAfterEndPoint.CorrectMoveRight

function TnevAfterEndPoint.GetViewBounds(const aView: InevView;
 const aMap: InevMap): TnevRect;
//#UC START# *4A5CCD9D028D_47F6036500E3_var*
//#UC END# *4A5CCD9D028D_47F6036500E3_var*
begin
//#UC START# *4A5CCD9D028D_47F6036500E3_impl*
 Result := inherited GetViewBounds(aView, aMap);
 Assert(false);
//#UC END# *4A5CCD9D028D_47F6036500E3_impl*
end;//TnevAfterEndPoint.GetViewBounds
{$IfEnd} // Defined(evUseVisibleCursors)

end.
