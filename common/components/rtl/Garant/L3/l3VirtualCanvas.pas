unit l3VirtualCanvas;
 {* Виртуальная канва. Для отрисовки "в пустоту". }

// Модуль: "w:\common\components\rtl\Garant\L3\l3VirtualCanvas.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3VirtualCanvas" MUID: (473C4F1E01A1)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3Canvas
 , l3Units
 , l3InternalInterfaces
 , l3Interfaces
 , l3Core
 , Graphics
 //#UC START# *473C4F1E01A1intf_uses*
 //#UC END# *473C4F1E01A1intf_uses*
;

type
 //#UC START# *473C4F1E01A1ci*
 //#UC END# *473C4F1E01A1ci*
 //#UC START# *473C4F1E01A1cit*
 //#UC END# *473C4F1E01A1cit*
 Tl3VirtualCanvas = class(Tl3Canvas)
  {* Виртуальная канва. Для отрисовки "в пустоту". }
  private
   f_Extent: Tl3Point;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure FillRectPrim(const R: TRect); override;
   function DoGetPageSetupWidth: Tl3Inch; override;
   function DoGetPageSetupHeight: Tl3Inch; override;
   function GetPrinting: Boolean; override;
   function DoGetPaperWidth: Tl3Inch; override;
   function GetIsVirtual: Boolean; override;
   procedure DoFillEmptyRect(const R: Tl3Rect); override;
   procedure DoFillEmptyRect(const R: Tl3SRect); override;
   function GetGlobalClipRect: Tl3Rect; override;
   procedure DoAddRect(const aRect: Tl3SRect); override;
   procedure AddRgn(const aRgn: Il3Region); override;
   function KerningTextExtent(const S: Tl3PCharLenPrim): Tl3Point; override;
   function DoGetClientRect: Tl3Rect; override;
  public
   constructor Create(const anExtent: Tl3_Point); reintroduce; virtual;
   class function Make(const anExtent: Tl3_Point): Il3Canvas; reintroduce;
   procedure SetCanvas(aValue: TCanvas;
    anAlien: Boolean); override;
 //#UC START# *473C4F1E01A1publ*
 //#UC END# *473C4F1E01A1publ*
 end;//Tl3VirtualCanvas

implementation

uses
 l3ImplUses
 , l3CanvasPrim
 //#UC START# *473C4F1E01A1impl_uses*
 //#UC END# *473C4F1E01A1impl_uses*
;

constructor Tl3VirtualCanvas.Create(const anExtent: Tl3_Point);
//#UC START# *56B9C037031F_473C4F1E01A1_var*
//#UC END# *56B9C037031F_473C4F1E01A1_var*
begin
//#UC START# *56B9C037031F_473C4F1E01A1_impl*
 f_Extent := Tl3Point(anExtent);
 inherited Create;
 SectionExtent := l3Point(f_Extent.X, SectionExtent.Y);
 BeginPaint;
 DrawEnabled := true;
 MakeScreenDC;
//#UC END# *56B9C037031F_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.Create

class function Tl3VirtualCanvas.Make(const anExtent: Tl3_Point): Il3Canvas;
var
 l_Inst : Tl3VirtualCanvas;
