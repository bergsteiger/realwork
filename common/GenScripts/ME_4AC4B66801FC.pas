unit vcmIEntityFormList;
 {* ������ IvcmEntityForm }

// ������: "w:\common\components\gui\Garant\VCM\implementation\vcmIEntityFormList.pas"
// ���������: "SimpleClass"
// ������� ������: "TvcmIEntityFormList" MUID: (4AC4B66801FC)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IvcmEntityForm;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TvcmIEntityFormList = class(_l3InterfaceRefList_)
  {* ������ IvcmEntityForm }
 end;//TvcmIEntityFormList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TvcmIEntityFormList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
