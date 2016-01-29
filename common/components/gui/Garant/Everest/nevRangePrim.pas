unit nevRangePrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/nevRangePrim.pas"
// Начат: 24.03.2010 17:54
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TnevRangePrim
//
// Выделенная часть объекта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  nevTools,
  evLocation,
  l3Types
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TnevRangePrim = class(TevLocation, InevRangePrim)
  {* Выделенная часть объекта }
 protected
 // realized methods
   {iterator} function Iterate(anAction: InevRangePrim_Iterate_Action;
    aStart: Integer = l3MinIndex): Integer; virtual;
     {* Итератор по вложенным выделенным объектам }
   {iterator} function IterateF(anAction: InevRangePrim_Iterate_Action;
    aStart: Integer = l3MinIndex): Integer;
     {* Итератор по вложенным выделенным объектам }
 end;//TnevRangePrim
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  evSelection,
  nevFacade,
  l3Base
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

// start class TnevRangePrim

{iterator} function TnevRangePrim.Iterate(anAction: InevRangePrim_Iterate_Action;
  aStart: Integer = l3MinIndex): Integer;
//#UC START# *4BA8DE8C03D8_4BAA279500E6_var*

 function _DoChild(const aBlock: InevRange; anIndex: Long): Boolean;
 begin//_DoChild
  Iterate := anIndex;
  Result := anAction(aBlock, anIndex);
 end;//_DoChild

//#UC END# *4BA8DE8C03D8_4BAA279500E6_var*
begin
//#UC START# *4BA8DE8C03D8_4BAA279500E6_impl*
 Result := -1;
 TevRange(Self).DoIterateF(evL2TSA(@_DoChild), nil, nil, aStart);
//#UC END# *4BA8DE8C03D8_4BAA279500E6_impl*
end;//TnevRangePrim.Iterate

{iterator} function TnevRangePrim.IterateF(anAction: InevRangePrim_Iterate_Action;
  aStart: Integer = l3MinIndex): Integer;
var
 Hack : Pointer absolute anAction;
begin
 try
  Result := Iterate(anAction, aStart);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;

{$IfEnd} //evUseVisibleCursors

end.