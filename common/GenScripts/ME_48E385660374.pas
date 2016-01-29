unit evRange;

interface

uses
 l3IntfUses
 , k2ProcTagTool
 , evEditorInterfaces
 , nevTools
 , nevBase
 , nevNavigation
 , l3Interfaces
 , Windows
;

type
 TedRangeImplementation = class(Tk2ProcTagTool, IedRange)
  {* Реализация интерфейса IedRange }
  procedure Create(const aView: InevView;
   const aLoc: InevLocation;
   const aProcessor: InevProcessor;
   const aTextParagraph: IedTextParagraph);
  function Make(const aView: InevView;
   const aLoc: InevLocation;
   const aProcessor: InevProcessor;
   const aTextParagraph: IedTextParagraph): IedRange;
  function Collapse: Boolean;
  procedure Iterate;
   {* Итератор по листьевым параграфам }
  function Paragraph: IedParagraph;
   {* получает абстрактный параграф в диапазоне, если он в него входит }
  function Table: IedTable;
   {* получает таблицу в диапазоне, если она в него входит }
  function Hyperlink: IevHyperlink;
   {* получает гиперссылку в диапазоне, если она в него входит }
  function Collapsed: Boolean;
   {* выделение или точка }
  function TextParagraph: IedTextParagraph;
   {* "текстовый" параграф в выделении }
  function Part: IedRange;
   {* часть выделения }
  function Document: IevDocument;
   {* документ }
  function ContainsOneLeaf: Boolean;
   {* проверяет содержит ли диапазон только один листьевой параграф }
  function AsString(aFormat: Tl3ClipboardFormat): AnsiString;
   {* получает текст в диапазоне }
  function Delete(aMode: TevClearMode): Boolean;
   {* удаляет содержимое диапазона }
  function InsertData(aFormat: Tl3ClipboardFormat;
   aData: THandle;
   aNeedClearOld: Boolean): Boolean;
   {* вставить данные из памяти в формате aFormat }
  procedure InsertFrom(const aTextSource: InevTagReader;
   const aFilters: InevTagGenerator);
   {* вставить данные из другого источника текста }
  function InsertString(const aSt: Tl3PCharLenPrim;
   aFormat: Tl3ClipboardFormat): Boolean; overload;
   {* вставить строку aSt в текущую позицию курсора.
         |* Пример использования метода InsertString.
          !begin
          ! CurrentEditor.Range.InsertString(l3PCharLen('Hello world!', -1, CP_ANSI));
          ! // - в текущую позицию курсора вставляется строка 'Hello word!' в кодировке CP_ANSI.
          !end;
         |* }
  function InsertString(const aSt: AnsiString;
   aFormat: Tl3ClipboardFormat): Boolean; overload;
   {* вставить строку aSt в текущую позицию курсора.
         |* Пример использования метода InsertString.
          !begin
          ! CurrentEditor.Range.InsertString('Hello world!');
          ! // - в текущую позицию курсора вставляется строка 'Hello word!' в кодировке CP_ANSI.
          !end;
         |* }
  function InsertParaBreak: Boolean;
   {* вставляет разрыв параграфов }
  function DeleteChar: Boolean;
   {* удаляет текущий символ }
  function Save(aFormat: Tl3ClipboardFormat;
   const outPool: IStream;
   const aFilters: InevTagGenerator;
   anInternal: Boolean;
   ChildrenOnly: Boolean): Boolean;
   {* сохранить выделение }
 end;//TedRangeImplementation
 
 TedRange = class(TedRangeImplementation)
  {* Реализация интерфейса IedRange. Для конечного использования }
 end;//TedRange
 
implementation

uses
 l3ImplUses
 , ParaList_Const
 , Table_Const
 , SysUtils
 , evParaUtilClasses
 , l3Memory
 , l3Base
 , evTypes
 , nevFacade
 , evOp
 , evEditorInterfacesMisc
 , Messages
 , evBitmapReader
 , evExcept
 , l3String
 , l3Chars
 , evMsgCode
 , evdInterfaces
 , evUsialParagraph
;

end.
