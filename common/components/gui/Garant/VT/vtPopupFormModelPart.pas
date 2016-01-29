unit vtPopupFormModelPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VT/vtPopupFormModelPart.pas"
// Начат: 28.03.2011 13:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT$Rem::Reminders::TvtPopupFormModelPart
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVCM) AND not defined(NoVGScene)}
uses
  vcmExternalInterfaces,
  Types,
  vtPopupForm
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoVCM AND not NoVGScene

{$If not defined(NoVCM) AND not defined(NoVGScene)}
type

 TTailRects = array [TvtTailPosition] of TRect;


 TPopupFormBoundsRects = record
   rInited : Boolean;
   rV : TTailRects;
 end;//TPopupFormBoundsRects

 TvtPopupFormModelPart = class(TvtPopupForm, IvcmDatasourceChangeListener)
 protected
 // realized methods
   procedure DataSourceChanged(aControl: TControl);
 end;//TvtPopupFormModelPart
{$IfEnd} //not NoVCM AND not NoVGScene

implementation

{$If not defined(NoVCM) AND not defined(NoVGScene)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVCM AND not NoVGScene

{$If not defined(NoVCM) AND not defined(NoVGScene)}

// start class TvtPopupFormModelPart

procedure TvtPopupFormModelPart.DataSourceChanged(aControl: TControl);
//#UC START# *4D905A2A00D6_4D9058880214_var*
var
 l_L : IvcmDatasourceChangeListener;
//#UC END# *4D905A2A00D6_4D9058880214_var*
begin
//#UC START# *4D905A2A00D6_4D9058880214_impl*
 if Supports(Owner, IvcmDatasourceChangeListener, l_L) then
  try
   l_L.DataSourceChanged(aControl);
  finally
   l_L := nil;
  end;//try..finally
//#UC END# *4D905A2A00D6_4D9058880214_impl*
end;//TvtPopupFormModelPart.DataSourceChanged

{$IfEnd} //not NoVCM AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TvtPopupFormModelPart
 TtfwClassRef.Register(TvtPopupFormModelPart);
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene

end.