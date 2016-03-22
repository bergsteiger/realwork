unit nevBaseDetachedView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Лукьянец Р.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevBaseDetachedView.pas"
// Начат: 22.10.2007 14:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Views::TnevBaseDetachedView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevBase,
  evdStyles,
  nevTools,
  nevBaseView,
  l3Variant
  ;

type
 _nevDocumentContainerDecorationRules_Parent_ = TnevBaseView;
 {$Include w:\common\components\gui\Garant\Everest\nevDocumentContainerDecorationRules.imp.pas}
 TnevBaseDetachedView = class(_nevDocumentContainerDecorationRules_, InevViewMetrics)
 private
 // private fields
   f_Text : Pointer;
   f_Canvas : InevCanvas;
    {* Поле для свойства Canvas}
 protected
 // realized methods
   function pm_GetLimitWidth: TnevInch;
   function pm_GetInfoCanvas: InevInfoCanvas;
   function pm_GetIsWebStyle: Boolean;
   function pm_GetShowDocumentParts: Boolean;
   function pm_GetShowSpecial: Boolean;
   function pm_GetHiddenStyles: TnevStandardStyles;
   function pm_GetExtent: TnevPoint;
   function Get_ExcludeSuper: TevNormalSegLayerHandleSet;
   function Get_FormatCanvas: InevInfoCanvas;
   function Get_AllowRubberTables: TnevRubberTablesMode;
   function IsTagCollapsed(aTag: Tl3Variant): Boolean;
   function Get_Data: InevObjectPrim;
   function Get_AACLike: TnevAACLikeMode;
   function NeedTotalRecalc: Boolean;
 protected
 // overridden property methods
   function pm_GetShape: InevObject; override;
   function pm_GetIsObjectCollapsed(const anObject: InevObject): Boolean; override;
   procedure pm_SetIsObjectCollapsed(const anObject: InevObject; aValue: Boolean); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function DoGetMetrics: InevViewMetrics; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected fields
   f_LimitWidth : Integer;
 protected
 // protected methods
   function DoGetExcludeSuper: TevNormalSegLayerHandleSet; virtual;
   function GetNeedTotalRecalc: Boolean; virtual;
   function GetIsWebStyle: Boolean; virtual;
   function GetShowDocumentParts: Boolean; virtual;
   function GetShowSpecial: Boolean; virtual;
   function GetHiddenStyles: TevStandardStyles; virtual;
   function GetLimitWidth: Integer; virtual;
   function GetAllowRubberTables: TnevRubberTablesMode; virtual;
 public
 // public methods
   constructor Create(const aText: InevObject;
     const aCanvas: InevCanvas); reintroduce;
   class function Make(const aText: InevObject;
     const aCanvas: InevCanvas): InevView; reintroduce;
     {* Сигнатура фабрики TnevBaseDetachedView.Make }
 protected
 // protected properties
   property Canvas: InevCanvas
     read f_Canvas;
 end;//TnevBaseDetachedView

implementation

uses
  k2Tags,
  k2Facade,
  k2Base,
  TextPara_Const
  ;

{$Include w:\common\components\gui\Garant\Everest\nevDocumentContainerDecorationRules.imp.pas}

// start class TnevBaseDetachedView

constructor TnevBaseDetachedView.Create(const aText: InevObject;
  const aCanvas: InevCanvas);
//#UC START# *4CB5BDF6031A_48120C1C0060_var*
//#UC END# *4CB5BDF6031A_48120C1C0060_var*
begin
//#UC START# *4CB5BDF6031A_48120C1C0060_impl*
 inherited Create;
 f_Canvas := aCanvas;
 f_Text := Pointer(aText);
//#UC END# *4CB5BDF6031A_48120C1C0060_impl*
end;//TnevBaseDetachedView.Create

class function TnevBaseDetachedView.Make(const aText: InevObject;
  const aCanvas: InevCanvas): InevView;
var
 l_Inst : TnevBaseDetachedView;
begin
 l_Inst := Create(aText, aCanvas);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnevBaseDetachedView.DoGetExcludeSuper: TevNormalSegLayerHandleSet;
//#UC START# *4F66FDB60040_48120C1C0060_var*
//#UC END# *4F66FDB60040_48120C1C0060_var*
begin
//#UC START# *4F66FDB60040_48120C1C0060_impl*
 Result := [];
//#UC END# *4F66FDB60040_48120C1C0060_impl*
end;//TnevBaseDetachedView.DoGetExcludeSuper

