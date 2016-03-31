unit nevBaseView;
 {* Базовая реализация области вывода. }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevBaseView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevBaseView" MUID: (4811D544006F)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , nevTools
 , nevShapesPainted
 , nevBase
;

type
 TnevBaseView = class(Tl3ProtoObject, InevView)
  {* Базовая реализация области вывода. }
  private
   f_Level: Integer;
   f_ShapesPainted: TnevShapesPainted;
  protected
   f_Holder: Pointer;
  protected
   function pm_GetShape: InevObject; virtual;
   function pm_GetActiveElementPrim: InevActiveElement; virtual;
   function pm_GetForceDrawFocusRectPrim: Boolean; virtual;
   function pm_GetIsObjectCollapsed(const anObject: InevObject): Boolean; virtual;
   procedure pm_SetIsObjectCollapsed(const anObject: InevObject;
    aValue: Boolean); virtual;
   {$If Defined(evNeedCollapsedVersionComments)}
   procedure DoVersionInfoVisabilityChanged(aValue: Boolean); virtual;
   {$IfEnd} // Defined(evNeedCollapsedVersionComments)
   procedure DoInvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts); virtual;
   function DoGetMetrics: InevViewMetrics; virtual;
   function DoGetProcessor: InevProcessor; virtual;
   procedure ClearShapesPrim; virtual;
   procedure DoClearShapes(aNeedClearMax: Boolean);
    {* очищает список отображаемых форм. }
   procedure DoBeginDrawShape(const aShape: InevObject;
    const anAnchor: InevBasePoint;
    const anOrg: TnevPoint;
    var theMap: InevMap;
    aFake: Boolean;
    const aHacker: InevK235870994Hacker); virtual;
   function GetRootFormatInfo: TnevFormatInfoPrim; virtual;
   function pm_GetMetrics: InevViewMetrics;
   function Data: InevObject;
   function RootMap: InevMap;
   function Processor: InevProcessor;
   procedure ClearShapes;
   procedure BeginDrawShape(const aShape: InevObject;
    const anAnchor: InevBasePoint;
    const anOrg: TnevPoint;
    var theMap: InevMap;
    aFake: Boolean;
    const aHacker: InevK235870994Hacker);
    {* Начинает добавление формы в список. }
   procedure EndDrawShape;
    {* Заканчивает добавление формы в список. }
   function MapByPoint(const aPoint: InevBasePoint;
    aCheckTopVisible: Boolean = False): InevMap;
   function FormatInfoByPoint(const aPoint: InevBasePoint): TnevFormatInfoPrim;
   function RootFormatInfo: TnevFormatInfoPrim;
   function Get_ActiveElement: InevActiveElement;
   function Get_ForceDrawFocusRect: Boolean;
   function Get_IsObjectCollapsed(const anObject: InevObject): Boolean;
   procedure Set_IsObjectCollapsed(const anObject: InevObject;
    aValue: Boolean);
   {$If Defined(evNeedCollapsedVersionComments)}
   procedure VersionInfoVisabilityChanged(aValue: Boolean);
   {$IfEnd} // Defined(evNeedCollapsedVersionComments)
   function FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim; overload;
   function FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
   function FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim; overload;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create; reintroduce; virtual;
   procedure InvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts);
  protected
   property ActiveElementPrim: InevActiveElement
    read pm_GetActiveElementPrim;
   property ForceDrawFocusRectPrim: Boolean
    read pm_GetForceDrawFocusRectPrim;
   property IsObjectCollapsed[const anObject: InevObject]: Boolean
    read pm_GetIsObjectCollapsed
    write pm_SetIsObjectCollapsed;
  public
   property Level: Integer
    read f_Level;
   property ShapesPainted: TnevShapesPainted
    read f_ShapesPainted;
   property Shape: InevObject
    read pm_GetShape;
 end;//TnevBaseView

implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
;

function TnevBaseView.pm_GetShape: InevObject;
//#UC START# *4811D60B0043_4811D544006Fget_var*
//#UC END# *4811D60B0043_4811D544006Fget_var*
begin
//#UC START# *4811D60B0043_4811D544006Fget_impl*
 Result := nil;
