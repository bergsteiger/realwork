unit nsDocumentPreview;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/nsDocumentPreview.pas"
// Начат: 2003/07/02 19:45:58
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::Search::Search::TnsDocumentPreview
//
// Предварительный просмотр документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  LoggingInterfaces,
  evDocumentPreview,
  afwInterfaces
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TnsDocumentPreview = class(TevDocumentPreview, InsEventHolder)
  {* Предварительный просмотр документа }
 private
 // private fields
   f_Event : InsDefferedEvent;
 protected
 // realized methods
   procedure SetEvent(const anEvent: InsDefferedEvent);
 protected
 // overridden protected methods
   function IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean; override;
   procedure AfterPrint; override;
   function NeedAddBlockNames: Boolean; override;
     {* Нужно ли добавлять имена блоков }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 end;//TnsDocumentPreview
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  afwFacade,
  nsConst,
  SysUtils
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TnsDocumentPreview

procedure TnsDocumentPreview.SetEvent(const anEvent: InsDefferedEvent);
//#UC START# *499140B20354_47F22D5701A7_var*
//#UC END# *499140B20354_47F22D5701A7_var*
begin
//#UC START# *499140B20354_47F22D5701A7_impl*
 f_Event := anEvent;
//#UC END# *499140B20354_47F22D5701A7_impl*
end;//TnsDocumentPreview.SetEvent

function TnsDocumentPreview.IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean;
//#UC START# *47ECFAD101B9_47F22D5701A7_var*
//#UC END# *47ECFAD101B9_47F22D5701A7_var*
begin
//#UC START# *47ECFAD101B9_47F22D5701A7_impl*
 Result := ANSISameText(aSettingId, pi_Print_Metrics_Margins_Left) OR
           ANSISameText(aSettingId, pi_Print_Metrics_Margins_Right) OR
           ANSISameText(aSettingId, pi_Print_Metrics_Margins_Top) OR
           ANSISameText(aSettingId, pi_Print_Metrics_Margins_Bottom) OR
           ANSISameText(aSettingId, pi_Print_Metrics_Orientation) OR
           ANSISameText(aSettingId, pi_Document_ExportWithBlockNames);
//#UC END# *47ECFAD101B9_47F22D5701A7_impl*
end;//TnsDocumentPreview.IsSettingAffectsUs

procedure TnsDocumentPreview.AfterPrint;
//#UC START# *48FD8A1C0307_47F22D5701A7_var*
//#UC END# *48FD8A1C0307_47F22D5701A7_var*
begin
//#UC START# *48FD8A1C0307_47F22D5701A7_impl*
 if Assigned(f_Event) then
  f_Event.FireLog;
 inherited;
//#UC END# *48FD8A1C0307_47F22D5701A7_impl*
end;//TnsDocumentPreview.AfterPrint

function TnsDocumentPreview.NeedAddBlockNames: Boolean;
//#UC START# *4A2E97A4021B_47F22D5701A7_var*
//#UC END# *4A2E97A4021B_47F22D5701A7_var*
begin
//#UC START# *4A2E97A4021B_47F22D5701A7_impl*
 Result := afw.Application.Settings.LoadBoolean(pi_Document_ExportWithBlockNames, dv_Document_ExportWithBlockNames);
//#UC END# *4A2E97A4021B_47F22D5701A7_impl*
end;//TnsDocumentPreview.NeedAddBlockNames

procedure TnsDocumentPreview.ClearFields;
 {-}
begin
 {$If not defined(Admin)}
 f_Event := nil;
 {$IfEnd} //not Admin
 inherited;
end;//TnsDocumentPreview.ClearFields

{$IfEnd} //not Admin

end.