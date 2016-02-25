unit NOT_FINISHED_nevShapesPainted;
 {* Коллекция отрисованных параграфов }

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_FINISHED_nevShapesPainted.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , nevTools
 , nevBase
 , nevShapePrim
 , afwInterfaces
 , nevShapePrimRefList
;

type
 TnevShape = class(TnevShapePrim, InevMap)
  protected
   function AddShape(const aShape: InevObject;
    const aTopLeft: TnevPoint;
    MakeVisible: Boolean;
    const aHacker: InevK235870994Hacker): TnevShape; virtual; abstract;
   function pm_GetBounds: TafwRect;
   function pm_GetOuter: IafwShape;
   function rVisible: Boolean;
   procedure SetDrawnBottom(const aBottom: TnevPoint);
   function ReserveMap(const aShape: InevObject): InevMap;
   function IsLinked: Boolean;
   procedure AdjustTopByAnchor(const aView: InevView;
    const anAnchor: InevBasePoint);
   function CheckFormatInfo(const anObject: InevObject): TInevFormatInfoRet;
   procedure ClearBounds;
    {* Очищает прямоугольник. }
   function Get_FI: TInevFormatInfoRet;
   function GetMaxTop: Integer;
    {* Ищет самое нижнее значение Top у дочерних ячеек. }
   function GetChildMap(anIndex: Integer): InevMap;
   procedure SetDrawnTop(aTop: Integer);
   function GetChildenRight4Fill: Integer;
   function IsMapValid: Boolean;
  public
   procedure CleanupRefs; override;
    {* Очищает ссылки на сторонние объекты }
 end;//TnevShape

 TnevLeafShape = class(TnevShape)
  protected
   function AddShape(const aShape: InevObject;
    const aTopLeft: TnevPoint;
    MakeVisible: Boolean;
    const aHacker: InevK235870994Hacker): TnevShape; override;
 end;//TnevLeafShape

 TnevTextParaShape = class(TnevLeafShape)
 end;//TnevTextParaShape

 TnevBaseTopShape = class(TnevShape)
  protected
   function AddShape(const aShape: InevObject;
    const aTopLeft: TnevPoint;
    MakeVisible: Boolean;
    const aHacker: InevK235870994Hacker): TnevShape; override;
 end;//TnevBaseTopShape

 TnevListShape = class(TnevBaseTopShape)
 end;//TnevListShape

 TnevLinesStoredListShape = class(TnevListShape)
 end;//TnevLinesStoredListShape

 TnevHorzListShape = class(TnevListShape)
 end;//TnevHorzListShape

 TnevRowShape = class(TnevHorzListShape)
 end;//TnevRowShape

 TnevDocumentShape = class(TnevListShape)
  private
   f_DecorShapes: TnevShapePrimRefList;
 end;//TnevDocumentShape

 TnevTopShape = class(TnevDocumentShape)
 end;//TnevTopShape

 TnevHorzTopShape = class(TnevTopShape)
 end;//TnevHorzTopShape

 TnevShapesPainted = class(Tl3CacheableBase)
  {* Коллекция отрисованных параграфов }
  public
   function Root: InevMap;
   function PointByPt(const aView: InevView;
    const aPos: TnevPoint;
    CheckHidden: Boolean): InevBaseLine4Anchor;
    {* возвращает параграф самого нижнего уровня по координатам. }
   function MapByPoint(const aPoint: InevBasePoint): InevMap;
   function Empty: Boolean;
   function SubShapesCount: Integer;
   procedure SetSingle(aValue: Boolean);
    {* Переводим в режим отрисовки одиночного элемента. }
   procedure Clear;
    {* очищает список InevShape. }
   procedure ClearEx;
    {* очищает список InevShape. <?> Чем отличается от Clear? }
   procedure BeginDraw(const aShape: InevObject;
    const anAnchor: InevBasePoint;
    const aTopLeft: TnevPoint;
    var theMap: InevMap);
   procedure EndDraw;
   function MaxWidth: Integer;
   function VertScroll(const aView: InevView;
    const aFrom: InevBasePoint;
    const aTo: InevBasePoint;
    const anEx: TnevPoint): Integer;
    {* изменяется координаты элементы коллекции на расстояние от aFrom до
             aTo и возвращает расстояние между верхними границами параграфов. }
   function HorzScroll(aFrom: Integer;
    aTo: Integer;
    const anEx: TnevPoint): Integer;
    {* изменяется координаты элементы коллекции на расстояние от aFrom до
             aTo и возвращает расстояние между верхними границами параграфов. }
 end;//TnevShapesPainted

