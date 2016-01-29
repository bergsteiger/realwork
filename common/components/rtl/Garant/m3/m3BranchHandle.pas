unit m3BranchHandle;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3BranchHandle.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3BranchHandle
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3BranchHandlePrim
  ;

type
 Tm3BranchHandle = class(Tm3BranchHandlePrim)
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public fields
   NormalForms : Pm3BranchHandlePrim;
 end;//Tm3BranchHandle

implementation

uses
  m3NormalFormsManager
  ;

// start class Tm3BranchHandle

procedure Tm3BranchHandle.Cleanup;
//#UC START# *479731C50290_5453ACDE0177_var*
//#UC END# *479731C50290_5453ACDE0177_var*
begin
//#UC START# *479731C50290_5453ACDE0177_impl*
 inherited;
 if Tm3NormalFormsManager.Exists then
  Tm3NormalFormsManager.Instance.FreeItem(NormalForms);
//#UC END# *479731C50290_5453ACDE0177_impl*
end;//Tm3BranchHandle.Cleanup

end.