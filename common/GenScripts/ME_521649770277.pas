unit VCMSandBoxRes;
 {* Тестовое приложение VCM }

// Модуль: "w:\common\components\SandBox\VCM\VCMSandBoxRes.pas"
// Стереотип: "VCMApplication"

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
 TvcmApplicationRef = TVCMSandBoxRes;
  {* Ссылка на приложение для DesignTime редакторов }

 TVCMSandBoxRes = {final} class(TvcmApplication)
  {* Тестовое приложение VCM }
 end;//TVCMSandBoxRes

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

initialization
 str_VCMSandBoxTitle.Init;
 {* Инициализация str_VCMSandBoxTitle }

end.
