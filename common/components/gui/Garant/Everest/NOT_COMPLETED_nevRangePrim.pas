unit NOT_COMPLETED_nevRangePrim;
 {* Выделенная часть объекта }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_nevRangePrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevRangePrim" MUID: (4BAA279500E6)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evLocation
 , nevTools
 , l3Types
;

type
 TnevRangePrim = class(TevLocation, InevRangePrim)
  {* Выделенная часть объекта }
  protected
   function Iterate(anAction: InevRangePrim_Iterate_Action;
    aStart: Integer = l3Types.l3MinIndex): Integer; virtual;
    {* Итератор по вложенным выделенным объектам }
   function IterateF(anAction: InevRangePrim_Iterate_Action;
    aStart: Integer = l3Types.l3MinIndex): Integer;
    {* Итератор по вложенным выделенным объектам }
 end;//TnevRangePrim
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evSelection
 , nevFacade
 , l3Base
;

function TnevRangePrim.Iterate(anAction: InevRangePrim_Iterate_Action;
 aStart: Integer = l3Types.l3MinIndex): Integer;
 {* Итератор по вложенным выделенным объектам }
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

function TnevRangePrim.IterateF(anAction: InevRangePrim_Iterate_Action;
 aStart: Integer = l3Types.l3MinIndex): Integer;
 {* Итератор по вложенным выделенным объектам }
var
 Hack : Pointer absolute anAction;
begin
 try
  Result := Iterate(anAction, aStart);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;//TnevRangePrim.IterateF
{$IfEnd} // Defined(evUseVisibleCursors)

end.
