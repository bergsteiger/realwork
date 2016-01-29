{$IfNDef sdsBaseDocumentWithAttributes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/sdsBaseDocumentWithAttributes.imp.pas"
// Начат: 2007/06/14 08:06:12
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Core::Common::Business::BaseDocument::sdsBaseDocumentWithAttributes
//
// Документ с атрибутами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define sdsBaseDocumentWithAttributes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include ..\Document\sdsBaseDocument.imp.pas}
 _sdsBaseDocumentWithAttributes_ = {abstract ucc} class(_sdsBaseDocument_, IsdsBaseDocumentWithAttributes)
  {* Документ с атрибутами }
 protected
 // realized methods
   procedure OpenAttributes;
     {* атрибуты }
   function pm_GetDsAttributes: IdsAttributes;
   function DoGet_dsAttributes: IdsAttributes;
   function pm_GetdsAttributesRef: IvcmViewAreaControllerRef;
   function pm_GetHasAttributes: Boolean;
 protected
 // overridden protected methods
   procedure ClearAllDS; override;
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure DoOpenAttributes; virtual;
     {* - атрибуты. }
   function NeedMakeDSAttributes: Boolean; virtual;
     {* - необходимость создания БОФ атрибутов. }
   function GetHasAttributes: Boolean; virtual;
     {* Реализация HasAttributes }
 end;//_sdsBaseDocumentWithAttributes_
{$Else}

 {$Include ..\Document\sdsBaseDocument.imp.pas}
 _sdsBaseDocumentWithAttributes_ = _sdsBaseDocument_;

{$IfEnd} //not Admin AND not Monitorings

{$Else sdsBaseDocumentWithAttributes_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include ..\Document\sdsBaseDocument.imp.pas}

// start class _sdsBaseDocumentWithAttributes_

procedure _sdsBaseDocumentWithAttributes_.DoOpenAttributes;
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
//#UC START# *47FE03AE0225_47F0849400D0_var*
//#UC END# *47FE03AE0225_47F0849400D0_var*
begin
//#UC START# *47FE03AE0225_47F0849400D0_impl*
 Result := pm_GetHasAttributes;
//#UC END# *47FE03AE0225_47F0849400D0_impl*
end;//_sdsBaseDocumentWithAttributes_.NeedMakeDSAttributes

function _sdsBaseDocumentWithAttributes_.GetHasAttributes: Boolean;
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
//#UC START# *492598700162_47F0849400D0_var*
//#UC END# *492598700162_47F0849400D0_var*
begin
//#UC START# *492598700162_47F0849400D0_impl*
 DoOpenAttributes;
//#UC END# *492598700162_47F0849400D0_impl*
end;//_sdsBaseDocumentWithAttributes_.OpenAttributes

function _sdsBaseDocumentWithAttributes_.pm_GetDsAttributes: IdsAttributes;
//#UC START# *5009A78501A6_47F0849400D0get_var*
//#UC END# *5009A78501A6_47F0849400D0get_var*
begin
 with pm_GetdsAttributesRef do
 begin
  if IsEmpty
   //#UC START# *5009A78501A6_47F0849400D0get_need*
     AND (NeedMake <> vcm_nmNo)
     AND NeedMakeDSAttributes
   // - условие создания ViewArea
  //#UC END# *5009A78501A6_47F0849400D0get_need*
   then
    Referred := DoGet_dsAttributes;
  Result := IdsAttributes(Referred);
 end;//with pm_GetdsAttributesRef
end;

function _sdsBaseDocumentWithAttributes_.DoGet_dsAttributes: IdsAttributes;
//#UC START# *5009A78501A6_47F0849400D0area_var*
//#UC END# *5009A78501A6_47F0849400D0area_var*
begin
//#UC START# *5009A78501A6_47F0849400D0area_impl*
 Result := TdsAttributes.Make(Self, pm_GetDocInfo.Clone);
//#UC END# *5009A78501A6_47F0849400D0area_impl*
end;//_sdsBaseDocumentWithAttributes_.DoGet_dsAttributes

function _sdsBaseDocumentWithAttributes_.pm_GetdsAttributesRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsAttributesRef;
end;

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

{$If not defined(NoVCM)}
procedure _sdsBaseDocumentWithAttributes_.ClearAreas;
 {-}
begin
 pm_GetdsAttributesRef.Referred := nil;
 inherited;
end;//_sdsBaseDocumentWithAttributes_.ClearAreas
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

{$EndIf sdsBaseDocumentWithAttributes_imp}
