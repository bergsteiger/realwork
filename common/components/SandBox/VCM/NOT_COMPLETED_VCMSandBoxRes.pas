unit NOT_COMPLETED_VCMSandBoxRes;
 {* Тестовое приложение VCM }

// Модуль: "w:\common\components\SandBox\VCM\NOT_COMPLETED_VCMSandBoxRes.pas"
// Стереотип: "VCMApplication"
// Элемент модели: "VCMSandBox" MUID: (521649770277)
// Имя типа: "TVCMSandBoxRes"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmApplication
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_VCMSandBoxTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'VCMSandBoxTitle'; rValue : 'Тестовое приложение VCM');
  {* 'Тестовое приложение VCM' }

type
 TVCMSandBoxRes = {final} class({$If NOT Defined(NoVCM)}
 TvcmApplication
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Тестовое приложение VCM }
  protected
   procedure Loaded; override;
 end;//TVCMSandBoxRes

 TvcmApplicationRef = TVCMSandBoxRes;
  {* Ссылка на приложение для DesignTime редакторов }

implementation

uses
 l3ImplUses
 , moDocument
 , moList
 , l3MessageID
 , evExtFormat
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
procedure TVCMSandBoxRes.Loaded;
begin
 inherited;
end;//TVCMSandBoxRes.Loaded

initialization
 str_VCMSandBoxTitle.Init;
 {* Инициализация str_VCMSandBoxTitle }
{$IfEnd} // NOT Defined(NoVCM)

end.