//#UC END# *4811D60B0043_4811D544006Fget_impl*
end;//TnevBaseView.pm_GetShape

function TnevBaseView.pm_GetActiveElementPrim: InevActiveElement;
//#UC START# *4A27CFD20374_4811D544006Fget_var*
//#UC END# *4A27CFD20374_4811D544006Fget_var*
begin
//#UC START# *4A27CFD20374_4811D544006Fget_impl*
 Result := nil;
//#UC END# *4A27CFD20374_4811D544006Fget_impl*
end;//TnevBaseView.pm_GetActiveElementPrim

function TnevBaseView.pm_GetForceDrawFocusRectPrim: Boolean;
//#UC START# *4B59AC930100_4811D544006Fget_var*
//#UC END# *4B59AC930100_4811D544006Fget_var*
begin
//#UC START# *4B59AC930100_4811D544006Fget_impl*
 Result := false;
//#UC END# *4B59AC930100_4811D544006Fget_impl*
end;//TnevBaseView.pm_GetForceDrawFocusRectPrim

function TnevBaseView.pm_GetIsObjectCollapsed(const anObject: InevObject): Boolean;
//#UC START# *4D5A46930182_4811D544006Fget_var*
//#UC END# *4D5A46930182_4811D544006Fget_var*
begin
//#UC START# *4D5A46930182_4811D544006Fget_impl*
 Result := anObject.AsObject.BoolA[k2_tiCollapsed];
//#UC END# *4D5A46930182_4811D544006Fget_impl*
end;//TnevBaseView.pm_GetIsObjectCollapsed

procedure TnevBaseView.pm_SetIsObjectCollapsed(const anObject: InevObject;
 aValue: Boolean);
//#UC START# *4D5A46930182_4811D544006Fset_var*
//#UC END# *4D5A46930182_4811D544006Fset_var*
begin
//#UC START# *4D5A46930182_4811D544006Fset_impl*
 anObject.AsObject.BoolA[k2_tiCollapsed] := aValue;
 anObject.Invalidate([nev_spExtent]);
 anObject.OwnerObj.Invalidate([nev_spExtent]);
 if f_Holder <> nil then
  InevObjectHolder(f_Holder).UpdatePreview;
//#UC END# *4D5A46930182_4811D544006Fset_impl*
end;//TnevBaseView.pm_SetIsObjectCollapsed

{$If Defined(evNeedCollapsedVersionComments)}
procedure TnevBaseView.DoVersionInfoVisabilityChanged(aValue: Boolean);
//#UC START# *4D5A4707033B_4811D544006F_var*
//#UC END# *4D5A4707033B_4811D544006F_var*
begin
//#UC START# *4D5A4707033B_4811D544006F_impl*
 // - ничего не делаем
//#UC END# *4D5A4707033B_4811D544006F_impl*
end;//TnevBaseView.DoVersionInfoVisabilityChanged
{$IfEnd} // Defined(evNeedCollapsedVersionComments)

procedure TnevBaseView.DoInvalidateShape(const aShape: InevObject;
 aParts: TnevShapeParts);
//#UC START# *4811D78A01A1_4811D544006F_var*
//#UC END# *4811D78A01A1_4811D544006F_var*
begin
//#UC START# *4811D78A01A1_4811D544006F_impl*
 // - ничего не делаем
//#UC END# *4811D78A01A1_4811D544006F_impl*
end;//TnevBaseView.DoInvalidateShape

constructor TnevBaseView.Create;
//#UC START# *4811D7AF02B6_4811D544006F_var*
//#UC END# *4811D7AF02B6_4811D544006F_var*
begin
//#UC START# *4811D7AF02B6_4811D544006F_impl*
 f_Level := 0;
 inherited Create;
 f_ShapesPainted := TnevShapesPainted.Create(Self);
//#UC END# *4811D7AF02B6_4811D544006F_impl*
end;//TnevBaseView.Create

