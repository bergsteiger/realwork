unit nevVirtualDrawView;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevVirtualDrawView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevVirtualDrawView" MUID: (481213C903A2)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevBaseDetachedView
 , evdStyles
 , nevBase
 , nevTools
;

type
 TnevVirtualDrawView = class(TnevBaseDetachedView)
  private
   f_IsWebStyle: Boolean;
   f_ShowDocumentParts: Boolean;
   f_ShowSpecial: Boolean;
   f_HiddenStyles: TevStandardStyles;
   f_ParentFI: TnevFormatInfoPrim;
   f_AllowRubberTables: TnevRubberTablesMode;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetIsWebStyle: Boolean; override;
   function GetShowDocumentParts: Boolean; override;
   function GetShowSpecial: Boolean; override;
   function GetHiddenStyles: TevStandardStyles; override;
   function GetRootFormatInfo: TnevFormatInfoPrim; override;
   function GetAllowRubberTables: TnevRubberTablesMode; override;
  public
   constructor Create(const aText: InevObject;
    aParentFI: TnevFormatInfoPrim;
    const aCanvas: InevCanvas;
    const aViewMetrics: InevViewMetrics); reintroduce;
   class function Make(const aText: InevObject;
    aParentFI: TnevFormatInfoPrim;
    const aCanvas: InevCanvas;
    const aViewMetrics: InevViewMetrics): InevView; reintroduce;
 end;//TnevVirtualDrawView

implementation

uses
 l3ImplUses
 //#UC START# *481213C903A2impl_uses*
 //#UC END# *481213C903A2impl_uses*
;

constructor TnevVirtualDrawView.Create(const aText: InevObject;
 aParentFI: TnevFormatInfoPrim;
 const aCanvas: InevCanvas;
 const aViewMetrics: InevViewMetrics);
//#UC START# *4CB5BE9803DF_481213C903A2_var*
//#UC END# *4CB5BE9803DF_481213C903A2_var*
begin
//#UC START# *4CB5BE9803DF_481213C903A2_impl*
 inherited Create(aText, aCanvas);
 f_ParentFI := aParentFI;
 if (aViewMetrics <> nil) then
  with aViewMetrics do
  begin
   f_IsWebStyle := IsWebStyle;
   f_AllowRubberTables := AllowRubberTables;
   f_ShowDocumentParts := ShowDocumentParts;
   f_ShowSpecial := ShowSpecial;
   f_HiddenStyles := HiddenStyles;
   f_LimitWidth := LimitWidth;
  end;//with aViewMetrics
//#UC END# *4CB5BE9803DF_481213C903A2_impl*
end;//TnevVirtualDrawView.Create

class function TnevVirtualDrawView.Make(const aText: InevObject;
 aParentFI: TnevFormatInfoPrim;
 const aCanvas: InevCanvas;
 const aViewMetrics: InevViewMetrics): InevView;
var
 l_Inst : TnevVirtualDrawView;
begin
 l_Inst := Create(aText, aParentFI, aCanvas, aViewMetrics);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevVirtualDrawView.Make

procedure TnevVirtualDrawView.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_481213C903A2_var*
//#UC END# *479731C50290_481213C903A2_var*
begin
//#UC START# *479731C50290_481213C903A2_impl*
 f_ParentFI := nil;
 inherited;
//#UC END# *479731C50290_481213C903A2_impl*
end;//TnevVirtualDrawView.Cleanup

function TnevVirtualDrawView.GetIsWebStyle: Boolean;
//#UC START# *48120CED0107_481213C903A2_var*
//#UC END# *48120CED0107_481213C903A2_var*
begin
//#UC START# *48120CED0107_481213C903A2_impl*
 Result := f_IsWebStyle;
//#UC END# *48120CED0107_481213C903A2_impl*
end;//TnevVirtualDrawView.GetIsWebStyle

function TnevVirtualDrawView.GetShowDocumentParts: Boolean;
//#UC START# *48120D0300D4_481213C903A2_var*
//#UC END# *48120D0300D4_481213C903A2_var*
begin
//#UC START# *48120D0300D4_481213C903A2_impl*
 Result := f_ShowDocumentParts;
//#UC END# *48120D0300D4_481213C903A2_impl*
end;//TnevVirtualDrawView.GetShowDocumentParts

function TnevVirtualDrawView.GetShowSpecial: Boolean;
//#UC START# *48120D270114_481213C903A2_var*
//#UC END# *48120D270114_481213C903A2_var*
begin
//#UC START# *48120D270114_481213C903A2_impl*
 Result := f_ShowSpecial;
//#UC END# *48120D270114_481213C903A2_impl*
end;//TnevVirtualDrawView.GetShowSpecial

function TnevVirtualDrawView.GetHiddenStyles: TevStandardStyles;
//#UC START# *48120D32035F_481213C903A2_var*
//#UC END# *48120D32035F_481213C903A2_var*
begin
//#UC START# *48120D32035F_481213C903A2_impl*
 Result := f_HiddenStyles;
//#UC END# *48120D32035F_481213C903A2_impl*
end;//TnevVirtualDrawView.GetHiddenStyles

function TnevVirtualDrawView.GetRootFormatInfo: TnevFormatInfoPrim;
//#UC START# *481DA04D0324_481213C903A2_var*
//#UC END# *481DA04D0324_481213C903A2_var*
begin
//#UC START# *481DA04D0324_481213C903A2_impl*
 if (f_ParentFI = nil) then
 // - эта проверка нужна например для TnscSimpleEditor.AdjustHeightByText
  Result := inherited GetRootFormatInfo
 else
  Result := f_ParentFI.InfoForChild(Self.Shape);
//#UC END# *481DA04D0324_481213C903A2_impl*
end;//TnevVirtualDrawView.GetRootFormatInfo

function TnevVirtualDrawView.GetAllowRubberTables: TnevRubberTablesMode;
//#UC START# *4BED6EF003DD_481213C903A2_var*
//#UC END# *4BED6EF003DD_481213C903A2_var*
begin
//#UC START# *4BED6EF003DD_481213C903A2_impl*
 Result := f_AllowRubberTables;
//#UC END# *4BED6EF003DD_481213C903A2_impl*
end;//TnevVirtualDrawView.GetAllowRubberTables

end.
