unit npNavigatorListPrim;
 {* список навигаторов созданных в приложении. Список используется для рассылки сообщений }

// Модуль: "w:\common\components\gui\Garant\VT\npNavigatorListPrim.pas"
// Стереотип: "SimpleClass"

{$Include vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vtNavigator
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TvtNavigatorPrim;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TnpNavigatorListPrim = class(_l3ObjectPtrList_)
  {* список навигаторов созданных в приложении. Список используется для рассылки сообщений }
  public
   procedure Reg(aNavigator: TvtNavigatorPrim);
    {* зарегистрировать навигатор }
   procedure UnReg(aNavigator: TvtNavigatorPrim);
    {* дерегистрировать навигатор }
 end;//TnpNavigatorListPrim
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

type _Instance_R_ = TnpNavigatorListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

procedure TnpNavigatorListPrim.Reg(aNavigator: TvtNavigatorPrim);
 {* зарегистрировать навигатор }
//#UC START# *4F61E05F00EE_4F61DFF20168_var*
var
 lIndex : Integer;
//#UC END# *4F61E05F00EE_4F61DFF20168_var*
begin
//#UC START# *4F61E05F00EE_4F61DFF20168_impl*
 lIndex := IndexOf(Pointer(aNavigator));
 if (lIndex < 0) then
 // - чтобы ДВА раза не удалять, т.к. удаляется - ОДИН, как с канвой от Борланда
  Add(aNavigator);
//#UC END# *4F61E05F00EE_4F61DFF20168_impl*
end;//TnpNavigatorListPrim.Reg

procedure TnpNavigatorListPrim.UnReg(aNavigator: TvtNavigatorPrim);
 {* дерегистрировать навигатор }
//#UC START# *4F61E080034B_4F61DFF20168_var*
var
 lIndex : Integer;
//#UC END# *4F61E080034B_4F61DFF20168_var*
begin
//#UC START# *4F61E080034B_4F61DFF20168_impl*
 lIndex := IndexOf(Pointer(aNavigator));
 if (lIndex <> -1) then
  Delete(lIndex);
//#UC END# *4F61E080034B_4F61DFF20168_impl*
end;//TnpNavigatorListPrim.UnReg
{$IfEnd} // NOT Defined(NoVCM)

end.
