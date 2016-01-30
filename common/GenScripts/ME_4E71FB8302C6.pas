{$IfNDef nevStringCache_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevStringCache.imp.pas"
// Стереотип: "Impurity"

{$Define nevStringCache_imp}

type
 TevParaStringsRange = 1 .. 3;

 TevParaStrings = array [TevParaStringsRange] of Tl3CustomString;

 _nevStringCacheHackBecauseMl3Uknown_Parent_ = _nevStringCache_Parent_;
 {$Include nevStringCacheHackBecauseMl3Uknown.imp.pas}
 _nevStringCache_ = class(_nevStringCacheHackBecauseMl3Uknown_)
  private
   f_S: TevParaStrings;
  protected
   procedure Release; override;
  public
   function CheckS(i: Integer): Tl3CustomString;
 end;//_nevStringCache_

{$Else nevStringCache_imp}

{$IfNDef nevStringCache_imp_impl}

{$Define nevStringCache_imp_impl}

{$Include nevStringCacheHackBecauseMl3Uknown.imp.pas}

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

{$EndIf nevStringCache_imp_impl}

{$EndIf nevStringCache_imp}

