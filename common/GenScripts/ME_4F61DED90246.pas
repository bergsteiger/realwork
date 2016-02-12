unit npControls;
 {* указывает от какого навигатора на форме был отстыкован компонент }

// Модуль: "w:\common\components\gui\Garant\VT\npControls.pas"
// Стереотип: "SimpleClass"

{$Include vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtNavigator
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TControl;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TnpControls = class(_l3ObjectPtrList_)
  {* указывает от какого навигатора на форме был отстыкован компонент }
  private
   f_Navigator: TvtNavigatorPrim;
    {* Поле для свойства Navigator }
  protected
  public
   function DeleteControl(aControl: TControl): Boolean;
   constructor Create(aNavigator: TvtNavigatorPrim); reintroduce;
  public
   property Navigator: TvtNavigatorPrim
    read f_Navigator;
 end;//TnpControls
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

type _Instance_R_ = TnpControls;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

function TnpControls.DeleteControl(aControl: TControl): Boolean;
//#UC START# *4F61EDD001B7_4F61DED90246_var*
var
 l_Index : Integer;
//#UC END# *4F61EDD001B7_4F61DED90246_var*
begin
//#UC START# *4F61EDD001B7_4F61DED90246_impl*
 Result := false;
 l_Index := IndexOf(aControl);
 if (l_Index <> -1) then
 begin
  Delete(l_Index);
  Result := true;
 end;//l_Index <> -1
//#UC END# *4F61EDD001B7_4F61DED90246_impl*
end;//TnpControls.DeleteControl

constructor TnpControls.Create(aNavigator: TvtNavigatorPrim);
//#UC START# *4F61F57501B6_4F61DED90246_var*
//#UC END# *4F61F57501B6_4F61DED90246_var*
begin
//#UC START# *4F61F57501B6_4F61DED90246_impl*
 inherited Create;
 f_Navigator := aNavigator;
//#UC END# *4F61F57501B6_4F61DED90246_impl*
end;//TnpControls.Create
{$IfEnd} // NOT Defined(NoVCM)

end.
