unit ChromeLikeDrawingContext;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeDrawingContext.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeTabSet::TChromeLikeDrawingContext
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Graphics,
  l3ProtoObject,
  ChromeLikeTabSetTypes,
  GDIPOBJ
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
type
 TChromeLikeDrawingContext = class(Tl3ProtoObject, IChromeLkeTabSetDrawingContext)
 private
 // private fields
   f_Graphics : TGPGraphics;
   f_Canvas : TCanvas;
 protected
 // realized methods
   function pm_GetCanvas: TCanvas;
   function pm_GetGraphics: TGPGraphics;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aCanvas: TCanvas); reintroduce;
   class function Make(aCanvas: TCanvas): IChromeLkeTabSetDrawingContext; reintroduce;
     {* Сигнатура фабрики TChromeLikeDrawingContext.Make }
 end;//TChromeLikeDrawingContext
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  ChromeLikeTabSetUtils,
  SysUtils
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class TChromeLikeDrawingContext

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
end;

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
//#UC START# *479731C50290_5507C7FA00EE_var*
//#UC END# *479731C50290_5507C7FA00EE_var*
begin
//#UC START# *479731C50290_5507C7FA00EE_impl*
 FreeAndNil(f_Graphics);
 inherited;
//#UC END# *479731C50290_5507C7FA00EE_impl*
end;//TChromeLikeDrawingContext.Cleanup

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.