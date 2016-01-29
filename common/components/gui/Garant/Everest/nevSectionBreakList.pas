unit nevSectionBreakList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/nevSectionBreakList.pas"
// Начат: 10.11.2008 13:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Document::TnevSectionBreakList
//
// Список разрывов разделов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevTools,
  nevSectionBreakListPrim
  ;

type
 TnevSectionBreakList = class(TnevSectionBreakListPrim, InevSectionBreaks)
  {* Список разрывов разделов }
 protected
 // realized methods
   function GetSectionWidth(const aChild: InevObject;
     out theWidth: Integer): Boolean;
   function GetSectionBreak(const aChild: InevObject;
     out theBreak: InevObject): Boolean;
     {* Возвращает разрыв раздела для указанного дочернего элемента }
 end;//TnevSectionBreakList

implementation

uses
  evSectionPara
  ;

// start class TnevSectionBreakList

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