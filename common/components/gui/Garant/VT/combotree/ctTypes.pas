unit ctTypes;

// $Id: ctTypes.pas,v 1.3 2008/07/04 15:43:50 lulin Exp $

// $Log: ctTypes.pas,v $
// Revision 1.3  2008/07/04 15:43:50  lulin
// - <K>: 99647706.
//
// Revision 1.2  2008/05/15 20:15:29  lulin
// - тотальная чистка.
//
// Revision 1.1  2007/12/07 16:59:52  lulin
// - переезд.
//
// Revision 1.1  2007/12/07 16:22:40  lulin
// - переименовываем файл, чтобы не путать с другой библиотекой.
//
// Revision 1.37  2007/09/07 12:27:31  lulin
// - cleanup.
//
// Revision 1.36  2007/04/23 10:42:29  oman
// - new: Вычищаем старую ППР и старые фильтры - Убрал Garant5Editor (cq25125)
// - Предыдущий комментарий бредов...
//
// Revision 1.35  2007/04/23 10:39:29  oman
// - fix: *Оказалось IQuery не всегда имеет имя - Убрал Garant5Editor (cq25139)
//
// Revision 1.34  2007/03/22 09:09:30  lulin
// - cleanup.
//
// Revision 1.33  2007/03/20 15:01:42  lulin
// - создавалось неправильное дерево, в итоге показывались паразитные иконки.
//
// Revision 1.32  2007/03/14 18:27:33  lulin
// - cleanup.
//
// Revision 1.31  2007/01/30 15:24:09  lulin
// - текст ноды - теперь более простого типа.
//
// Revision 1.30  2007/01/19 07:45:11  oman
// - new: Локализация библиотек - ct (cq24078)
//
// Revision 1.29  2006/12/22 15:06:27  lulin
// - текст ноды - теперь структура с длиной и кодовой страницей.
//
// Revision 1.28  2006/06/23 10:32:01  oman
// - fix: ReadOnly не эквивалентно DropDownList. Починка ReadOnly...
//
// Revision 1.27  2005/05/27 14:42:18  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.26  2004/12/30 14:34:58  am
// change: минимальная высота комбобокса
//
// Revision 1.25  2004/12/28 16:25:50  lulin
// - добавлены директивы CVS.
//

interface

const
  COMBO_MIN_SIZE_X = 40;
  COMBO_MIN_SIZE_Y = 70;
  COMBO_MAX_SIZE_Y = 120;

type
  TAutoWidthMode = ( awNone, awCurrent, awMax );
  TComboStyle = (ct_cbDropDown, ct_cbDropDownList, ct_cbEdit);
  TCurrentMode = set of ( cmButtonClick, cmSetText, cmNoFiltering, cmFocusing,
                          cmAppNotActive, cmTimer, cmAllVisible, cmEscapePressed,
                          cmKeyProhibited, cmWMSetText, cmClear, cmVcmExecute, cmSetCurrent);

  // cmButtonClick - идёт обработка кнопки, по нажатию которой выпадает список
  // cmSetText - внутри TFakeCombo.SetText
  // cmAllVisible - все итемы видимы (нет нужды делать setAllFlags/SetRoot с
  // последующим _Changed и сопутствующими тормозами)
  // cmWMSetText - caption был установлен через WMSetText (и следовательно, должен обновиться,
  // если из vcm придёт Current нода
  // cmVcmExecute - обработка vcmCurrent, etc..

const
 ReadOnlyComboStyles = [ct_cbDropDownList];

implementation

end.
