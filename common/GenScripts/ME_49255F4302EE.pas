unit dsAttributes;
 {* бизнес объект формы "Информация о документе" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsAttributes.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsAttributes" MUID: (49255F4302EE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , DocumentInterfaces
 , l3TreeInterfaces
 , TreeInterfaces
 , bsInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _InitDataType_ = IdeDocInfo;
 _FormDataSourceType_ = IdsAttributes;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}
 TdsAttributes = class(_dsSimpleTree_, IdsAttributes)
  {* бизнес объект формы "Информация о документе" }
  protected
   function MakeSimpleTree: Il3SimpleTree; override;
    {* Создать данные дерева }
   function pm_GetDocInfo: IdeDocInfo;
 end;//TdsAttributes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDocAttributeTreeStruct
 , SysUtils
 , l3Base
 , vtUtils
 , vtStdRes
 , DynamicTreeUnit
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
;

type _Instance_R_ = TdsAttributes;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}

function TdsAttributes.MakeSimpleTree: Il3SimpleTree;
 {* Создать данные дерева }
//#UC START# *47F4C2B9014A_49255F4302EE_var*
//#UC END# *47F4C2B9014A_49255F4302EE_var*
begin
//#UC START# *47F4C2B9014A_49255F4302EE_impl*
 if Assigned(PartData) and Assigned(PartData.Doc) then
  Result := TnsDocAttributeTreeStruct.Make(PartData.Doc)
 else
  Result := nil; 
//#UC END# *47F4C2B9014A_49255F4302EE_impl*
end;//TdsAttributes.MakeSimpleTree

function TdsAttributes.pm_GetDocInfo: IdeDocInfo;
//#UC START# *49255D4A0215_49255F4302EEget_var*
//#UC END# *49255D4A0215_49255F4302EEget_var*
begin
//#UC START# *49255D4A0215_49255F4302EEget_impl*
 Result := PartData;
//#UC END# *49255D4A0215_49255F4302EEget_impl*
end;//TdsAttributes.pm_GetDocInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