function TnevBaseDetachedView.GetNeedTotalRecalc: Boolean;
//#UC START# *565F0492012D_48120C1C0060_var*
//#UC END# *565F0492012D_48120C1C0060_var*
begin
//#UC START# *565F0492012D_48120C1C0060_impl*
 Result := false;
//#UC END# *565F0492012D_48120C1C0060_impl*
end;//TnevBaseDetachedView.GetNeedTotalRecalc

function TnevBaseDetachedView.GetIsWebStyle: Boolean;
//#UC START# *48120CED0107_48120C1C0060_var*
//#UC END# *48120CED0107_48120C1C0060_var*
begin
//#UC START# *48120CED0107_48120C1C0060_impl*
 Result := false;
//#UC END# *48120CED0107_48120C1C0060_impl*
end;//TnevBaseDetachedView.GetIsWebStyle

function TnevBaseDetachedView.GetShowDocumentParts: Boolean;
//#UC START# *48120D0300D4_48120C1C0060_var*
//#UC END# *48120D0300D4_48120C1C0060_var*
begin
//#UC START# *48120D0300D4_48120C1C0060_impl*
 Result := false;
//#UC END# *48120D0300D4_48120C1C0060_impl*
end;//TnevBaseDetachedView.GetShowDocumentParts

function TnevBaseDetachedView.GetShowSpecial: Boolean;
//#UC START# *48120D270114_48120C1C0060_var*
//#UC END# *48120D270114_48120C1C0060_var*
begin
//#UC START# *48120D270114_48120C1C0060_impl*
 Result := false;
//#UC END# *48120D270114_48120C1C0060_impl*
end;//TnevBaseDetachedView.GetShowSpecial

function TnevBaseDetachedView.GetHiddenStyles: TevStandardStyles;
//#UC START# *48120D32035F_48120C1C0060_var*
//#UC END# *48120D32035F_48120C1C0060_var*
begin
//#UC START# *48120D32035F_48120C1C0060_impl*
 Result := [];
//#UC END# *48120D32035F_48120C1C0060_impl*
end;//TnevBaseDetachedView.GetHiddenStyles

function TnevBaseDetachedView.GetLimitWidth: Integer;
//#UC START# *48121CB0013E_48120C1C0060_var*
//#UC END# *48121CB0013E_48120C1C0060_var*
begin
//#UC START# *48121CB0013E_48120C1C0060_impl*
 if (f_Text = nil) then
  Result := High(Result)
 else
 begin
  if (f_LimitWidth = 0) then
   f_LimitWidth := {_InevTag}InevObject(f_Text).AsObject.IntA[k2_tiWidth];
  Result := f_LimitWidth;
 end;//f_Text = nil
//#UC END# *48121CB0013E_48120C1C0060_impl*
end;//TnevBaseDetachedView.GetLimitWidth

function TnevBaseDetachedView.GetAllowRubberTables: TnevRubberTablesMode;
//#UC START# *4BED6EF003DD_48120C1C0060_var*
//#UC END# *4BED6EF003DD_48120C1C0060_var*
begin
//#UC START# *4BED6EF003DD_48120C1C0060_impl*
 Result := nev_rtmNone;
//#UC END# *4BED6EF003DD_48120C1C0060_impl*
end;//TnevBaseDetachedView.GetAllowRubberTables

function TnevBaseDetachedView.pm_GetLimitWidth: TnevInch;
//#UC START# *476BFB3C007A_48120C1C0060get_var*
//#UC END# *476BFB3C007A_48120C1C0060get_var*
begin
//#UC START# *476BFB3C007A_48120C1C0060get_impl*
 Result := GetLimitWidth;
//#UC END# *476BFB3C007A_48120C1C0060get_impl*
end;//TnevBaseDetachedView.pm_GetLimitWidth

function TnevBaseDetachedView.pm_GetInfoCanvas: InevInfoCanvas;
//#UC START# *476BFBE10164_48120C1C0060get_var*
//#UC END# *476BFBE10164_48120C1C0060get_var*
begin
//#UC START# *476BFBE10164_48120C1C0060get_impl*
 Result := f_Canvas;
//#UC END# *476BFBE10164_48120C1C0060get_impl*
end;//TnevBaseDetachedView.pm_GetInfoCanvas

function TnevBaseDetachedView.pm_GetIsWebStyle: Boolean;
//#UC START# *476BFC120188_48120C1C0060get_var*
//#UC END# *476BFC120188_48120C1C0060get_var*
begin
//#UC START# *476BFC120188_48120C1C0060get_impl*
 Result := GetIsWebStyle;
