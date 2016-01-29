unit nsPrimNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsPrimNode.pas"
// Начат: 21.10.2009 14:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::OldTree::TnsPrimNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  eeVirtualNode
  ;

type
 TnsPrimNode = {abstract} class(TeeVirtualNode)
 protected
 // overridden protected methods
   function DoGetNumInParent(aOnlyOneLevel: Boolean = False): Integer; override;
 protected
 // protected fields
   f_NumInParent : Integer;
 public
 // public methods
   constructor Create(aNumInParent: Integer); reintroduce;
 end;//TnsPrimNode

implementation

// start class TnsPrimNode

constructor TnsPrimNode.Create(aNumInParent: Integer);
//#UC START# *4AE030AF029D_4ADDF4020322_var*
//#UC END# *4AE030AF029D_4ADDF4020322_var*
begin
//#UC START# *4AE030AF029D_4ADDF4020322_impl*
 inherited Create;
 f_NumInParent := aNumInParent;
//#UC END# *4AE030AF029D_4ADDF4020322_impl*
end;//TnsPrimNode.Create

function TnsPrimNode.DoGetNumInParent(aOnlyOneLevel: Boolean = False): Integer;
//#UC START# *54C8E1F30128_4ADDF4020322_var*
//#UC END# *54C8E1F30128_4ADDF4020322_var*
begin
//#UC START# *54C8E1F30128_4ADDF4020322_impl*
 if aOnlyOneLevel then
 begin
  if (f_NumInParent < 0) then
   f_NumInParent := inherited DoGetNumInParent(true);
  Result := f_NumInParent;
 end//aOnlyOneLevel
 else
  Result := inherited DoGetNumInParent(aOnlyOneLevel);
//#UC END# *54C8E1F30128_4ADDF4020322_impl*
end;//TnsPrimNode.DoGetNumInParent

end.