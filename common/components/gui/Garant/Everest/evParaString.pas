unit evParaString;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evParaString.pas"
// Начат: 25.08.2011 21:44
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::StringCache::TevParaString
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Types,
  l3CustomString,
  l3Interfaces
  ;

type
 TevParaString = class(Tl3CustomString)
 private
 // private fields
   f_St : Tl3PCharLen;
 protected
 // overridden property methods
   function pm_GetLen: Integer; override;
   procedure pm_SetLen(aValue: Integer); override;
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
   function GetAsPCharLen: Tl3WString; override;
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
   procedure DoSetCodePage(aValue: Integer); override;
 public
 // overridden public methods
   procedure Clear; override;
     {* Функция очистки объекта.  Для перекрытия в потомках. }
   function Offset(Delta: Integer): Tl3CustomString; override;
 end;//TevParaString

implementation

// start class TevParaString

{$If not defined(DesignTimeLibrary)}
class function TevParaString.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4E5689DF037B_var*
//#UC END# *47A6FEE600FC_4E5689DF037B_var*
begin
//#UC START# *47A6FEE600FC_4E5689DF037B_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4E5689DF037B_impl*
end;//TevParaString.IsCacheable
{$IfEnd} //not DesignTimeLibrary

function TevParaString.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_4E5689DF037B_var*
//#UC END# *47A869BB02DE_4E5689DF037B_var*
begin
//#UC START# *47A869BB02DE_4E5689DF037B_impl*
 Result := f_St;
//#UC END# *47A869BB02DE_4E5689DF037B_impl*
end;//TevParaString.GetAsPCharLen

procedure TevParaString.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_4E5689DF037B_var*
//#UC END# *47A869D10074_4E5689DF037B_var*
begin
//#UC START# *47A869D10074_4E5689DF037B_impl*
 f_St := Value;
//#UC END# *47A869D10074_4E5689DF037B_impl*
end;//TevParaString.DoSetAsPCharLen

procedure TevParaString.Clear;
//#UC START# *47BC02A50131_4E5689DF037B_var*
//#UC END# *47BC02A50131_4E5689DF037B_var*
begin
//#UC START# *47BC02A50131_4E5689DF037B_impl*
 f_St.Init;
//#UC END# *47BC02A50131_4E5689DF037B_impl*
end;//TevParaString.Clear

function TevParaString.Offset(Delta: Integer): Tl3CustomString;
//#UC START# *4E568A7E0120_4E5689DF037B_var*
//#UC END# *4E568A7E0120_4E5689DF037B_var*
begin
//#UC START# *4E568A7E0120_4E5689DF037B_impl*
 if not Empty then
  f_St.Shift(Delta);
 Result := Self;
//#UC END# *4E568A7E0120_4E5689DF037B_impl*
end;//TevParaString.Offset

procedure TevParaString.DoSetCodePage(aValue: Integer);
//#UC START# *4E568AB6016C_4E5689DF037B_var*
//#UC END# *4E568AB6016C_4E5689DF037B_var*
begin
//#UC START# *4E568AB6016C_4E5689DF037B_impl*
 f_St.SCodePage := aValue;
//#UC END# *4E568AB6016C_4E5689DF037B_impl*
end;//TevParaString.DoSetCodePage

function TevParaString.pm_GetLen: Integer;
//#UC START# *54C63008010F_4E5689DF037Bget_var*
//#UC END# *54C63008010F_4E5689DF037Bget_var*
begin
//#UC START# *54C63008010F_4E5689DF037Bget_impl*
 Result := inherited pm_GetLen;
//#UC END# *54C63008010F_4E5689DF037Bget_impl*
end;//TevParaString.pm_GetLen

procedure TevParaString.pm_SetLen(aValue: Integer);
//#UC START# *54C63008010F_4E5689DF037Bset_var*
//#UC END# *54C63008010F_4E5689DF037Bset_var*
begin
//#UC START# *54C63008010F_4E5689DF037Bset_impl*
 f_St.SLen := aValue;
//#UC END# *54C63008010F_4E5689DF037Bset_impl*
end;//TevParaString.pm_SetLen

end.