implementation

uses
 l3ImplUses
 , nevShapesPaintedSpy
;

function TnevShape.pm_GetBounds: TafwRect;
//#UC START# *473DA7280074_4B8682720286get_var*
//#UC END# *473DA7280074_4B8682720286get_var*
begin
//#UC START# *473DA7280074_4B8682720286get_impl*
 !!! Needs to be implemented !!!
//#UC END# *473DA7280074_4B8682720286get_impl*
end;//TnevShape.pm_GetBounds

function TnevShape.pm_GetOuter: IafwShape;
//#UC START# *473DA73100A9_4B8682720286get_var*
//#UC END# *473DA73100A9_4B8682720286get_var*
begin
//#UC START# *473DA73100A9_4B8682720286get_impl*
 !!! Needs to be implemented !!!
//#UC END# *473DA73100A9_4B8682720286get_impl*
end;//TnevShape.pm_GetOuter

function TnevShape.rVisible: Boolean;
//#UC START# *47C5B88F0025_4B8682720286_var*
//#UC END# *47C5B88F0025_4B8682720286_var*
begin
//#UC START# *47C5B88F0025_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B88F0025_4B8682720286_impl*
end;//TnevShape.rVisible

procedure TnevShape.SetDrawnBottom(const aBottom: TnevPoint);
//#UC START# *47C5B91302DA_4B8682720286_var*
//#UC END# *47C5B91302DA_4B8682720286_var*
begin
//#UC START# *47C5B91302DA_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B91302DA_4B8682720286_impl*
end;//TnevShape.SetDrawnBottom

function TnevShape.ReserveMap(const aShape: InevObject): InevMap;
//#UC START# *47C5B9400335_4B8682720286_var*
//#UC END# *47C5B9400335_4B8682720286_var*
begin
//#UC START# *47C5B9400335_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9400335_4B8682720286_impl*
end;//TnevShape.ReserveMap

function TnevShape.IsLinked: Boolean;
//#UC START# *47C5B9560375_4B8682720286_var*
//#UC END# *47C5B9560375_4B8682720286_var*
begin
//#UC START# *47C5B9560375_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9560375_4B8682720286_impl*
end;//TnevShape.IsLinked

procedure TnevShape.AdjustTopByAnchor(const aView: InevView;
 const anAnchor: InevBasePoint);
//#UC START# *47C5B9620340_4B8682720286_var*
//#UC END# *47C5B9620340_4B8682720286_var*
begin
//#UC START# *47C5B9620340_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9620340_4B8682720286_impl*
end;//TnevShape.AdjustTopByAnchor

function TnevShape.CheckFormatInfo(const anObject: InevObject): TInevFormatInfoRet;
//#UC START# *4810CE6103D1_4B8682720286_var*
//#UC END# *4810CE6103D1_4B8682720286_var*
begin
//#UC START# *4810CE6103D1_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *4810CE6103D1_4B8682720286_impl*
end;//TnevShape.CheckFormatInfo

procedure TnevShape.ClearBounds;
 {* Очищает прямоугольник. }
//#UC START# *48174E4500E6_4B8682720286_var*
//#UC END# *48174E4500E6_4B8682720286_var*
begin
//#UC START# *48174E4500E6_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *48174E4500E6_4B8682720286_impl*
end;//TnevShape.ClearBounds

function TnevShape.Get_FI: TInevFormatInfoRet;
//#UC START# *4A5B2B6C038C_4B8682720286get_var*
//#UC END# *4A5B2B6C038C_4B8682720286get_var*
begin
//#UC START# *4A5B2B6C038C_4B8682720286get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A5B2B6C038C_4B8682720286get_impl*
end;//TnevShape.Get_FI

function TnevShape.GetMaxTop: Integer;
 {* Ищет самое нижнее значение Top у дочерних ячеек. }
