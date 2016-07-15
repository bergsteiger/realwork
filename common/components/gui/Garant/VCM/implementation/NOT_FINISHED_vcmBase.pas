unit NOT_FINISHED_vcmBase;
 {* - базовые классы библиотеки. }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\NOT_FINISHED_vcmBase.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmBase" MUID: (47F25BC801DB)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmStringIDExHelper
 , l3ProtoObject
 , l3ProtoObjectWithCOMQI
 , vcmInterfaces
 , l3CClassList
;

type
 TvcmBase = class(Tl3ProtoObject)
  {* Базовый класс библиотеки. }
 end;//TvcmBase

 TvcmObjectList = class
 end;//TvcmObjectList

 TvcmCacheableBase = class(Tl3ProtoObjectWithCOMQI)
 end;//TvcmCacheableBase

 TvcmExecuteEvent = procedure(const aParams: IvcmExecuteParams) of object;

 TvcmLongintList = class
 end;//TvcmLongintList

 TvcmClassList = class(Tl3CClassList)
 end;//TvcmClassList

procedure vcmFmt;
procedure vcmParams;
procedure vcmConstString;
procedure vcmDispatcher;
procedure vcmCStr;
procedure vcmMakeParams;
procedure vcmStr;
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmMakeParams
;

procedure DoNotCall(aHelper: TvcmStringIDExHelper);
//#UC START# *4B98E11603D6_47F25BC801DB_var*
//#UC END# *4B98E11603D6_47F25BC801DB_var*
begin
//#UC START# *4B98E11603D6_47F25BC801DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B98E11603D6_47F25BC801DB_impl*
end;//DoNotCall

procedure vcmFmt;
//#UC START# *4A8ADF9E0058_47F25BC801DB_var*
//#UC END# *4A8ADF9E0058_47F25BC801DB_var*
begin
//#UC START# *4A8ADF9E0058_47F25BC801DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8ADF9E0058_47F25BC801DB_impl*
end;//vcmFmt

procedure vcmParams;
//#UC START# *4A93BA1802CE_47F25BC801DB_var*
//#UC END# *4A93BA1802CE_47F25BC801DB_var*
begin
//#UC START# *4A93BA1802CE_47F25BC801DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A93BA1802CE_47F25BC801DB_impl*
end;//vcmParams

procedure vcmConstString;
//#UC START# *4AA7F1CB012C_47F25BC801DB_var*
//#UC END# *4AA7F1CB012C_47F25BC801DB_var*
begin
//#UC START# *4AA7F1CB012C_47F25BC801DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AA7F1CB012C_47F25BC801DB_impl*
end;//vcmConstString

procedure vcmDispatcher;
//#UC START# *4AA936DC0154_47F25BC801DB_var*
//#UC END# *4AA936DC0154_47F25BC801DB_var*
begin
//#UC START# *4AA936DC0154_47F25BC801DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AA936DC0154_47F25BC801DB_impl*
end;//vcmDispatcher

procedure vcmCStr;
//#UC START# *4AC0B9CF018A_47F25BC801DB_var*
//#UC END# *4AC0B9CF018A_47F25BC801DB_var*
begin
//#UC START# *4AC0B9CF018A_47F25BC801DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC0B9CF018A_47F25BC801DB_impl*
end;//vcmCStr

procedure vcmMakeParams;
//#UC START# *4AD89C420296_47F25BC801DB_var*
//#UC END# *4AD89C420296_47F25BC801DB_var*
begin
//#UC START# *4AD89C420296_47F25BC801DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AD89C420296_47F25BC801DB_impl*
end;//vcmMakeParams

procedure vcmStr;
//#UC START# *508FEA3B02B0_47F25BC801DB_var*
//#UC END# *508FEA3B02B0_47F25BC801DB_var*
begin
//#UC START# *508FEA3B02B0_47F25BC801DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *508FEA3B02B0_47F25BC801DB_impl*
end;//vcmStr
{$IfEnd} // NOT Defined(NoVCM)

end.
