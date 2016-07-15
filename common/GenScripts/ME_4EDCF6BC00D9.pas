unit dsTranslationWarning;
 {* ѕредупреждение к переводу документа }

// ћодуль: "w:\garant6x\implementation\Garant\GbaNemesis\Document\dsTranslationWarning.pas"
// —тереотип: "ViewAreaControllerImp"
// Ёлемент модели: "TdsTranslationWarning" MUID: (4EDCF6BC00D9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsWarning
 , DocInfoInterfaces
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TdsTranslationWarning = class(TdsWarning)
  {* ѕредупреждение к переводу документа }
  private
   ucc_DocInfo: IsdsDocInfo;
  protected
   function DoGetDocInfo: IdeDocInfo; override;
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* »нициализирует ссылки на различные представлени€ прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* ќчищает ссылки на различные представлени€ прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsTranslationWarning
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
;

function TdsTranslationWarning.DoGetDocInfo: IdeDocInfo;
//#UC START# *4EDCF99301CA_4EDCF6BC00D9_var*
//#UC END# *4EDCF99301CA_4EDCF6BC00D9_var*
begin
//#UC START# *4EDCF99301CA_4EDCF6BC00D9_impl*
 // Assigned(ucc_DocInfo.dsTranslation) дл€ http://mdp.garant.ru/pages/viewpage.action?pageId=325259961
 if Assigned(ucc_DocInfo) and Assigned(ucc_DocInfo.dsTranslation) then
  Result := ucc_DocInfo.dsTranslation.DocInfo
 else
  Result := nil;
//#UC END# *4EDCF99301CA_4EDCF6BC00D9_impl*
end;//TdsTranslationWarning.DoGetDocInfo

{$If NOT Defined(NoVCM)}
procedure TdsTranslationWarning.InitRefs(const aDS: IvcmFormSetDataSource);
 {* »нициализирует ссылки на различные представлени€ прецедента }
begin
 inherited;
 Supports(aDS, IsdsDocInfo, ucc_DocInfo);
end;//TdsTranslationWarning.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsTranslationWarning.ClearRefs;
 {* ќчищает ссылки на различные представлени€ прецедента }
begin
 inherited;
 ucc_DocInfo := nil;
end;//TdsTranslationWarning.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
