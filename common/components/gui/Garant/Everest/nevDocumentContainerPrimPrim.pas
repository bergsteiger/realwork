unit nevDocumentContainerPrimPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevDocumentContainerPrimPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Document::TnevDocumentContainerPrimPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Variant
  ;

type
 TnevDocumentContainerPrimPrim = class(Tl3Variant, IUnknown)
 protected
 // overridden property methods
   function pm_GetTagOwner: Tl3Variant; override;
   procedure pm_SetTagOwner(aValue: Tl3Variant); override;
 protected
 // overridden protected methods
   function DoMarkModified: Boolean; override;
   function GetTagType: Tl3VariantDef; override;
 end;//TnevDocumentContainerPrimPrim

implementation

uses
  DocumentContainer_Const,
  l3InterfacesMisc,
  k2NullTagImpl,
  l3String,
  l3IID
  ;

// start class TnevDocumentContainerPrimPrim

function TnevDocumentContainerPrimPrim.DoMarkModified: Boolean;
//#UC START# *4C6D1C29031F_53270D0E02E4_var*
//#UC END# *4C6D1C29031F_53270D0E02E4_var*
begin
//#UC START# *4C6D1C29031F_53270D0E02E4_impl*
 Result := false;
//#UC END# *4C6D1C29031F_53270D0E02E4_impl*
end;//TnevDocumentContainerPrimPrim.DoMarkModified

function TnevDocumentContainerPrimPrim.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_53270D0E02E4_var*
//#UC END# *533121AF0203_53270D0E02E4_var*
begin
//#UC START# *533121AF0203_53270D0E02E4_impl*
 Result := k2_typDocumentContainer;
//#UC END# *533121AF0203_53270D0E02E4_impl*
end;//TnevDocumentContainerPrimPrim.GetTagType

function TnevDocumentContainerPrimPrim.pm_GetTagOwner: Tl3Variant;
//#UC START# *53343980014A_53270D0E02E4get_var*
//#UC END# *53343980014A_53270D0E02E4get_var*
begin
//#UC START# *53343980014A_53270D0E02E4get_impl*
 Result := Tk2NullTagImpl.Instance;
//#UC END# *53343980014A_53270D0E02E4get_impl*
end;//TnevDocumentContainerPrimPrim.pm_GetTagOwner

procedure TnevDocumentContainerPrimPrim.pm_SetTagOwner(aValue: Tl3Variant);
//#UC START# *53343980014A_53270D0E02E4set_var*
//#UC END# *53343980014A_53270D0E02E4set_var*
begin
//#UC START# *53343980014A_53270D0E02E4set_impl*
 Assert(false);
//#UC END# *53343980014A_53270D0E02E4set_impl*
end;//TnevDocumentContainerPrimPrim.pm_SetTagOwner

end.