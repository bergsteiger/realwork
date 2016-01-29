unit evCommentDecorator;

interface

uses
 l3IntfUses
 , evCommentParaDecorator
 , l3Variant
;

type
 TevWhatOpen = (
  ev_wnoNone
  , ev_wnoRow
  , ev_wnoTable
 );//TevWhatOpen
 
 TevPrevClosed = (
  ev_pcNone
  , ev_pcTable
  , ev_pcAACTable
 );//TevPrevClosed
 
 TevCommentDecorator = class(TevCommentParaDecorator)
  {* Поддержка экспорта стилей для ААК. }
  procedure StartAACTable;
   {* Начало таблицы-обертки. }
  procedure AddHeaderRow;
   {* Строка табилцы с картинкой. }
  procedure AddSpaceRow;
   {* Добавляем отступ перед стилем. }
  procedure StartAACRow;
  procedure StartAACRow4Table;
   {* Начинаем строку для талицы (нет правого отступа) }
  procedure StartAACStyle;
   {* Начинает таблицу и предварительные строки. }
  procedure EndRow;
   {* Закрываем строку оберточной таблицы. }
  procedure EndRowAndTable;
   {* Закрывает строку и таблицу. }
  procedure CheckWhatOpen(aForTable: Boolean);
   {* Открытие обертночной таблицы или строки таблицы с проверкой, что уже было открыто. }
 end;//TevCommentDecorator
 
implementation

uses
 l3ImplUses
 , SysUtils
 , evDef
 , evdFrame_Const
 , l3Memory
 , Block_Const
 , Document_Const
 , evdStylesRes
 , BitmapPara_Const
 , Table_Const
 , TextPara_Const
 , evParaTools
 , k2Tags
 , evdStyles
 , TableCell_Const
 , ContentsElement_Const
;

end.