function TnevBaseView.DoGetMetrics: InevViewMetrics;
//#UC START# *4811D7DC0254_4811D544006F_var*
//#UC END# *4811D7DC0254_4811D544006F_var*
begin
//#UC START# *4811D7DC0254_4811D544006F_impl*
 Result := nil;
//#UC END# *4811D7DC0254_4811D544006F_impl*
end;//TnevBaseView.DoGetMetrics

function TnevBaseView.DoGetProcessor: InevProcessor;
//#UC START# *4811D8210302_4811D544006F_var*
//#UC END# *4811D8210302_4811D544006F_var*
begin
//#UC START# *4811D8210302_4811D544006F_impl*
 Result := nil;
//#UC END# *4811D8210302_4811D544006F_impl*
end;//TnevBaseView.DoGetProcessor

procedure TnevBaseView.ClearShapesPrim;
//#UC START# *4811D8A502DE_4811D544006F_var*
//#UC END# *4811D8A502DE_4811D544006F_var*
begin
//#UC START# *4811D8A502DE_4811D544006F_impl*
 if (f_ShapesPainted <> nil) then
  DoClearShapes(false);
//#UC END# *4811D8A502DE_4811D544006F_impl*
end;//TnevBaseView.ClearShapesPrim

procedure TnevBaseView.DoClearShapes(aNeedClearMax: Boolean);
 {* очищает список отображаемых форм. }
//#UC START# *4811DAA70258_4811D544006F_var*
//#UC END# *4811DAA70258_4811D544006F_var*
begin
//#UC START# *4811DAA70258_4811D544006F_impl*
 Assert(f_Level = 0);
 if (f_ShapesPainted <> nil) then
 begin
  if aNeedClearMax then
   f_ShapesPainted.ClearEx
  else
   f_ShapesPainted.Clear;
 end;//f_ShapesPainted <> nil
//#UC END# *4811DAA70258_4811D544006F_impl*
end;//TnevBaseView.DoClearShapes

procedure TnevBaseView.DoBeginDrawShape(const aShape: InevObject;
 const anAnchor: InevBasePoint;
 const anOrg: TnevPoint;
 var theMap: InevMap;
 aFake: Boolean;
 const aHacker: InevK235870994Hacker);
//#UC START# *4811DB8A0323_4811D544006F_var*
//#UC END# *4811DB8A0323_4811D544006F_var*
begin
//#UC START# *4811DB8A0323_4811D544006F_impl*
 f_ShapesPainted.BeginDraw(aShape, anAnchor, anOrg, theMap, aFake, aHacker);
//#UC END# *4811DB8A0323_4811D544006F_impl*
end;//TnevBaseView.DoBeginDrawShape

function TnevBaseView.GetRootFormatInfo: TnevFormatInfoPrim;
//#UC START# *481DA04D0324_4811D544006F_var*

 procedure FillHolder;
 var
  l_Data : InevObject;
  l_H    : InevObjectHolder;
 begin//FillHolder
  l_Data := Data;
  if (l_Data = nil) then
  // - т.к. такое может быть при инициализации курсора
  // http://mdp.garant.ru/pages/viewpage.action?pageId=287219002
  // ОТВЕТСТВЕННОСТЬ НА СЕБЯ взял Головин http://mdp.garant.ru/pages/viewpage.action?pageId=287219002&focusedCommentId=288010300#comment-288010300
   Exit;
  Assert(l_Data <> nil);
  l_H := l_Data.Holder;
  Assert(l_H <> nil);
  f_Holder := Pointer(l_H);
 end;//FillHolder

//#UC END# *481DA04D0324_4811D544006F_var*
begin
//#UC START# *481DA04D0324_4811D544006F_impl*
 if (f_Holder = nil) then
  FillHolder;
 if (f_Holder = nil) then
  Result := nil
 else
  Result := InevObjectHolder(f_Holder).FormatPool.FormatInfoForView(Self);
//#UC END# *481DA04D0324_4811D544006F_impl*
end;//TnevBaseView.GetRootFormatInfo

