unit nevVirtualDrawView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Лукьянец Р.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevVirtualDrawView.pas"
// Начат: 22.10.2007 14:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Views::TnevVirtualDrawView
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
  nevBaseDetachedView
  ;

type
 TnevVirtualDrawView = class(TnevBaseDetachedView)
 private
 // private fields
   f_IsWebStyle : Boolean;
   f_ShowDocumentParts : Boolean;
   f_ShowSpecial : Boolean;
   f_HiddenStyles : TevStandardStyles;
   f_ParentFI : TnevFormatInfoPrim;
   f_AllowRubberTables : TnevRubberTablesMode;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function GetIsWebStyle: Boolean; override;
   function GetShowDocumentParts: Boolean; override;
   function GetShowSpecial: Boolean; override;
   function GetHiddenStyles: TevStandardStyles; override;
   function GetRootFormatInfo: TnevFormatInfoPrim; override;
   function GetAllowRubberTables: TnevRubberTablesMode; override;
 public
 // public methods
   constructor Create(const aText: InevObject;
     aParentFI: TnevFormatInfoPrim;
     const aCanvas: InevCanvas;
     const aViewMetrics: InevViewMetrics); reintroduce;
   class function Make(const aText: InevObject;
     aParentFI: TnevFormatInfoPrim;
     const aCanvas: InevCanvas;
     const aViewMetrics: InevViewMetrics): InevView; reintroduce;
     {* Сигнатура фабрики TnevVirtualDrawView.Make }
 end;//TnevVirtualDrawView

implementation

// start class TnevVirtualDrawView

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
end;

procedure TnevVirtualDrawView.Cleanup;
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