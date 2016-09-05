unit NOT_FINISHED_evHyperlink;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evHyperlink.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevHyperlink" MUID: (4A269BB40125)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , nevNavigation
 , nevTools
 , afwNavigation
 , l3Types
 , evdTypes
 , l3Variant
;

type
 TevHyperlink = class(IevHyperlink)
  protected
   function Exists: Boolean;
    {* Проверяет существует ли данная ссылка }
   procedure Insert;
    {* Вставляет новую ссылку }
   procedure Delete;
    {* Удаляет гипертекстовую ссылку }
   function Get_ID: Integer;
   procedure Set_ID(aValue: Integer);
   function pm_GetPara: InevPara;
   function pm_GetAddressList: IevAddressList;
   function pm_GetAddress: TevAddress;
   procedure pm_SetAddress(const aValue: TevAddress);
   function pm_GetURL: Tl3PCharLen;
   procedure pm_SetURL(const aValue: Tl3PCharLen);
   function pm_GetHint: Tl3PCharLen;
   procedure pm_SetHint(const aValue: Tl3PCharLen);
   function pm_GetKind: TevLinkViewKind;
   procedure pm_SetKind(aValue: TevLinkViewKind);
   function Get_FromDocumentExternalHandle: Integer;
   function Get_TargetDocumentID: Integer;
   function Get_Name: Tl3PCharLen;
   function GetHyperlink: Tl3Tag;
 end;//TevHyperlink
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 //#UC START# *4A269BB40125impl_uses*
 //#UC END# *4A269BB40125impl_uses*
;

function TevHyperlink.Exists: Boolean;
 {* Проверяет существует ли данная ссылка }
//#UC START# *49E5FCF403BB_4A269BB40125_var*
//#UC END# *49E5FCF403BB_4A269BB40125_var*
begin
//#UC START# *49E5FCF403BB_4A269BB40125_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E5FCF403BB_4A269BB40125_impl*
end;//TevHyperlink.Exists

procedure TevHyperlink.Insert;
 {* Вставляет новую ссылку }
//#UC START# *49E5FD13001E_4A269BB40125_var*
//#UC END# *49E5FD13001E_4A269BB40125_var*
begin
//#UC START# *49E5FD13001E_4A269BB40125_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E5FD13001E_4A269BB40125_impl*
end;//TevHyperlink.Insert

procedure TevHyperlink.Delete;
 {* Удаляет гипертекстовую ссылку }
//#UC START# *49E5FD1D0339_4A269BB40125_var*
//#UC END# *49E5FD1D0339_4A269BB40125_var*
begin
//#UC START# *49E5FD1D0339_4A269BB40125_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E5FD1D0339_4A269BB40125_impl*
end;//TevHyperlink.Delete

function TevHyperlink.Get_ID: Integer;
//#UC START# *49E5FD3C021B_4A269BB40125get_var*
//#UC END# *49E5FD3C021B_4A269BB40125get_var*
begin
//#UC START# *49E5FD3C021B_4A269BB40125get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E5FD3C021B_4A269BB40125get_impl*
end;//TevHyperlink.Get_ID

procedure TevHyperlink.Set_ID(aValue: Integer);
//#UC START# *49E5FD3C021B_4A269BB40125set_var*
//#UC END# *49E5FD3C021B_4A269BB40125set_var*
begin
//#UC START# *49E5FD3C021B_4A269BB40125set_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E5FD3C021B_4A269BB40125set_impl*
end;//TevHyperlink.Set_ID

function TevHyperlink.pm_GetPara: InevPara;
//#UC START# *49E6095100C3_4A269BB40125get_var*
//#UC END# *49E6095100C3_4A269BB40125get_var*
begin
//#UC START# *49E6095100C3_4A269BB40125get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E6095100C3_4A269BB40125get_impl*
end;//TevHyperlink.pm_GetPara

function TevHyperlink.pm_GetAddressList: IevAddressList;
//#UC START# *49E609B701E8_4A269BB40125get_var*
//#UC END# *49E609B701E8_4A269BB40125get_var*
begin
//#UC START# *49E609B701E8_4A269BB40125get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E609B701E8_4A269BB40125get_impl*
end;//TevHyperlink.pm_GetAddressList

function TevHyperlink.pm_GetAddress: TevAddress;
//#UC START# *49E609D303A4_4A269BB40125get_var*
//#UC END# *49E609D303A4_4A269BB40125get_var*
begin
//#UC START# *49E609D303A4_4A269BB40125get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E609D303A4_4A269BB40125get_impl*
end;//TevHyperlink.pm_GetAddress