function TnevBaseView.pm_GetMetrics: InevViewMetrics;
//#UC START# *47C5B99001C4_4811D544006Fget_var*
//#UC END# *47C5B99001C4_4811D544006Fget_var*
begin
//#UC START# *47C5B99001C4_4811D544006Fget_impl*
 Result := DoGetMetrics;
//#UC END# *47C5B99001C4_4811D544006Fget_impl*
end;//TnevBaseView.pm_GetMetrics

function TnevBaseView.Data: InevObject;
//#UC START# *47C5B9A30018_4811D544006F_var*
//#UC END# *47C5B9A30018_4811D544006F_var*
begin
//#UC START# *47C5B9A30018_4811D544006F_impl*
 Result := Shape;
//#UC END# *47C5B9A30018_4811D544006F_impl*
end;//TnevBaseView.Data

function TnevBaseView.RootMap: InevMap;
//#UC START# *47C5B9AA03E1_4811D544006F_var*
//#UC END# *47C5B9AA03E1_4811D544006F_var*
begin
//#UC START# *47C5B9AA03E1_4811D544006F_impl*
 if (f_ShapesPainted = nil) then
  Result := nil
 else
 begin
  Assert(f_ShapesPainted <> nil);
  Result := f_ShapesPainted.Root;
 end;//f_ShapesPainted = nil
//#UC END# *47C5B9AA03E1_4811D544006F_impl*
end;//TnevBaseView.RootMap

function TnevBaseView.Processor: InevProcessor;
//#UC START# *47C5B9B202F0_4811D544006F_var*
//#UC END# *47C5B9B202F0_4811D544006F_var*
begin
//#UC START# *47C5B9B202F0_4811D544006F_impl*
 Result := DoGetProcessor;
//#UC END# *47C5B9B202F0_4811D544006F_impl*
end;//TnevBaseView.Processor

procedure TnevBaseView.ClearShapes;
//#UC START# *47C5B9C301B9_4811D544006F_var*
//#UC END# *47C5B9C301B9_4811D544006F_var*
begin
//#UC START# *47C5B9C301B9_4811D544006F_impl*
 ClearShapesPrim;
//#UC END# *47C5B9C301B9_4811D544006F_impl*
end;//TnevBaseView.ClearShapes

procedure TnevBaseView.BeginDrawShape(const aShape: InevObject;
 const anAnchor: InevBasePoint;
 const anOrg: TnevPoint;
 var theMap: InevMap;
 aFake: Boolean;
 const aHacker: InevK235870994Hacker);
 {* Начинает добавление формы в список. }
//#UC START# *47C5B9DB0136_4811D544006F_var*
//#UC END# *47C5B9DB0136_4811D544006F_var*
begin
//#UC START# *47C5B9DB0136_4811D544006F_impl*
 Inc(f_Level);
 try
  DoBeginDrawShape(aShape, anAnchor, anOrg, theMap, aFake, aHacker);
 except
  Dec(f_Level);
  raise;
 end;//try..except
//#UC END# *47C5B9DB0136_4811D544006F_impl*
end;//TnevBaseView.BeginDrawShape

procedure TnevBaseView.EndDrawShape;
 {* Заканчивает добавление формы в список. }
//#UC START# *47C5B9FB03D1_4811D544006F_var*
//#UC END# *47C5B9FB03D1_4811D544006F_var*
begin
//#UC START# *47C5B9FB03D1_4811D544006F_impl*
 f_ShapesPainted.EndDraw;
 Dec(f_Level);
//#UC END# *47C5B9FB03D1_4811D544006F_impl*
end;//TnevBaseView.EndDrawShape

function TnevBaseView.MapByPoint(const aPoint: InevBasePoint;
 aCheckTopVisible: Boolean = False): InevMap;
//#UC START# *47C5BA240004_4811D544006F_var*
//#UC END# *47C5BA240004_4811D544006F_var*
begin
//#UC START# *47C5BA240004_4811D544006F_impl*
 Result := f_ShapesPainted.MapByPoint(aPoint, aCheckTopVisible);
