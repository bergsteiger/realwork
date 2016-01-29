unit NOT_FINISHED_nevTable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/new/NOT_FINISHED_nevTable.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevTable
//
// Класс для параграфов таблиц.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevParaList,
  nevTools
  ;

type
 TnevTable = class(TnevParaList)
  {* Класс для параграфов таблиц. }
 protected
 // overridden protected methods
   function GetSubRange(const aView: InevView;
    aStart: Integer;
    aFinish: Integer): InevRange; override;
     {* возвращает выделение на данном объекте от aStart до aFinish. }
 end;//TnevTable

implementation

// start class TnevTable

function TnevTable.GetSubRange(const aView: InevView;
  aStart: Integer;
  aFinish: Integer): InevRange;
//#UC START# *4C3B19AC01F3_4C3B1A050103_var*
//#UC END# *4C3B19AC01F3_4C3B1A050103_var*
begin
//#UC START# *4C3B19AC01F3_4C3B1A050103_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B19AC01F3_4C3B1A050103_impl*
end;//TnevTable.GetSubRange

end.