unit evCursorConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evCursorConst.pas"
// Начат: 18.12.2002 17:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Cursors::evCursorConst
//
// Константы для работы с курсором
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
const
  { Cursor Positions }
 ev_cpTop = -1;
 ev_cpBottom = -2;
 ev_cpNull = -3;
 ev_cpAtEnd = High(Integer);
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
{$IfEnd} //evUseVisibleCursors
end.