//#UC END# *47C5BA240004_4811D544006F_impl*
end;//TnevBaseView.MapByPoint

function TnevBaseView.FormatInfoByPoint(const aPoint: InevBasePoint): TnevFormatInfoPrim;
//#UC START# *481078F302DD_4811D544006F_var*
var
 l_Point : InevBasePoint;
 l_Inner : InevBasePoint;
 l_FI    : TnevFormatInfoPrim;
 l_Obj   : PInevObject;
 l_SC    : Boolean;
// l_Map : InevMap;
//#UC END# *481078F302DD_4811D544006F_var*
begin
//#UC START# *481078F302DD_4811D544006F_impl*
 Result := nil;
 l_Obj := aPoint.Obj;
 l_Point := aPoint.{ClonePoint(Self).Point(Self).}PointToParent(Shape);
 // - нельзя снимать копию - получим бесконечную рекурсию - http://mdp.garant.ru/pages/viewpage.action?pageId=90450554
 l_FI := RootFormatInfo;
 if (l_FI = nil) then
 // - такое может быть, когда инициализиреутся начальный курсор
 // http://mdp.garant.ru/pages/viewpage.action?pageId=287219002
 // ОТВЕТСТВЕННОСТЬ НА СЕБЯ взял Головин http://mdp.garant.ru/pages/viewpage.action?pageId=287219002&focusedCommentId=288010300#comment-288010300
  Exit;
 while (l_Point <> nil) do
 begin
  if l_Point.Obj.AsObject.IsSame(l_Obj^.AsObject) then
  begin
   Result := l_FI; 
   break;
  end;//l_Point.Obj.IsSame(l_Obj
  l_SC := l_Point.ShowCollapsed;
  try
   l_Point.ShowCollapsed := true;
   l_Inner := l_Point.Inner;
  finally
   l_Point.ShowCollapsed := l_SC;
  end;//try..finally
  l_Point := l_Inner;
  if (l_Point <> nil) and Assigned(l_FI) then
   l_FI := l_FI.InfoForChild(l_Point.Obj^);
 end;//while (l_Point <> nil)
(* l_Map := f_ShapesPainted.MapByPoint(aPoint);
 if (l_Map = nil) then
  Result := nil
 else
  Result := l_Map.FI;*)
//#UC END# *481078F302DD_4811D544006F_impl*
end;//TnevBaseView.FormatInfoByPoint

function TnevBaseView.RootFormatInfo: TnevFormatInfoPrim;
//#UC START# *4811BA6C005A_4811D544006F_var*
//#UC END# *4811BA6C005A_4811D544006F_var*
begin
//#UC START# *4811BA6C005A_4811D544006F_impl*
 Result := GetRootFormatInfo;
//#UC END# *4811BA6C005A_4811D544006F_impl*
end;//TnevBaseView.RootFormatInfo

procedure TnevBaseView.InvalidateShape(const aShape: InevObject;
 aParts: TnevShapeParts);
//#UC START# *4816E2B2004E_4811D544006F_var*
//#UC END# *4816E2B2004E_4811D544006F_var*
begin
//#UC START# *4816E2B2004E_4811D544006F_impl*
 DoInvalidateShape(aShape, aParts);
//#UC END# *4816E2B2004E_4811D544006F_impl*
end;//TnevBaseView.InvalidateShape

function TnevBaseView.Get_ActiveElement: InevActiveElement;
//#UC START# *4A27CEB10364_4811D544006Fget_var*
//#UC END# *4A27CEB10364_4811D544006Fget_var*
begin
//#UC START# *4A27CEB10364_4811D544006Fget_impl*
 Result := ActiveElementPrim;
//#UC END# *4A27CEB10364_4811D544006Fget_impl*
end;//TnevBaseView.Get_ActiveElement

function TnevBaseView.Get_ForceDrawFocusRect: Boolean;
//#UC START# *4B59A96702D9_4811D544006Fget_var*
//#UC END# *4B59A96702D9_4811D544006Fget_var*
begin
//#UC START# *4B59A96702D9_4811D544006Fget_impl*
 Result := ForceDrawFocusRectPrim;
