unit nevSectionBreakList;
 {* Список разрывов разделов }

// Модуль: "w:\common\components\gui\Garant\Everest\nevSectionBreakList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevSectionBreakList" MUID: (49180FCE035B)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevSectionBreakListPrim
 , nevTools
;

type
 TnevSectionBreakList = class(TnevSectionBreakListPrim, InevSectionBreaks)
  {* Список разрывов разделов }
  protected
   function GetSectionWidth(const aChild: InevObject;
    out theWidth: Integer): Boolean;
   function GetSectionBreak(const aChild: InevObject;
    out theBreak: InevObject): Boolean;
    {* Возвращает разрыв раздела для указанного дочернего элемента }
 end;//TnevSectionBreakList

implementation

uses
 l3ImplUses
 , evSectionPara
 //#UC START# *49180FCE035Bimpl_uses*
 //#UC END# *49180FCE035Bimpl_uses*
;

function TnevSectionBreakList.GetSectionWidth(const aChild: InevObject;
 out theWidth: Integer): Boolean;
//#UC START# *491933680169_49180FCE035B_var*
var
 l_Break : InevObject;
//#UC END# *491933680169_49180FCE035B_var*
begin
//#UC START# *491933680169_49180FCE035B_impl*
 Result := GetSectionBreak(aChild, l_Break);
 if Result then
  theWidth := evSectionExtent(l_Break.AsObject).X;
//#UC END# *491933680169_49180FCE035B_impl*
end;//TnevSectionBreakList.GetSectionWidth

function TnevSectionBreakList.GetSectionBreak(const aChild: InevObject;
 out theBreak: InevObject): Boolean;
 {* Возвращает разрыв раздела для указанного дочернего элемента }
//#UC START# *4C0CF53A01A4_49180FCE035B_var*
var
 l_Index : Integer;
//#UC END# *4C0CF53A01A4_49180FCE035B_var*
begin
//#UC START# *4C0CF53A01A4_49180FCE035B_impl*
 Result := false;
 // - мы пессимисты
 if FindData(aChild, l_Index) then
  // - нашли собственно раздел
  theBreak := Items[l_Index]
 else
 if (l_Index > 0) then
  // - нашли место вставки параграфа
  theBreak := Items[Pred(l_Index)]
 else
  // - параграф находится перед первым разделом
  Exit;
 Result := true;
 // - подходящий раздел найден
//#UC END# *4C0CF53A01A4_49180FCE035B_impl*
end;//TnevSectionBreakList.GetSectionBreak

end.