//#UC END# *476BFC120188_48120C1C0060get_impl*
end;//TnevBaseDetachedView.pm_GetIsWebStyle

function TnevBaseDetachedView.pm_GetShowDocumentParts: Boolean;
//#UC START# *476BFC2101FB_48120C1C0060get_var*
//#UC END# *476BFC2101FB_48120C1C0060get_var*
begin
//#UC START# *476BFC2101FB_48120C1C0060get_impl*
 Result := GetShowDocumentParts;
//#UC END# *476BFC2101FB_48120C1C0060get_impl*
end;//TnevBaseDetachedView.pm_GetShowDocumentParts

function TnevBaseDetachedView.pm_GetShowSpecial: Boolean;
//#UC START# *476BFC34010B_48120C1C0060get_var*
//#UC END# *476BFC34010B_48120C1C0060get_var*
begin
//#UC START# *476BFC34010B_48120C1C0060get_impl*
 Result := GetShowSpecial;
//#UC END# *476BFC34010B_48120C1C0060get_impl*
end;//TnevBaseDetachedView.pm_GetShowSpecial

function TnevBaseDetachedView.pm_GetHiddenStyles: TnevStandardStyles;
//#UC START# *476BFC420000_48120C1C0060get_var*
//#UC END# *476BFC420000_48120C1C0060get_var*
begin
//#UC START# *476BFC420000_48120C1C0060get_impl*
 Result := GetHiddenStyles;
//#UC END# *476BFC420000_48120C1C0060get_impl*
end;//TnevBaseDetachedView.pm_GetHiddenStyles

function TnevBaseDetachedView.pm_GetExtent: TnevPoint;
//#UC START# *486D2C6702FA_48120C1C0060get_var*
//#UC END# *486D2C6702FA_48120C1C0060get_var*
begin
//#UC START# *486D2C6702FA_48120C1C0060get_impl*
 FillChar(Result, SizeOf(Result), 0);
//#UC END# *486D2C6702FA_48120C1C0060get_impl*
end;//TnevBaseDetachedView.pm_GetExtent

function TnevBaseDetachedView.Get_ExcludeSuper: TevNormalSegLayerHandleSet;
//#UC START# *4AEAE49B024D_48120C1C0060get_var*
//#UC END# *4AEAE49B024D_48120C1C0060get_var*
begin
//#UC START# *4AEAE49B024D_48120C1C0060get_impl*
 Result := DoGetExcludeSuper;
//#UC END# *4AEAE49B024D_48120C1C0060get_impl*
end;//TnevBaseDetachedView.Get_ExcludeSuper

function TnevBaseDetachedView.Get_FormatCanvas: InevInfoCanvas;
//#UC START# *4B7E744702C0_48120C1C0060get_var*
//#UC END# *4B7E744702C0_48120C1C0060get_var*
begin
//#UC START# *4B7E744702C0_48120C1C0060get_impl*
 Result := f_Canvas;
//#UC END# *4B7E744702C0_48120C1C0060get_impl*
end;//TnevBaseDetachedView.Get_FormatCanvas

function TnevBaseDetachedView.Get_AllowRubberTables: TnevRubberTablesMode;
//#UC START# *4BED6E9300FD_48120C1C0060get_var*
//#UC END# *4BED6E9300FD_48120C1C0060get_var*
begin
//#UC START# *4BED6E9300FD_48120C1C0060get_impl*
 Result := GetAllowRubberTables;
//#UC END# *4BED6E9300FD_48120C1C0060get_impl*
end;//TnevBaseDetachedView.Get_AllowRubberTables

function TnevBaseDetachedView.IsTagCollapsed(aTag: Tl3Variant): Boolean;
//#UC START# *4D5A80DC029D_48120C1C0060_var*
var
 l_Obj : InevObject;
//#UC END# *4D5A80DC029D_48120C1C0060_var*
begin
//#UC START# *4D5A80DC029D_48120C1C0060_impl*
 if not aTag.QT(InevObject, l_Obj) then
  Assert(false);
 Result := Self.IsObjectCollapsed[l_Obj];
//#UC END# *4D5A80DC029D_48120C1C0060_impl*
end;//TnevBaseDetachedView.IsTagCollapsed

function TnevBaseDetachedView.Get_Data: InevObjectPrim;
//#UC START# *4E5E285C0166_48120C1C0060get_var*
//#UC END# *4E5E285C0166_48120C1C0060get_var*
begin
//#UC START# *4E5E285C0166_48120C1C0060get_impl*
 Result := pm_GetShape;