//#UC START# *4CF78985037E_4B8682720286_var*
//#UC END# *4CF78985037E_4B8682720286_var*
begin
//#UC START# *4CF78985037E_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CF78985037E_4B8682720286_impl*
end;//TnevShape.GetMaxTop

procedure TnevShape.CleanupRefs;
 {* Очищает ссылки на сторонние объекты }
//#UC START# *4E6E23810369_4B8682720286_var*
//#UC END# *4E6E23810369_4B8682720286_var*
begin
//#UC START# *4E6E23810369_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6E23810369_4B8682720286_impl*
end;//TnevShape.CleanupRefs

function TnevShape.GetChildMap(anIndex: Integer): InevMap;
//#UC START# *4FF57E82039F_4B8682720286_var*
//#UC END# *4FF57E82039F_4B8682720286_var*
begin
//#UC START# *4FF57E82039F_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FF57E82039F_4B8682720286_impl*
end;//TnevShape.GetChildMap

procedure TnevShape.SetDrawnTop(aTop: Integer);
//#UC START# *50CEEE740139_4B8682720286_var*
//#UC END# *50CEEE740139_4B8682720286_var*
begin
//#UC START# *50CEEE740139_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *50CEEE740139_4B8682720286_impl*
end;//TnevShape.SetDrawnTop

function TnevShape.GetChildenRight4Fill: Integer;
//#UC START# *52AA973C0380_4B8682720286_var*
//#UC END# *52AA973C0380_4B8682720286_var*
begin
//#UC START# *52AA973C0380_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *52AA973C0380_4B8682720286_impl*
end;//TnevShape.GetChildenRight4Fill

function TnevShape.IsMapValid: Boolean;
//#UC START# *52FC8C1C00D9_4B8682720286_var*
//#UC END# *52FC8C1C00D9_4B8682720286_var*
begin
//#UC START# *52FC8C1C00D9_4B8682720286_impl*
 !!! Needs to be implemented !!!
//#UC END# *52FC8C1C00D9_4B8682720286_impl*
end;//TnevShape.IsMapValid

function TnevLeafShape.AddShape(const aShape: InevObject;
 const aTopLeft: TnevPoint;
 MakeVisible: Boolean;
 const aHacker: InevK235870994Hacker): TnevShape;
//#UC START# *4E6E1AFF0229_4B8682990059_var*
//#UC END# *4E6E1AFF0229_4B8682990059_var*
begin
//#UC START# *4E6E1AFF0229_4B8682990059_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6E1AFF0229_4B8682990059_impl*
end;//TnevLeafShape.AddShape

function TnevBaseTopShape.AddShape(const aShape: InevObject;
 const aTopLeft: TnevPoint;
 MakeVisible: Boolean;
 const aHacker: InevK235870994Hacker): TnevShape;
//#UC START# *4E6E1AFF0229_4B8682B00020_var*
//#UC END# *4E6E1AFF0229_4B8682B00020_var*
begin
//#UC START# *4E6E1AFF0229_4B8682B00020_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6E1AFF0229_4B8682B00020_impl*
end;//TnevBaseTopShape.AddShape

function TnevShapesPainted.Root: InevMap;
//#UC START# *47C7D2480162_4811DA3100E6_var*
//#UC END# *47C7D2480162_4811DA3100E6_var*
begin
//#UC START# *47C7D2480162_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D2480162_4811DA3100E6_impl*
end;//TnevShapesPainted.Root

function TnevShapesPainted.PointByPt(const aView: InevView;
 const aPos: TnevPoint;
 CheckHidden: Boolean): InevBaseLine4Anchor;
 {* возвращает параграф самого нижнего уровня по координатам. }
//#UC START# *47C7D34701A6_4811DA3100E6_var*
//#UC END# *47C7D34701A6_4811DA3100E6_var*
begin
//#UC START# *47C7D34701A6_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D34701A6_4811DA3100E6_impl*
end;//TnevShapesPainted.PointByPt

function TnevShapesPainted.MapByPoint(const aPoint: InevBasePoint): InevMap;
//#UC START# *47C7D36502E0_4811DA3100E6_var*
//#UC END# *47C7D36502E0_4811DA3100E6_var*
begin
//#UC START# *47C7D36502E0_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D36502E0_4811DA3100E6_impl*
end;//TnevShapesPainted.MapByPoint

