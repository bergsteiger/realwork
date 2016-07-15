unit ShellAndMonitoringsRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ShellAndMonitoringsRes.pas"
// Стереотип: "VCMApplication"
// Элемент модели: "ShellAndMonitorings" MUID: (4AAA42BF0267)
// Имя типа: "TShellAndMonitoringsRes"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimF1Res
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , afwInterfaces
 , ConfigInterfaces
;

type
 TShellAndMonitoringsRes = {abstract} class(TPrimF1Res)
  public
   class function MakeSaveLoadForm(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean;
    aUserType: TvcmUserType): IvcmEntityForm;
   class function MakeQueryCardForm(aFilter: Boolean;
    const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean;
    aUserType: TvcmUserType): IvcmEntityForm;
   class function MakePreview(const aPreview: IafwDocumentPreview): IvcmEntityForm;
   class function MakePageSetup(const aData: InsPageSettingsInfo): Integer;
   class function MakePrintDialog(const aPreview: IafwDocumentPreview): IvcmEntityForm;
 end;//TShellAndMonitoringsRes
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , moCommonSearch
 , tasSaveLoadRealization
 , CommonSearch_Module
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , ShellAndMonitoringsMain_Form
 , evExtFormat
 //#UC START# *4AAA42BF0267impl_uses*
 //#UC END# *4AAA42BF0267impl_uses*
;

class function TShellAndMonitoringsRes.MakeSaveLoadForm(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean;
 aUserType: TvcmUserType): IvcmEntityForm;
begin
 Result := TCommonSearchModule.MakeSaveLoadForm(aParams, aZoneType, aRecursive, aUserType);
end;//TShellAndMonitoringsRes.MakeSaveLoadForm

class function TShellAndMonitoringsRes.MakeQueryCardForm(aFilter: Boolean;
 const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean;
 aUserType: TvcmUserType): IvcmEntityForm;
begin
 Result := TCommonSearchModule.MakeQueryCardForm(aFilter, aParams, aZoneType, aRecursive, aUserType);
end;//TShellAndMonitoringsRes.MakeQueryCardForm

class function TShellAndMonitoringsRes.MakePreview(const aPreview: IafwDocumentPreview): IvcmEntityForm;
begin
 Result := TCommonSearchModule.MakePreview(aPreview);
end;//TShellAndMonitoringsRes.MakePreview

class function TShellAndMonitoringsRes.MakePageSetup(const aData: InsPageSettingsInfo): Integer;
begin
 Result := TCommonSearchModule.MakePageSetup(aData);
end;//TShellAndMonitoringsRes.MakePageSetup

class function TShellAndMonitoringsRes.MakePrintDialog(const aPreview: IafwDocumentPreview): IvcmEntityForm;
begin
 Result := TCommonSearchModule.MakePrintDialog(aPreview);
end;//TShellAndMonitoringsRes.MakePrintDialog
{$IfEnd} // NOT Defined(Admin)

end.
