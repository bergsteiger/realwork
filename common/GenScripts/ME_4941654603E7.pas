unit sdsCommonDiction;
 {* Обобщённый словарь }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\sdsCommonDiction.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "TsdsCommonDiction" MUID: (4941654603E7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , CommonDictionInterfaces
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , DynamicTreeUnit
 , l3IID
 , QueryCardInterfaces
 , BaseDocumentWithAttributesInterfaces
 , DocumentAndListInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _SetDataType_ = IdCommonDiction;
 _SetType_ = IsdsCommonDiction;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\sdsCommonDiction.imp.pas}
 TsdsCommonDiction = class(_sdsCommonDiction_)
  {* Обобщённый словарь }
  protected
   {$If NOT Defined(NoVCM)}
   function MakeData: _SetDataType_; override;
    {* Данные сборки. }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsCommonDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsSaveLoad
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmFormSetRefreshParams
 {$IfEnd} // NOT Defined(NoVCM)
 , afwFacade
 , l3Base
 , dCommonDiction
 , dsChild
 , dsAttributes
 , l3Types
 , bsUtils
 , l3Utils
 , deDocInfo
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
;

type _Instance_R_ = TsdsCommonDiction;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\sdsCommonDiction.imp.pas}

{$If NOT Defined(NoVCM)}
function TsdsCommonDiction.MakeData: _SetDataType_;
 {* Данные сборки. }
//#UC START# *47F3778403D9_4941654603E7_var*
//#UC END# *47F3778403D9_4941654603E7_var*
begin
//#UC START# *47F3778403D9_4941654603E7_impl*
 Result := TdCommonDiction.Make;
//#UC END# *47F3778403D9_4941654603E7_impl*
end;//TsdsCommonDiction.MakeData
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
