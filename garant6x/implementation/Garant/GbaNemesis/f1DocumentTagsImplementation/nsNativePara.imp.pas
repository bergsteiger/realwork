{$IfNDef nsNativePara_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsNativePara.imp.pas"
// Начат: 24.11.2010 20:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::TagDataProviders::nsNativePara
//
// "Родной" параграф. Не представлен нодой из адаптерного дерева
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsNativePara_imp}
 _nsNativePara_ = {mixin} class(_nsNativePara_Parent_)
  {* "Родной" параграф. Не представлен нодой из адаптерного дерева }
 public
 // public methods
   class function Make(aStub: Tl3Tag): Il3TagRef;
   constructor Create(aStub: Tl3Tag); reintroduce; overload; 
   constructor Create(aTypeID: Tk2Type); overload; 
 end;//_nsNativePara_

{$Else nsNativePara_imp}

// start class _nsNativePara_

class function _nsNativePara_.Make(aStub: Tl3Tag): Il3TagRef;
//#UC START# *4C6ACFE7038A_4CED4C700123_var*
var
 l_Inst : _nsNativePara_;
//#UC END# *4C6ACFE7038A_4CED4C700123_var*
begin
//#UC START# *4C6ACFE7038A_4CED4C700123_impl*
 l_Inst := Create(aStub);
 try
  Result := l_Inst.AsRef;
 finally
  l_Inst.Free;
 end;//try..finally
//#UC END# *4C6ACFE7038A_4CED4C700123_impl*
end;//_nsNativePara_.Make

constructor _nsNativePara_.Create(aStub: Tl3Tag);
//#UC START# *4C6ACF6D008A_4CED4C700123_var*
//#UC END# *4C6ACF6D008A_4CED4C700123_var*
begin
//#UC START# *4C6ACF6D008A_4CED4C700123_impl*
 Create(Tk2Type(aStub.TagType));
 AssignTag(aStub);
 Include(_Instance_R_(Self).f_State, ns_nsChanged);
//#UC END# *4C6ACF6D008A_4CED4C700123_impl*
end;//_nsNativePara_.Create

constructor _nsNativePara_.Create(aTypeID: Tk2Type);
//#UC START# *4CEFB6330350_4CED4C700123_var*
//#UC END# *4CEFB6330350_4CED4C700123_var*
begin
//#UC START# *4CEFB6330350_4CED4C700123_impl*
 inherited Create(aTypeID);
//#UC END# *4CEFB6330350_4CED4C700123_impl*
end;//_nsNativePara_.Create

{$EndIf nsNativePara_imp}
