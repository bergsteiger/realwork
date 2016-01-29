{$IfNDef nevStringCache_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevStringCache.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::StringCache::nevStringCache
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevStringCache_imp}
 TevParaStringsRange = 1..3;

 TevParaStrings = array [TevParaStringsRange] of Tl3CustomString;

 _nevStringCacheHackBecauseMl3Uknown_Parent_ = _nevStringCache_Parent_;
 {$Include ..\Everest\nevStringCacheHackBecauseMl3Uknown.imp.pas}
 _nevStringCache_ = {mixin} class(_nevStringCacheHackBecauseMl3Uknown_)
 private
 // private fields
   f_S : TevParaStrings;
 public
 // realized methods
   function CheckS(i: Integer): Tl3CustomString;
 protected
 // overridden protected methods
   procedure Release; override;
 end;//_nevStringCache_

{$Else nevStringCache_imp}

{$Include ..\Everest\nevStringCacheHackBecauseMl3Uknown.imp.pas}

// start class _nevStringCache_

function _nevStringCache_.CheckS(i: Integer): Tl3CustomString;
//#UC START# *4E5690220216_4E71FB8302C6_var*
//#UC END# *4E5690220216_4E71FB8302C6_var*
begin
//#UC START# *4E5690220216_4E71FB8302C6_impl*
 if (f_S[i] = nil) then
  f_S[i] := TevParaString.Create;
 Result := f_S[i];
//#UC END# *4E5690220216_4E71FB8302C6_impl*
end;//_nevStringCache_.CheckS

procedure _nevStringCache_.Release;
//#UC START# *479F2AFB0397_4E71FB8302C6_var*
var
 i : Integer;
//#UC END# *479F2AFB0397_4E71FB8302C6_var*
begin
//#UC START# *479F2AFB0397_4E71FB8302C6_impl*
 for i := Low(f_S) to High(f_S) do
  FreeAndNil(f_S[i]);
//#UC END# *479F2AFB0397_4E71FB8302C6_impl*
end;//_nevStringCache_.Release

{$EndIf nevStringCache_imp}