procedure TevHyperlink.pm_SetAddress(const aValue: TevAddress);
//#UC START# *49E609D303A4_4A269BB40125set_var*
//#UC END# *49E609D303A4_4A269BB40125set_var*
begin
//#UC START# *49E609D303A4_4A269BB40125set_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E609D303A4_4A269BB40125set_impl*
end;//TevHyperlink.pm_SetAddress

function TevHyperlink.pm_GetURL: Tl3PCharLen;
//#UC START# *49E609FD0318_4A269BB40125get_var*
//#UC END# *49E609FD0318_4A269BB40125get_var*
begin
//#UC START# *49E609FD0318_4A269BB40125get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E609FD0318_4A269BB40125get_impl*
end;//TevHyperlink.pm_GetURL

procedure TevHyperlink.pm_SetURL(const aValue: Tl3PCharLen);
//#UC START# *49E609FD0318_4A269BB40125set_var*
//#UC END# *49E609FD0318_4A269BB40125set_var*
begin
//#UC START# *49E609FD0318_4A269BB40125set_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E609FD0318_4A269BB40125set_impl*
end;//TevHyperlink.pm_SetURL

function TevHyperlink.pm_GetHint: Tl3PCharLen;
//#UC START# *49E60A1B02C4_4A269BB40125get_var*
//#UC END# *49E60A1B02C4_4A269BB40125get_var*
begin
//#UC START# *49E60A1B02C4_4A269BB40125get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E60A1B02C4_4A269BB40125get_impl*
end;//TevHyperlink.pm_GetHint

procedure TevHyperlink.pm_SetHint(const aValue: Tl3PCharLen);
//#UC START# *49E60A1B02C4_4A269BB40125set_var*
//#UC END# *49E60A1B02C4_4A269BB40125set_var*
begin
//#UC START# *49E60A1B02C4_4A269BB40125set_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E60A1B02C4_4A269BB40125set_impl*
end;//TevHyperlink.pm_SetHint

function TevHyperlink.pm_GetKind: TevLinkViewKind;
//#UC START# *49E60A650155_4A269BB40125get_var*
//#UC END# *49E60A650155_4A269BB40125get_var*
begin
//#UC START# *49E60A650155_4A269BB40125get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E60A650155_4A269BB40125get_impl*
end;//TevHyperlink.pm_GetKind

procedure TevHyperlink.pm_SetKind(aValue: TevLinkViewKind);
//#UC START# *49E60A650155_4A269BB40125set_var*
//#UC END# *49E60A650155_4A269BB40125set_var*
begin
//#UC START# *49E60A650155_4A269BB40125set_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E60A650155_4A269BB40125set_impl*
end;//TevHyperlink.pm_SetKind

function TevHyperlink.Get_FromDocumentExternalHandle: Integer;
//#UC START# *4A72AAF50077_4A269BB40125get_var*
//#UC END# *4A72AAF50077_4A269BB40125get_var*
begin
//#UC START# *4A72AAF50077_4A269BB40125get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A72AAF50077_4A269BB40125get_impl*
end;//TevHyperlink.Get_FromDocumentExternalHandle

function TevHyperlink.Get_TargetDocumentID: Integer;
//#UC START# *4A72ABEF02AE_4A269BB40125get_var*
//#UC END# *4A72ABEF02AE_4A269BB40125get_var*
begin
//#UC START# *4A72ABEF02AE_4A269BB40125get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A72ABEF02AE_4A269BB40125get_impl*
end;//TevHyperlink.Get_TargetDocumentID

function TevHyperlink.Get_Name: Tl3PCharLen;
//#UC START# *4A72B4140281_4A269BB40125get_var*
//#UC END# *4A72B4140281_4A269BB40125get_var*
begin
//#UC START# *4A72B4140281_4A269BB40125get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A72B4140281_4A269BB40125get_impl*
end;//TevHyperlink.Get_Name

function TevHyperlink.GetHyperlink: Tl3Tag;
//#UC START# *5063FF170259_4A269BB40125_var*
//#UC END# *5063FF170259_4A269BB40125_var*
begin
//#UC START# *5063FF170259_4A269BB40125_impl*
 !!! Needs to be implemented !!!
//#UC END# *5063FF170259_4A269BB40125_impl*
end;//TevHyperlink.GetHyperlink
{$IfEnd} // Defined(evNeedHotSpot)

end.