//#UC END# *4E5E285C0166_48120C1C0060get_impl*
end;//TnevBaseDetachedView.Get_Data

function TnevBaseDetachedView.Get_AACLike: TnevAACLikeMode;
//#UC START# *501F96A80050_48120C1C0060get_var*
//#UC END# *501F96A80050_48120C1C0060get_var*
begin
//#UC START# *501F96A80050_48120C1C0060get_impl*
 Result := nev_aacNone;
//#UC END# *501F96A80050_48120C1C0060get_impl*
end;//TnevBaseDetachedView.Get_AACLike

function TnevBaseDetachedView.NeedTotalRecalc: Boolean;
//#UC START# *565F03C80029_48120C1C0060_var*
//#UC END# *565F03C80029_48120C1C0060_var*
begin
//#UC START# *565F03C80029_48120C1C0060_impl*
 Result := GetNeedTotalRecalc;
//#UC END# *565F03C80029_48120C1C0060_impl*
end;//TnevBaseDetachedView.NeedTotalRecalc

procedure TnevBaseDetachedView.Cleanup;
//#UC START# *479731C50290_48120C1C0060_var*
//#UC END# *479731C50290_48120C1C0060_var*
begin
//#UC START# *479731C50290_48120C1C0060_impl*
 f_LimitWidth := 0;
 f_Text := nil;
 f_Canvas := nil;
 inherited;
//#UC END# *479731C50290_48120C1C0060_impl*
end;//TnevBaseDetachedView.Cleanup

function TnevBaseDetachedView.pm_GetShape: InevObject;
//#UC START# *4811D60B0043_48120C1C0060get_var*
//#UC END# *4811D60B0043_48120C1C0060get_var*
begin
//#UC START# *4811D60B0043_48120C1C0060get_impl*
 Result := InevObject(f_Text);
(* if (f_Text = nil) then
  Result := inherited pm_GetShape
 else
 if not _InevTag(f_Text).QT(InevObject, Result) then
   Assert(False);*)
//#UC END# *4811D60B0043_48120C1C0060get_impl*
end;//TnevBaseDetachedView.pm_GetShape

function TnevBaseDetachedView.DoGetMetrics: InevViewMetrics;
//#UC START# *4811D7DC0254_48120C1C0060_var*
//#UC END# *4811D7DC0254_48120C1C0060_var*
begin
//#UC START# *4811D7DC0254_48120C1C0060_impl*
 Result := Self;
//#UC END# *4811D7DC0254_48120C1C0060_impl*
end;//TnevBaseDetachedView.DoGetMetrics

function TnevBaseDetachedView.pm_GetIsObjectCollapsed(const anObject: InevObject): Boolean;
//#UC START# *4D5A46930182_48120C1C0060get_var*
//#UC END# *4D5A46930182_48120C1C0060get_var*
begin
//#UC START# *4D5A46930182_48120C1C0060get_impl*
 {$IfDef evCollapseAllVersionComments}
 if (anObject.IntA[k2_tiStyle] <> ev_saVersionInfo) then
  Result := false
 else
  Result := (-ev_saVersionInfo in pm_GetHiddenStyles);
 {$Else evCollapseAllVersionComments}
 Result := inherited pm_GetIsObjectCollapsed(anObject);
 {$EndIf evCollapseAllVersionComments}
//#UC END# *4D5A46930182_48120C1C0060get_impl*
end;//TnevBaseDetachedView.pm_GetIsObjectCollapsed

procedure TnevBaseDetachedView.pm_SetIsObjectCollapsed(const anObject: InevObject; aValue: Boolean);
//#UC START# *4D5A46930182_48120C1C0060set_var*
//#UC END# *4D5A46930182_48120C1C0060set_var*
begin
//#UC START# *4D5A46930182_48120C1C0060set_impl*
 {$IfDef evCollapseAllVersionComments}
 Assert(false, 'Кому бы такое могло бы понадобится');
 {$Else evCollapseAllVersionComments}
 inherited pm_SetIsObjectCollapsed(anObject, aValue);
 {$EndIf evCollapseAllVersionComments}
//#UC END# *4D5A46930182_48120C1C0060set_impl*
end;//TnevBaseDetachedView.pm_SetIsObjectCollapsed

procedure TnevBaseDetachedView.ClearFields;
 {-}
begin
 f_Canvas := nil;
 inherited;
end;//TnevBaseDetachedView.ClearFields

end.