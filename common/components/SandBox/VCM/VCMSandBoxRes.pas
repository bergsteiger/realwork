unit VCMSandBoxRes;
 {* Тестовое приложение VCM }

// Модуль: "w:\common\components\SandBox\VCM\VCMSandBoxRes.pas"
// Стереотип: "VCMApplication"
// Элемент модели: "VCMSandBox" MUID: (521649770277)
// Имя типа: "TVCMSandBoxRes"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_VCMSandBoxTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'VCMSandBoxTitle'; rValue : 'Тестовое приложение VCM');
  {* 'Тестовое приложение VCM' }

type
 TVCMSandBoxRes = {final} class
  {* Тестовое приложение VCM }
 end;//TVCMSandBoxRes

implementation

uses
 l3ImplUses
 , moDocument
 , moList
 , evExtFormat
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *521649770277impl_uses*
 //#UC END# *521649770277impl_uses*
;

initialization
 str_VCMSandBoxTitle.Init;
 {* Инициализация str_VCMSandBoxTitle }

end.
