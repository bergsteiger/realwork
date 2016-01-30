{$IfNDef sdsBaseDocumentWithAttributes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas"
// Стереотип: "UseCaseControllerImp"

{$Define sdsBaseDocumentWithAttributes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include sdsBaseDocument.imp.pas}
 _sdsBaseDocumentWithAttributes_ = {abstract} class(_sdsBaseDocument_, IsdsBaseDocumentWithAttributes)
  {* Документ с атрибутами }
  protected
   procedure DoOpenAttributes; virtual;
    {* - атрибуты. }
   function NeedMakeDSAttributes: Boolean; virtual;
    {* - необходимость создания БОФ атрибутов. }
   function GetHasAttributes: Boolean; virtual;
    {* Реализация HasAttributes }
   procedure OpenAttributes;
    {* атрибуты }
   function pm_GetdsAttributes: IdsAttributes;
   function pm_GetHasAttributes: Boolean;
   procedure ClearAllDS; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_sdsBaseDocumentWithAttributes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include sdsBaseDocument.imp.pas}
_sdsBaseDocumentWithAttributes_ = _sdsBaseDocument_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else sdsBaseDocumentWithAttributes_imp}

{$IfNDef sdsBaseDocumentWithAttributes_imp_impl}

{$Define sdsBaseDocumentWithAttributes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
type _Instance_R_ = _sdsBaseDocumentWithAttributes_;

{$Include sdsBaseDocument.imp.pas}

procedure _sdsBaseDocumentWithAttributes_.DoOpenAttributes;
 {* - атрибуты. }
//#UC START# *47FDDACC0101_47F0849400D0_var*
//#UC END# *47FDDACC0101_47F0849400D0_var*
begin
//#UC START# *47FDDACC0101_47F0849400D0_impl*
 with pm_GetdsAttributesRef do
  if IsEmpty then
   SetIfNeedMakeNo(vcm_nmForce);
 Refresh;
//#UC END# *47FDDACC0101_47F0849400D0_impl*
end;//_sdsBaseDocumentWithAttributes_.DoOpenAttributes

function _sdsBaseDocumentWithAttributes_.NeedMakeDSAttributes: Boolean;
 {* - необходимость создания БОФ атрибутов. }
//#UC START# *47FE03AE0225_47F0849400D0_var*
//#UC END# *47FE03AE0225_47F0849400D0_var*
begin
//#UC START# *47FE03AE0225_47F0849400D0_impl*
 Result := pm_GetHasAttributes;
//#UC END# *47FE03AE0225_47F0849400D0_impl*
end;//_sdsBaseDocumentWithAttributes_.NeedMakeDSAttributes

function _sdsBaseDocumentWithAttributes_.GetHasAttributes: Boolean;
 {* Реализация HasAttributes }
//#UC START# *49352CEF0222_47F0849400D0_var*
var
 l_HasAttributes: Tl3Bool;
//#UC END# *49352CEF0222_47F0849400D0_var*
begin
//#UC START# *49352CEF0222_47F0849400D0_impl*
 Result := False;
 if pm_GetHasDocument and
  not l3BoolCheck(SetData.HasAttributes, Result) then
 begin
  Result := l3BoolSet(pm_GetDocInfo.Doc.HasAttributes, l_HasAttributes);
  SetData.HasAttributes := l_HasAttributes;
 end;
//#UC END# *49352CEF0222_47F0849400D0_impl*
end;//_sdsBaseDocumentWithAttributes_.GetHasAttributes

procedure _sdsBaseDocumentWithAttributes_.OpenAttributes;
 {* атрибуты }
//#UC START# *492598700162_47F0849400D0_var*
//#UC END# *492598700162_47F0849400D0_var*
begin
//#UC START# *492598700162_47F0849400D0_impl*
 DoOpenAttributes;
//#UC END# *492598700162_47F0849400D0_impl*
end;//_sdsBaseDocumentWithAttributes_.OpenAttributes

function _sdsBaseDocumentWithAttributes_.pm_GetdsAttributes: IdsAttributes;
//#UC START# *5009A78501A6_47F0849400D0get_var*
//#UC END# *5009A78501A6_47F0849400D0get_var*
begin
//#UC START# *5009A78501A6_47F0849400D0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5009A78501A6_47F0849400D0get_impl*
end;//_sdsBaseDocumentWithAttributes_.pm_GetdsAttributes

function _sdsBaseDocumentWithAttributes_.pm_GetHasAttributes: Boolean;
//#UC START# *6DBD21E52E04_47F0849400D0get_var*
//#UC END# *6DBD21E52E04_47F0849400D0get_var*
begin
//#UC START# *6DBD21E52E04_47F0849400D0get_impl*
 Result := GetHasAttributes;
//#UC END# *6DBD21E52E04_47F0849400D0get_impl*
end;//_sdsBaseDocumentWithAttributes_.pm_GetHasAttributes

procedure _sdsBaseDocumentWithAttributes_.ClearAllDS;
//#UC START# *4925B7F00156_47F0849400D0_var*
//#UC END# *4925B7F00156_47F0849400D0_var*
begin
//#UC START# *4925B7F00156_47F0849400D0_impl*
 inherited;
 pm_GetdsAttributesRef.Referred := nil;
//#UC END# *4925B7F00156_47F0849400D0_impl*
end;//_sdsBaseDocumentWithAttributes_.ClearAllDS

{$If NOT Defined(NoVCM)}
procedure _sdsBaseDocumentWithAttributes_.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_47F0849400D0_var*
//#UC END# *4938F7E702B7_47F0849400D0_var*
begin
//#UC START# *4938F7E702B7_47F0849400D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_47F0849400D0_impl*
end;//_sdsBaseDocumentWithAttributes_.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf sdsBaseDocumentWithAttributes_imp_impl}

{$EndIf sdsBaseDocumentWithAttributes_imp}

