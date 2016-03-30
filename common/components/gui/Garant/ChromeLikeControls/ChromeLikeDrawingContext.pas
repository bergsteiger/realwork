unit ChromeLikeDrawingContext;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeDrawingContext.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TChromeLikeDrawingContext" MUID: (5507C7FA00EE)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3ProtoObject
 , ChromeLikeTabSetTypes
 , GDIPOBJ
 , Graphics
;

type
 TChromeLikeDrawingContext = class(Tl3ProtoObject, IChromeLkeTabSetDrawingContext)
  private
   f_Graphics: TGPGraphics;
   f_Canvas: TCanvas;
  protected
   function pm_GetCanvas: TCanvas;
   function pm_GetGraphics: TGPGraphics;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aCanvas: TCanvas); reintroduce;
   class function Make(aCanvas: TCanvas): IChromeLkeTabSetDrawingContext; reintroduce;
 end;//TChromeLikeDrawingContext
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , ChromeLikeTabSetUtils
 , SysUtils
;

constructor TChromeLikeDrawingContext.Create(aCanvas: TCanvas);
//#UC START# *5507E6C202EE_5507C7FA00EE_var*
//#UC END# *5507E6C202EE_5507C7FA00EE_var*
begin
//#UC START# *5507E6C202EE_5507C7FA00EE_impl*
 inherited Create;
 f_Canvas := aCanvas;
 f_Graphics := nil;
//#UC END# *5507E6C202EE_5507C7FA00EE_impl*
end;//TChromeLikeDrawingContext.Create

class function TChromeLikeDrawingContext.Make(aCanvas: TCanvas): IChromeLkeTabSetDrawingContext;
var
 l_Inst : TChromeLikeDrawingContext;
begin
 l_Inst := Create(aCanvas);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TChromeLikeDrawingContext.Make

function TChromeLikeDrawingContext.pm_GetCanvas: TCanvas;
//#UC START# *5507DFFF038B_5507C7FA00EEget_var*
//#UC END# *5507DFFF038B_5507C7FA00EEget_var*
begin
//#UC START# *5507DFFF038B_5507C7FA00EEget_impl*
 Result := f_Canvas;
//#UC END# *5507DFFF038B_5507C7FA00EEget_impl*
end;//TChromeLikeDrawingContext.pm_GetCanvas

function TChromeLikeDrawingContext.pm_GetGraphics: TGPGraphics;
//#UC START# *5507E011038E_5507C7FA00EEget_var*
//#UC END# *5507E011038E_5507C7FA00EEget_var*
begin
//#UC START# *5507E011038E_5507C7FA00EEget_impl*
 if (f_Graphics = nil) then
  f_Graphics := TGPGraphics.Create(f_Canvas.Handle);
 Result := f_Graphics;
//#UC END# *5507E011038E_5507C7FA00EEget_impl*
end;//TChromeLikeDrawingContext.pm_GetGraphics

procedure TChromeLikeDrawingContext.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5507C7FA00EE_var*
//#UC END# *479731C50290_5507C7FA00EE_var*
begin
//#UC START# *479731C50290_5507C7FA00EE_impl*
 FreeAndNil(f_Graphics);
 inherited;
//#UC END# *479731C50290_5507C7FA00EE_impl*
end;//TChromeLikeDrawingContext.Cleanup
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
