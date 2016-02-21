unit nsDocumentPreview;
 {* Предварительный просмотр документа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsDocumentPreview.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , evDocumentPreview
 , LoggingInterfaces
 , afwInterfaces
;

type
 TnsDocumentPreview = class(TevDocumentPreview, InsEventHolder)
  {* Предварительный просмотр документа }
  private
   f_Event: InsDefferedEvent;
  protected
   procedure SetEvent(const anEvent: InsDefferedEvent);
   function IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean; override;
   procedure AfterPrint; override;
   function NeedAddBlockNames: Boolean; override;
    {* Нужно ли добавлять имена блоков }
   procedure ClearFields; override;
 end;//TnsDocumentPreview
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , afwFacade
 , nsConst
 , SysUtils
;

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
 {* Нужно ли добавлять имена блоков }
//#UC START# *4A2E97A4021B_47F22D5701A7_var*
//#UC END# *4A2E97A4021B_47F22D5701A7_var*
begin
//#UC START# *4A2E97A4021B_47F22D5701A7_impl*
 Result := afw.Application.Settings.LoadBoolean(pi_Document_ExportWithBlockNames, dv_Document_ExportWithBlockNames);
//#UC END# *4A2E97A4021B_47F22D5701A7_impl*
end;//TnsDocumentPreview.NeedAddBlockNames

procedure TnsDocumentPreview.ClearFields;
begin
 f_Event := nil;
 inherited;
end;//TnsDocumentPreview.ClearFields
{$IfEnd} // NOT Defined(Admin)

end.
