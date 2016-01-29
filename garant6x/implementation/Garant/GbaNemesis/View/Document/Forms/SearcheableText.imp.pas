{$IfNDef SearcheableText_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Forms/SearcheableText.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Document::SearcheableText
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define SearcheableText_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _PrimText_Parent_ = _SearcheableText_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PrimText.imp.pas}
 _BaseSearchPresentation_Parent_ = _PrimText_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas}
 _SearcheableText_ = {abstract form} class(_BaseSearchPresentation_, InsBaseSearchPresentation)
 protected
 // realized methods
   function WindowRequired: Boolean;
   function WindowCloseable: Boolean;
   function CanCloseWindow: Boolean;
   function IsQueryCard: Boolean;
   function TreatSuccessSearchAsManualOpen: Boolean;
   function AutoActivateWindow: Boolean;
   function Get_ContainerForBaseSearch: TnsContainerForBaseSearchInfo;
   function Get_ContextSearcher: InsContextSearcher;
   function Get_NeedSaveActiveClassBeforeSearch: Boolean;
 end;//_SearcheableText_
{$Else}

 _PrimText_Parent_ = _SearcheableText_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PrimText.imp.pas}
 _BaseSearchPresentation_Parent_ = _PrimText_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas}
 _SearcheableText_ = _BaseSearchPresentation_;

{$IfEnd} //not Admin AND not Monitorings

{$Else SearcheableText_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PrimText.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas}

// start class _SearcheableText_

function _SearcheableText_.WindowRequired: Boolean;
//#UC START# *496B4C41023E_496B68FC000B_var*
//#UC END# *496B4C41023E_496B68FC000B_var*
begin
//#UC START# *496B4C41023E_496B68FC000B_impl*
 Result := False;
//#UC END# *496B4C41023E_496B68FC000B_impl*
end;//_SearcheableText_.WindowRequired

function _SearcheableText_.WindowCloseable: Boolean;
//#UC START# *496B4C500246_496B68FC000B_var*
//#UC END# *496B4C500246_496B68FC000B_var*
begin
//#UC START# *496B4C500246_496B68FC000B_impl*
 Result := True;
//#UC END# *496B4C500246_496B68FC000B_impl*
end;//_SearcheableText_.WindowCloseable

function _SearcheableText_.CanCloseWindow: Boolean;
//#UC START# *496B4CA000B6_496B68FC000B_var*
//#UC END# *496B4CA000B6_496B68FC000B_var*
begin
//#UC START# *496B4CA000B6_496B68FC000B_impl*
 Result := True;
//#UC END# *496B4CA000B6_496B68FC000B_impl*
end;//_SearcheableText_.CanCloseWindow

function _SearcheableText_.IsQueryCard: Boolean;
//#UC START# *496B4CD9005F_496B68FC000B_var*
//#UC END# *496B4CD9005F_496B68FC000B_var*
begin
//#UC START# *496B4CD9005F_496B68FC000B_impl*
 Result := False;
//#UC END# *496B4CD9005F_496B68FC000B_impl*
end;//_SearcheableText_.IsQueryCard

function _SearcheableText_.TreatSuccessSearchAsManualOpen: Boolean;
//#UC START# *496B4CE30132_496B68FC000B_var*
//#UC END# *496B4CE30132_496B68FC000B_var*
begin
//#UC START# *496B4CE30132_496B68FC000B_impl*
 Result := False;
//#UC END# *496B4CE30132_496B68FC000B_impl*
end;//_SearcheableText_.TreatSuccessSearchAsManualOpen

function _SearcheableText_.AutoActivateWindow: Boolean;
//#UC START# *496B4CED0306_496B68FC000B_var*
//#UC END# *496B4CED0306_496B68FC000B_var*
begin
//#UC START# *496B4CED0306_496B68FC000B_impl*
 Result := False;
//#UC END# *496B4CED0306_496B68FC000B_impl*
end;//_SearcheableText_.AutoActivateWindow

function _SearcheableText_.Get_ContainerForBaseSearch: TnsContainerForBaseSearchInfo;
//#UC START# *4ACA195801CB_496B68FC000Bget_var*
//#UC END# *4ACA195801CB_496B68FC000Bget_var*
begin
//#UC START# *4ACA195801CB_496B68FC000Bget_impl*
 Result.rContainer := nil;
 Result.rZone := vcm_ztAny;
//#UC END# *4ACA195801CB_496B68FC000Bget_impl*
end;//_SearcheableText_.Get_ContainerForBaseSearch

function _SearcheableText_.Get_ContextSearcher: InsContextSearcher;
//#UC START# *4AD6EAA3034A_496B68FC000Bget_var*
var
 l_P : InsBaseSearchPresentation;
//#UC END# *4AD6EAA3034A_496B68FC000Bget_var*
begin
//#UC START# *4AD6EAA3034A_496B68FC000Bget_impl*
 if (UserType = dftAACRight) then
 begin
  l_P := Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(Aggregate);
  if (l_P <> nil) then
  begin
   Result := l_P.ContextSearcher;
   Assert(Result <> nil);
   Exit;
  end;//l_P <> nil
 end;//UserType = dftAACRight
 Result := Self;
//#UC END# *4AD6EAA3034A_496B68FC000Bget_impl*
end;//_SearcheableText_.Get_ContextSearcher

function _SearcheableText_.Get_NeedSaveActiveClassBeforeSearch: Boolean;
//#UC START# *4F1D607E0027_496B68FC000Bget_var*
//#UC END# *4F1D607E0027_496B68FC000Bget_var*
begin
//#UC START# *4F1D607E0027_496B68FC000Bget_impl*
 Result := false;
 // - тут вообще говоря зависит от того - локальный поиск или глобальный
//#UC END# *4F1D607E0027_496B68FC000Bget_impl*
end;//_SearcheableText_.Get_NeedSaveActiveClassBeforeSearch

{$IfEnd} //not Admin AND not Monitorings

{$EndIf SearcheableText_imp}
