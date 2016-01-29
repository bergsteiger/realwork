unit k2Strings;

{ Библиотека "K-2"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: k2Strings -     }
{ Начат: 11.04.2006 20:13 }
{ $Id: k2Strings.pas,v 1.3 2006/04/18 07:45:23 lulin Exp $ }

// $Log: k2Strings.pas,v $
// Revision 1.3  2006/04/18 07:45:23  lulin
// - cleanup.
//
// Revision 1.2  2006/04/11 17:55:28  lulin
// - оптимизируем при помощи вынесения строк (по следам того как Вован наиграл в фильтрах 20% производительности).
//
// Revision 1.1  2006/04/11 16:35:37  lulin
// - оптимизируем при помощи вынесения строк (по следам того как Вован наиграл в фильтрах 20% производительности).
//

{$Include k2Define.inc }

interface

resourcestring
 k2_errInterfaceNotImplemented = 'Interface %d for %s is not implemented';
 k2_errReadOnly = 'Нельзя присвоить значение ReadOnly свойству %s для %s.';
 k2_errNoChildren = 'Tag %s hasn''t children (%s)';
 k2_errBadChild = 'For %s child type %s incompartible with %s';
 k2_errConvertError = 'Cannot convert %s to %s';
 k2_errAbstractMethod = 'Abstract method ''%s'' call';
 k2_errPropExists = 'Atom #%d for %s is already defined and named %s';
 k2_errCannotInheriteType = 'Cannot inherite type %s from %s';
 k2_errTypeAlreadyDefined = 'Type %s already defined';
 k2_strNil = 'nil';
 k2_errDocumentHeaderMissing = 'Поток не открыт. Возможно отсутствует заголовок документа.';
 k2_errInvalidType = 'Недопустимый тип.';
 k2_errBadSkipLevel = 'Лишнее закрытие режима фильтрации тегов (несбалансированные вызовы IncSkipTags/DecSkipTags)';
 k2_errBadFinishCall = 'Вызовов Finish больше чем вызовов Start';
 k2_errParamNotDefined = 'Param %s for %s is not defined';
 k2_errBracketsNotClosed = 'Не закрыто %d скобок в %s';

implementation

end.

