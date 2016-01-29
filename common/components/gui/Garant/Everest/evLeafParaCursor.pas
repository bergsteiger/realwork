unit evLeafParaCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evLeafParaCursor.pas"
// Начат: 16.10.2003 17:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TevLeafParaCursor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  nevBase,
  nevTools,
  evParaCursor
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevLeafParaCursor = class(TevParaCursor, InevLeafPoint)
 private
 // private fields
   f_Map : TnevFormatInfoPrim;
 protected
 // realized methods
   procedure InitPointByPt(const aView: InevView;
     const aPoint: TnevPoint;
     const aMap: InevMap);
 public
 // realized methods
   function PaintOffsetY(const aView: InevView;
     aMap: TnevFormatInfoPrim): Integer;
 protected
 // overridden property methods
   function pm_GetAsLeaf: InevLeafPoint; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function IsLeaf: Boolean; override;
     {* Курсор от листьевого параграфа }
   function DoMovePrim(const aView: InevView;
    aCode: Integer;
    const anOp: InevOp;
    aCount: Integer): TnevMoveResult; override;
 protected
 // protected methods
   function ObjMap(const aView: InevView): TnevFormatInfoPrim;
   function GetPaintOffsetY(const aView: InevView;
    aMap: TnevFormatInfoPrim): Integer; virtual;
   procedure DoInitPointByPt(const aView: InevView;
    const aPoint: TnevPoint;
    const aMap: InevMap); virtual;
 end;//TevLeafParaCursor
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  evOp,
  SysUtils
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

// start class TevLeafParaCursor

function TevLeafParaCursor.ObjMap(const aView: InevView): TnevFormatInfoPrim;
//#UC START# *49DF74B0005C_49DF6D540096_var*
//#UC END# *49DF74B0005C_49DF6D540096_var*
begin
//#UC START# *49DF74B0005C_49DF6D540096_impl*
 if (f_Map <> nil) then
 begin
  if (f_Map.ParentInfo = nil) then
   FreeAndNil(f_Map);
   // - надо будет переполучить форматирование, ибо, то, что мы запомнили - "битое"
 end;//f_Map <> nil
 if (f_Map = nil) then
 begin
  if (aView <> nil) then
  begin
   aView.FormatInfoByPoint(Self).SetRefTo(f_Map);
   Assert((f_Map = nil) OR (f_Map.ParentInfo <> nil));
  end;//aView <> nil
 end;//f_Map = nil
 Result := f_Map;
//#UC END# *49DF74B0005C_49DF6D540096_impl*
end;//TevLeafParaCursor.ObjMap

function TevLeafParaCursor.GetPaintOffsetY(const aView: InevView;
  aMap: TnevFormatInfoPrim): Integer;
//#UC START# *49DF6F2F0190_49DF6D540096_var*
//#UC END# *49DF6F2F0190_49DF6D540096_var*
begin
//#UC START# *49DF6F2F0190_49DF6D540096_impl*
 Result := 0;
//#UC END# *49DF6F2F0190_49DF6D540096_impl*
end;//TevLeafParaCursor.GetPaintOffsetY

procedure TevLeafParaCursor.DoInitPointByPt(const aView: InevView;
  const aPoint: TnevPoint;
  const aMap: InevMap);
//#UC START# *49DF703901BA_49DF6D540096_var*
//#UC END# *49DF703901BA_49DF6D540096_var*
begin
//#UC START# *49DF703901BA_49DF6D540096_impl*
 Assert(aMap <> nil);
 aMap.FI.SetRefTo(f_Map);
//#UC END# *49DF703901BA_49DF6D540096_impl*
end;//TevLeafParaCursor.DoInitPointByPt

procedure TevLeafParaCursor.InitPointByPt(const aView: InevView;
  const aPoint: TnevPoint;
  const aMap: InevMap);
//#UC START# *47FB320102A6_49DF6D540096_var*
//#UC END# *47FB320102A6_49DF6D540096_var*
begin
//#UC START# *47FB320102A6_49DF6D540096_impl*
 DoInitPointByPt(aView, aPoint, aMap);
//#UC END# *47FB320102A6_49DF6D540096_impl*
end;//TevLeafParaCursor.InitPointByPt

function TevLeafParaCursor.PaintOffsetY(const aView: InevView;
  aMap: TnevFormatInfoPrim): Integer;
//#UC START# *4A5CDCAC0230_49DF6D540096_var*
//#UC END# *4A5CDCAC0230_49DF6D540096_var*
begin
//#UC START# *4A5CDCAC0230_49DF6D540096_impl*
 Result := GetPaintOffsetY(aView, aMap);
//#UC END# *4A5CDCAC0230_49DF6D540096_impl*
end;//TevLeafParaCursor.PaintOffsetY

procedure TevLeafParaCursor.Cleanup;
//#UC START# *479731C50290_49DF6D540096_var*
//#UC END# *479731C50290_49DF6D540096_var*
begin
//#UC START# *479731C50290_49DF6D540096_impl*
 FreeAndNil(f_Map);
 inherited;
//#UC END# *479731C50290_49DF6D540096_impl*
end;//TevLeafParaCursor.Cleanup

function TevLeafParaCursor.pm_GetAsLeaf: InevLeafPoint;
//#UC START# *49DF741401DF_49DF6D540096get_var*
//#UC END# *49DF741401DF_49DF6D540096get_var*
begin
//#UC START# *49DF741401DF_49DF6D540096get_impl*
 Result := Self;
//#UC END# *49DF741401DF_49DF6D540096get_impl*
end;//TevLeafParaCursor.pm_GetAsLeaf

function TevLeafParaCursor.IsLeaf: Boolean;
//#UC START# *49E3153B017D_49DF6D540096_var*
//#UC END# *49E3153B017D_49DF6D540096_var*
begin
//#UC START# *49E3153B017D_49DF6D540096_impl*
 Result := true;
//#UC END# *49E3153B017D_49DF6D540096_impl*
end;//TevLeafParaCursor.IsLeaf

function TevLeafParaCursor.DoMovePrim(const aView: InevView;
  aCode: Integer;
  const anOp: InevOp;
  aCount: Integer): TnevMoveResult;
//#UC START# *49E31657038E_49DF6D540096_var*
//#UC END# *49E31657038E_49DF6D540096_var*
begin
//#UC START# *49E31657038E_49DF6D540096_impl*
 Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
 if (Result = ev_dcNotDone) AND (Self.pm_GetParentPoint <> nil) then
  Case aCode of
   ev_ocParaUp,
   ev_ocParaDown,
   ev_ocParaLeft,
   ev_ocParaRight,
   ev_ocPrevParaBottomRight,
   ev_ocNextParaTopLeft,
   ev_ocPrevParaBottomRightInThisBlock,
   ev_ocParaDownWithEmptyRow:
    Result := Self.pm_GetParentPoint.DoMove(aView, aCode, anOp, aCount);
  end;//Case aCode
//#UC END# *49E31657038E_49DF6D540096_impl*
end;//TevLeafParaCursor.DoMovePrim

{$IfEnd} //evUseVisibleCursors

end.