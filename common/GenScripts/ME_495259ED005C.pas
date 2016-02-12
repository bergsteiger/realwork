unit NOT_FINISHED_l3Forms;
 {* Базовый класс форм, поддерживающих счетчик ссылок и интерфейс IUnknown }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Forms.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3PureMixIns
 , l3IID
 , l3Interfaces
;

type
 _l3Unknown_Parent_ = TForm;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 _l3COMQueryInterface_Parent_ = _l3Unknown_;
 {$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}
 Tl3Form = class(_l3COMQueryInterface_)
  {* Базовый класс форм, поддерживающих счетчик ссылок и интерфейс IUnknown }
 end;//Tl3Form

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
 , l3InterfacesMisc
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tl3Form);
 {* Регистрация Tl3Form }
{$IfEnd} // NOT Defined(NoScripts)

end.
