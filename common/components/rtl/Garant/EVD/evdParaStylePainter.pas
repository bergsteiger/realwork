unit evdParaStylePainter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/evdParaStylePainter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdParaStylePainter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2TagGen,
  evdLeafParaFilter,
  l3Variant
  ;

type
 TevdParaStylePainter = class(TevdLeafParaFilter)
 private
 // private fields
   f_TargetStyle : Integer;
    {* Поле для свойства TargetStyle}
 protected
 // property methods
   function pm_GetTargetStyle: Integer;
 protected
 // overridden protected methods
   procedure DoWritePara(aLeaf: Tl3Variant); override;
     {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 public
 // public methods
   class function SetTo(var theGenerator: Tk2TagGenerator;
     aTargetStyle: Integer): Pointer;
 public
 // public properties
   property TargetStyle: Integer
     read pm_GetTargetStyle;
     {* Стиль, которым будем красить все параграфы }
 end;//TevdParaStylePainter

implementation

uses
  k2Tags,
  k2OperationContainer,
  SysUtils
  ;

// start class TevdParaStylePainter

class function TevdParaStylePainter.SetTo(var theGenerator: Tk2TagGenerator;
  aTargetStyle: Integer): Pointer;
//#UC START# *535E2BDC0026_535E29A5027B_var*
//#UC END# *535E2BDC0026_535E29A5027B_var*
begin
//#UC START# *535E2BDC0026_535E29A5027B_impl*
 Result := inherited SetTo(theGenerator);
 (theGenerator as TevdParaStylePainter).f_TargetStyle := aTargetStyle;
//#UC END# *535E2BDC0026_535E29A5027B_impl*
end;//TevdParaStylePainter.SetTo

function TevdParaStylePainter.pm_GetTargetStyle: Integer;
//#UC START# *535E2B6A00F6_535E29A5027Bget_var*
//#UC END# *535E2B6A00F6_535E29A5027Bget_var*
begin
//#UC START# *535E2B6A00F6_535E29A5027Bget_impl*
 Result := f_TargetStyle;
//#UC END# *535E2B6A00F6_535E29A5027Bget_impl*
end;//TevdParaStylePainter.pm_GetTargetStyle

procedure TevdParaStylePainter.DoWritePara(aLeaf: Tl3Variant);
//#UC START# *49E4883E0176_535E29A5027B_var*
var
 l_C : Tk2OperationContainer;
//#UC END# *49E4883E0176_535E29A5027B_var*
begin
//#UC START# *49E4883E0176_535E29A5027B_impl*
 l_C := Tk2OperationContainer.Create(nil);
 try
  aLeaf.IntW[k2_tiStyle, l_C] := f_TargetStyle;
 finally
  FreeAndNil(l_C);
 end;//try..finally
 inherited;
//#UC END# *49E4883E0176_535E29A5027B_impl*
end;//TevdParaStylePainter.DoWritePara

end.