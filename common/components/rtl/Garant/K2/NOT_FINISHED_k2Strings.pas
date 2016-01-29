unit NOT_FINISHED_k2Strings;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/NOT_FINISHED_k2Strings.pas"
// Начат: 11.04.2006 20:13
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::K2::k2Strings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\K2\k2Define.inc}

interface

const
  { Exception Messages }
 k2_errInterfaceNotImplemented = 'Interface %d for %s is not implemented';
 k2_errReadOnly = 'Нельзя присвоить значение ReadOnly свойству %s для %s.';
 k2_errNoChildren = 'Tag %s hasn''t children (%s)';
 k2_errBadChild = 'For %s child type %s incompartible with %s';
 k2_errConvertError = 'Cannot convert %s to %s';
 k2_errAbstractMethod = 'Abstract method ''%s'' call';
 k2_errPropExists = 'Atom #%d for %s is already defined and named %s';
 k2_errCannotInheriteType = 'Cannot inherite type %s from %s';
 k2_errTypeAlreadyDefined = 'Type %s already defined';
 k2_errDocumentHeaderMissing = 'Поток не открыт. Возможно отсутствует заголовок документа.';
 k2_errInvalidType = 'Недопустимый тип.';
 k2_errBadSkipLevel = 'Лишнее закрытие режима фильтрации тегов (несбалансированные вызовы IncSkipTags/DecSkipTags)';
 k2_errBadFinishCall = 'Вызовов Finish больше чем вызовов Start';
 k2_errParamNotDefined = 'Param %s for %s is not defined';
 k2_errBracketsNotClosed = 'Не закрыто %d скобок в %s';

implementation

end.