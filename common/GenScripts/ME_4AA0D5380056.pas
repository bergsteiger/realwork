unit DayTips_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\DayTips_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "DayTips" MUID: (4AA0D5380056)
// Имя типа: "TDayTipsModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , CommonDictionInterfaces
 , DayTipsInterfaces
;

type
 TDayTipsModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure OpenTipsPrim(const aSDS: IsdsCommonDiction;
    const aContainer: IvcmContainer);
   procedure ShowDayTips;
  public
   procedure OpenTip(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Открывает совет дня }
   function ShowDayTipsAtStartup: IvcmEntityForm;
 end;//TDayTipsModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , PrimCommonDiction_utTips_UserType
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , sdsTips
 , nsStartupTips
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , DataAdapter
;

{$If NOT Defined(NoVCM)}
procedure TDayTipsModule.OpenTip(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Открывает совет дня }
//#UC START# *4AA11A2E0144_4AA0D5380056_var*
//#UC END# *4AA11A2E0144_4AA0D5380056_var*
begin
//#UC START# *4AA11A2E0144_4AA0D5380056_impl*
 OpenTipsPrim(TsdsTips.Make(aDocInfo), aContainer);
//#UC END# *4AA11A2E0144_4AA0D5380056_impl*
end;//TDayTipsModule.OpenTip

procedure TDayTipsModule.OpenTipsPrim(const aSDS: IsdsCommonDiction;
 const aContainer: IvcmContainer);
//#UC START# *4AA52EC603DC_4AA0D5380056_var*
//#UC END# *4AA52EC603DC_4AA0D5380056_var*
begin
//#UC START# *4AA52EC603DC_4AA0D5380056_impl*
 Tfs_Tips.Make(aSDS, aContainer);
//#UC END# *4AA52EC603DC_4AA0D5380056_impl*
end;//TDayTipsModule.OpenTipsPrim

function TDayTipsModule.ShowDayTipsAtStartup: IvcmEntityForm;
var l_Data: InsStartupTips;
//#UC START# *4AB9DAAC00AC_4AA0D5380056_var*
//#UC END# *4AB9DAAC00AC_4AA0D5380056_var*
begin
//#UC START# *4AB9DAAC00AC_4AA0D5380056_impl*
 l_Data := TnsStartupTips.Make;
 if Assigned(l_Data) then
  Result := TefStartupTips.MakeSingleChild(l_Data,
                                 CheckContainer(nil),
                                 vcm_ztFloating)
 else
  Result := nil;
//#UC END# *4AB9DAAC00AC_4AA0D5380056_impl*
end;//TDayTipsModule.ShowDayTipsAtStartup

procedure TDayTipsModule.ShowDayTips;
//#UC START# *4AB9DBA1038E_4AA0D5380056_var*
//#UC END# *4AB9DBA1038E_4AA0D5380056_var*
begin
//#UC START# *4AB9DBA1038E_4AA0D5380056_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB9DBA1038E_4AA0D5380056_impl*
end;//TDayTipsModule.ShowDayTips
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
