unit dsTreeAttributeFirstLevel;
 {* бизнес объект формы выбранные атрибуты дерева }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\dsTreeAttributeFirstLevel.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsTreeAttributeFirstLevel" MUID: (492447740299)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , QueryCardInterfaces
 , l3TreeInterfaces
 , SearchInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchDomainInterfaces
 , TreeInterfaces
 , bsInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _FormDataSourceType_ = IdsTreeAttributeFirstLevel;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Search\dsSituation.imp.pas}
 TdsTreeAttributeFirstLevel = class(_dsSituation_, IdsTreeAttributeFirstLevel)
  {* бизнес объект формы выбранные атрибуты дерева }
  protected
   function MakeSimpleTree: Il3SimpleTree; override;
    {* Создать данные дерева }
 end;//TdsTreeAttributeFirstLevel
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , nsAttributeOneLevelTreeStruct
 , SysUtils
 , bsUtils
 , l3Base
 , vtUtils
 , vtStdRes
 , DynamicTreeUnit
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
;

type _Instance_R_ = TdsTreeAttributeFirstLevel;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Search\dsSituation.imp.pas}

function TdsTreeAttributeFirstLevel.MakeSimpleTree: Il3SimpleTree;
 {* Создать данные дерева }
//#UC START# *47F4C2B9014A_492447740299_var*
//#UC END# *47F4C2B9014A_492447740299_var*
begin
//#UC START# *47F4C2B9014A_492447740299_impl*
 Result := TnsAttributeOneLevelTreeStruct.Make(PartData.Tag, False, True);
//#UC END# *47F4C2B9014A_492447740299_impl*
end;//TdsTreeAttributeFirstLevel.MakeSimpleTree
{$IfEnd} // NOT Defined(Admin)

end.