begin
 l_Inst := Create(anExtent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tl3VirtualCanvas.Make

procedure Tl3VirtualCanvas.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_473C4F1E01A1_var*
//#UC END# *479731C50290_473C4F1E01A1_var*
begin
//#UC START# *479731C50290_473C4F1E01A1_impl*
 EndPaint;
 inherited;
//#UC END# *479731C50290_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3VirtualCanvas.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_473C4F1E01A1_var*
//#UC END# *47A6FEE600FC_473C4F1E01A1_var*
begin
//#UC START# *47A6FEE600FC_473C4F1E01A1_impl*
 Result := True;
//#UC END# *47A6FEE600FC_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure Tl3VirtualCanvas.FillRectPrim(const R: TRect);
//#UC START# *47DFCAAF0249_473C4F1E01A1_var*
//#UC END# *47DFCAAF0249_473C4F1E01A1_var*
begin
//#UC START# *47DFCAAF0249_473C4F1E01A1_impl*
//#UC END# *47DFCAAF0249_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.FillRectPrim

function Tl3VirtualCanvas.DoGetPageSetupWidth: Tl3Inch;
//#UC START# *4A4CBCD002EA_473C4F1E01A1_var*
//#UC END# *4A4CBCD002EA_473C4F1E01A1_var*
begin
//#UC START# *4A4CBCD002EA_473C4F1E01A1_impl*
 Result := f_Extent.X;
//#UC END# *4A4CBCD002EA_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.DoGetPageSetupWidth

function Tl3VirtualCanvas.DoGetPageSetupHeight: Tl3Inch;
//#UC START# *4A4CBCDD0244_473C4F1E01A1_var*
//#UC END# *4A4CBCDD0244_473C4F1E01A1_var*
begin
//#UC START# *4A4CBCDD0244_473C4F1E01A1_impl*
 Result := f_Extent.Y;
//#UC END# *4A4CBCDD0244_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.DoGetPageSetupHeight

function Tl3VirtualCanvas.GetPrinting: Boolean;
//#UC START# *4A4CCCE900E8_473C4F1E01A1_var*
//#UC END# *4A4CCCE900E8_473C4F1E01A1_var*
begin
//#UC START# *4A4CCCE900E8_473C4F1E01A1_impl*
 Result := False;
//#UC END# *4A4CCCE900E8_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.GetPrinting

function Tl3VirtualCanvas.DoGetPaperWidth: Tl3Inch;
//#UC START# *4D1B61130223_473C4F1E01A1_var*
//#UC END# *4D1B61130223_473C4F1E01A1_var*
begin
//#UC START# *4D1B61130223_473C4F1E01A1_impl*
 Result := f_Extent.X;
//#UC END# *4D1B61130223_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.DoGetPaperWidth

function Tl3VirtualCanvas.GetIsVirtual: Boolean;
//#UC START# *56AF1E650037_473C4F1E01A1_var*
//#UC END# *56AF1E650037_473C4F1E01A1_var*
begin
//#UC START# *56AF1E650037_473C4F1E01A1_impl*
 Result := True;
//#UC END# *56AF1E650037_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.GetIsVirtual

procedure Tl3VirtualCanvas.SetCanvas(aValue: TCanvas;
 anAlien: Boolean);
//#UC START# *56B0AE550267_473C4F1E01A1_var*
//#UC END# *56B0AE550267_473C4F1E01A1_var*
begin
//#UC START# *56B0AE550267_473C4F1E01A1_impl*
 if (DCFlag = ev_dcfLinked) then
  SetDC(0, ev_dcfCanvas);
 inherited;
//#UC END# *56B0AE550267_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.SetCanvas

procedure Tl3VirtualCanvas.DoFillEmptyRect(const R: Tl3Rect);
//#UC START# *56B356D6039B_473C4F1E01A1_var*
//#UC END# *56B356D6039B_473C4F1E01A1_var*
begin
//#UC START# *56B356D6039B_473C4F1E01A1_impl*
 RecordRegionBottomPrim(LR2DR(R.SubPt(WindowOrg)).BottomRight);
//#UC END# *56B356D6039B_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.DoFillEmptyRect

procedure Tl3VirtualCanvas.DoFillEmptyRect(const R: Tl3SRect);
//#UC START# *56B356F20141_473C4F1E01A1_var*
//#UC END# *56B356F20141_473C4F1E01A1_var*
begin
//#UC START# *56B356F20141_473C4F1E01A1_impl*
 RecordRegionBottomPrim(R.SubPt(SWindowOrg).BottomRight);
//#UC END# *56B356F20141_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.DoFillEmptyRect

function Tl3VirtualCanvas.GetGlobalClipRect: Tl3Rect;
//#UC START# *56B359C302CB_473C4F1E01A1_var*
//#UC END# *56B359C302CB_473C4F1E01A1_var*
begin
//#UC START# *56B359C302CB_473C4F1E01A1_impl*
 Result := DoGetClientRect;
//#UC END# *56B359C302CB_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.GetGlobalClipRect

procedure Tl3VirtualCanvas.DoAddRect(const aRect: Tl3SRect);
//#UC START# *56B491A30323_473C4F1E01A1_var*
//#UC END# *56B491A30323_473C4F1E01A1_var*
begin
//#UC START# *56B491A30323_473C4F1E01A1_impl*
//#UC END# *56B491A30323_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.DoAddRect

procedure Tl3VirtualCanvas.AddRgn(const aRgn: Il3Region);
//#UC START# *56B496300318_473C4F1E01A1_var*
//#UC END# *56B496300318_473C4F1E01A1_var*
begin
//#UC START# *56B496300318_473C4F1E01A1_impl*
//#UC END# *56B496300318_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.AddRgn

function Tl3VirtualCanvas.KerningTextExtent(const S: Tl3PCharLenPrim): Tl3Point;
//#UC START# *56B499ED0217_473C4F1E01A1_var*
//#UC END# *56B499ED0217_473C4F1E01A1_var*
begin
//#UC START# *56B499ED0217_473C4F1E01A1_impl*
 Result := TextExtent(S);
//#UC END# *56B499ED0217_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.KerningTextExtent

function Tl3VirtualCanvas.DoGetClientRect: Tl3Rect;
//#UC START# *56B4D83B00EC_473C4F1E01A1_var*
//#UC END# *56B4D83B00EC_473C4F1E01A1_var*
begin
//#UC START# *56B4D83B00EC_473C4F1E01A1_impl*
 Result := l3RectBnd(l3Point0, f_Extent);
//#UC END# *56B4D83B00EC_473C4F1E01A1_impl*
end;//Tl3VirtualCanvas.DoGetClientRect

//#UC START# *473C4F1E01A1impl*
//#UC END# *473C4F1E01A1impl*

end.