//#UC END# *4B59A96702D9_4811D544006Fget_impl*
end;//TnevBaseView.Get_ForceDrawFocusRect

function TnevBaseView.Get_IsObjectCollapsed(const anObject: InevObject): Boolean;
//#UC START# *4D5A3DD60219_4811D544006Fget_var*
//#UC END# *4D5A3DD60219_4811D544006Fget_var*
begin
//#UC START# *4D5A3DD60219_4811D544006Fget_impl*
 Result := Self.IsObjectCollapsed[anObject];
//#UC END# *4D5A3DD60219_4811D544006Fget_impl*
end;//TnevBaseView.Get_IsObjectCollapsed

procedure TnevBaseView.Set_IsObjectCollapsed(const anObject: InevObject;
 aValue: Boolean);
//#UC START# *4D5A3DD60219_4811D544006Fset_var*
//#UC END# *4D5A3DD60219_4811D544006Fset_var*
begin
//#UC START# *4D5A3DD60219_4811D544006Fset_impl*
 Self.IsObjectCollapsed[anObject] := aValue;
//#UC END# *4D5A3DD60219_4811D544006Fset_impl*
end;//TnevBaseView.Set_IsObjectCollapsed

{$If Defined(evNeedCollapsedVersionComments)}
procedure TnevBaseView.VersionInfoVisabilityChanged(aValue: Boolean);
//#UC START# *4D5A3E3E01B7_4811D544006F_var*
//#UC END# *4D5A3E3E01B7_4811D544006F_var*
begin
//#UC START# *4D5A3E3E01B7_4811D544006F_impl*
 DoVersionInfoVisabilityChanged(aValue);
//#UC END# *4D5A3E3E01B7_4811D544006F_impl*
end;//TnevBaseView.VersionInfoVisabilityChanged
{$IfEnd} // Defined(evNeedCollapsedVersionComments)

function TnevBaseView.FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim;
//#UC START# *4E6F8ED402EF_4811D544006F_var*
//#UC END# *4E6F8ED402EF_4811D544006F_var*
begin
//#UC START# *4E6F8ED402EF_4811D544006F_impl*
 Result := FormatInfoByPoint(aPara.MakePoint);
//#UC END# *4E6F8ED402EF_4811D544006F_impl*
end;//TnevBaseView.FormatInfoByPara

function TnevBaseView.FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
//#UC START# *4E6F8EF302A4_4811D544006F_var*
var
 l_Para : InevObject;
//#UC END# *4E6F8EF302A4_4811D544006F_var*
begin
//#UC START# *4E6F8EF302A4_4811D544006F_impl*
 if not anObj.AsObject.QT(InevObject, l_Para) then
  Assert(false);
 Result := FormatInfoByPara(l_Para);
//#UC END# *4E6F8EF302A4_4811D544006F_impl*
end;//TnevBaseView.FormatInfoByObj

function TnevBaseView.FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim;
//#UC START# *4E6F98080175_4811D544006F_var*
//#UC END# *4E6F98080175_4811D544006F_var*
begin
//#UC START# *4E6F98080175_4811D544006F_impl*
 Result := FormatInfoByPoint(aPara.MakePoint);
//#UC END# *4E6F98080175_4811D544006F_impl*
end;//TnevBaseView.FormatInfoByPara

procedure TnevBaseView.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4811D544006F_var*
//#UC END# *479731C50290_4811D544006F_var*
begin
//#UC START# *479731C50290_4811D544006F_impl*
 f_Holder := nil;
 FreeAndNil(f_ShapesPainted);
 inherited;
//#UC END# *479731C50290_4811D544006F_impl*
end;//TnevBaseView.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function TnevBaseView.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4811D544006F_var*
//#UC END# *47A6FEE600FC_4811D544006F_var*
begin
//#UC START# *47A6FEE600FC_4811D544006F_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4811D544006F_impl*
end;//TnevBaseView.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