function TnevShapesPainted.Empty: Boolean;
//#UC START# *47C7D373009C_4811DA3100E6_var*
//#UC END# *47C7D373009C_4811DA3100E6_var*
begin
//#UC START# *47C7D373009C_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D373009C_4811DA3100E6_impl*
end;//TnevShapesPainted.Empty

function TnevShapesPainted.SubShapesCount: Integer;
//#UC START# *47C7D37F0287_4811DA3100E6_var*
//#UC END# *47C7D37F0287_4811DA3100E6_var*
begin
//#UC START# *47C7D37F0287_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D37F0287_4811DA3100E6_impl*
end;//TnevShapesPainted.SubShapesCount

procedure TnevShapesPainted.SetSingle(aValue: Boolean);
 {* Переводим в режим отрисовки одиночного элемента. }
//#UC START# *47C7D38B00E5_4811DA3100E6_var*
//#UC END# *47C7D38B00E5_4811DA3100E6_var*
begin
//#UC START# *47C7D38B00E5_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D38B00E5_4811DA3100E6_impl*
end;//TnevShapesPainted.SetSingle

procedure TnevShapesPainted.Clear;
 {* очищает список InevShape. }
//#UC START# *47C7D3CC02CA_4811DA3100E6_var*
//#UC END# *47C7D3CC02CA_4811DA3100E6_var*
begin
//#UC START# *47C7D3CC02CA_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D3CC02CA_4811DA3100E6_impl*
end;//TnevShapesPainted.Clear

procedure TnevShapesPainted.ClearEx;
 {* очищает список InevShape. <?> Чем отличается от Clear? }
//#UC START# *47C7D3DB013C_4811DA3100E6_var*
//#UC END# *47C7D3DB013C_4811DA3100E6_var*
begin
//#UC START# *47C7D3DB013C_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D3DB013C_4811DA3100E6_impl*
end;//TnevShapesPainted.ClearEx

procedure TnevShapesPainted.BeginDraw(const aShape: InevObject;
 const anAnchor: InevBasePoint;
 const aTopLeft: TnevPoint;
 var theMap: InevMap);
//#UC START# *47C7D3FC031E_4811DA3100E6_var*
//#UC END# *47C7D3FC031E_4811DA3100E6_var*
begin
//#UC START# *47C7D3FC031E_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D3FC031E_4811DA3100E6_impl*
end;//TnevShapesPainted.BeginDraw

procedure TnevShapesPainted.EndDraw;
//#UC START# *47C7D418021D_4811DA3100E6_var*
//#UC END# *47C7D418021D_4811DA3100E6_var*
begin
//#UC START# *47C7D418021D_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D418021D_4811DA3100E6_impl*
end;//TnevShapesPainted.EndDraw

function TnevShapesPainted.MaxWidth: Integer;
//#UC START# *47C7D425024C_4811DA3100E6_var*
//#UC END# *47C7D425024C_4811DA3100E6_var*
begin
//#UC START# *47C7D425024C_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D425024C_4811DA3100E6_impl*
end;//TnevShapesPainted.MaxWidth

function TnevShapesPainted.VertScroll(const aView: InevView;
 const aFrom: InevBasePoint;
 const aTo: InevBasePoint;
 const anEx: TnevPoint): Integer;
 {* изменяется координаты элементы коллекции на расстояние от aFrom до
             aTo и возвращает расстояние между верхними границами параграфов. }
//#UC START# *47C7D87400C8_4811DA3100E6_var*
//#UC END# *47C7D87400C8_4811DA3100E6_var*
begin
//#UC START# *47C7D87400C8_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D87400C8_4811DA3100E6_impl*
end;//TnevShapesPainted.VertScroll

function TnevShapesPainted.HorzScroll(aFrom: Integer;
 aTo: Integer;
 const anEx: TnevPoint): Integer;
 {* изменяется координаты элементы коллекции на расстояние от aFrom до
             aTo и возвращает расстояние между верхними границами параграфов. }
//#UC START# *47C7D8910243_4811DA3100E6_var*
//#UC END# *47C7D8910243_4811DA3100E6_var*
begin
//#UC START# *47C7D8910243_4811DA3100E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7D8910243_4811DA3100E6_impl*
end;//TnevShapesPainted.HorzScroll

end.
