unit vcmUserTypesIterator;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmUserTypesIterator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmUserTypesIterator" MUID: (5582C3AD0167)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmInterfaces
 , vcmUserTypeDefList
 , vcmBase
;

type
 _ListType_ = TvcmUserTypeDefList;
 _ItemType_ = IvcmUserTypeDef;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmIterator.imp.pas}
 TvcmUserTypesIterator = class(_vcmIterator_, IvcmUserTypesIterator)
  protected
   function Next: IvcmUserTypeDef;
  public
   class function Make(aList: TvcmUserTypeDefList): IvcmUserTypesIterator; reintroduce;
 end;//TvcmUserTypesIterator
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmIterator.imp.pas}

class function TvcmUserTypesIterator.Make(aList: TvcmUserTypeDefList): IvcmUserTypesIterator;
var
 l_Inst : TvcmUserTypesIterator;
begin
 l_Inst := Create(aList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmUserTypesIterator.Make

function TvcmUserTypesIterator.Next: IvcmUserTypeDef;
//#UC START# *499560C601FD_5582C3AD0167_var*
//#UC END# *499560C601FD_5582C3AD0167_var*
begin
//#UC START# *499560C601FD_5582C3AD0167_impl*
 Result := GetNext;
//#UC END# *499560C601FD_5582C3AD0167_impl*
end;//TvcmUserTypesIterator.Next
{$IfEnd} // NOT Defined(NoVCM)

end.
