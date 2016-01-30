unit dsTranslationWarning;
 {* Предупреждение к переводу документа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Document\dsTranslationWarning.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsWarning
 , DocInfoInterfaces
 , DocumentInterfaces
;

type
 TdsTranslationWarning = class(TdsWarning)
  {* Предупреждение к переводу документа }
  private
   DocInfo: IsdsDocInfo;
  protected
   function DoGetDocInfo: IdeDocInfo; override;
 end;//TdsTranslationWarning
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

function TdsTranslationWarning.DoGetDocInfo: IdeDocInfo;
//#UC START# *4EDCF99301CA_4EDCF6BC00D9_var*
//#UC END# *4EDCF99301CA_4EDCF6BC00D9_var*
begin
//#UC START# *4EDCF99301CA_4EDCF6BC00D9_impl*
 // Assigned(ucc_DocInfo.dsTranslation) для http://mdp.garant.ru/pages/viewpage.action?pageId=325259961
 if Assigned(ucc_DocInfo) and Assigned(ucc_DocInfo.dsTranslation) then
  Result := ucc_DocInfo.dsTranslation.DocInfo
 else
  Result := nil;
//#UC END# *4EDCF99301CA_4EDCF6BC00D9_impl*
end;//TdsTranslationWarning.DoGetDocInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
