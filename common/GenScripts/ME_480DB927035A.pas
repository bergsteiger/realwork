unit evStyleInterface;

interface

uses
 l3IntfUses
 , evStyles_SH
 , l3Interfaces
 , evFontInterface
 , l3Variant
 , Classes
 , k2Base
 , evdStyles
 , k2Dictionary
 , l3Types
 , l3Tree_TLB
 , nevBase
 , k2Tags
;

type
 RevStyleInterface = class of TevStyleInterface;
 
 Tk2TagID = k2Tags.Tk2TagID;
 
 TevStyleInterface = class(SHevStyles, Il3Strings)
  {* Инструмент для работы с таблицей стилей }
  function MakeList(aType: Tk2Type): Il3Strings;
  procedure Make(aType: Tk2Type;
   aStyle: Integer);
  function MakeListForBlock(aType: Tk2Type): Il3Strings;
  function GetVT: Tk2Dictionary;
   {* возвращает список стилей }
  procedure Add(const S: AnsiString;
   ID: Integer);
   {* добавляет новый стиль и устанавливает курсор на него }
  procedure Delete;
   {* удаляет текущий выбранный стиль }
  procedure SelectStyledObjectType(aType: Tk2Type);
   {* настраивает инструмент на работу со стилями для заданного типа объектов }
  procedure SelectStyledObject(anObject: Tl3Variant);
   {* настраивает инструмент на работу со стилями для заданного типа объектов }
  function SelectStyle(const S: AnsiString): Tl3Variant; overload;
   {* устанавливает курсор на стиль по имени }
  function SelectStyle(ID: Integer): Tl3Variant; overload;
   {* устанавливает курсор на стиль по идентификатору }
  procedure IncFontSize;
  procedure DecFontSize;
  procedure IncAllFontSize;
  procedure DecAllFontSize;
  function Iterate(Action: Tl3IteratorAction): Integer;
   {* перебирает все элементы хранилища с aLo по aHi и освобождает заглушку для Action }
  function IterateF(Action: Tl3IteratorAction): Integer;
   {* перебирает все элементы хранилища с aLo по aHi и освобождает заглушку для Action }
  function MakeStylesTreeRoot(const aIncludeIdArray: array of Integer): Il3Node;
   {* создает дерево стилей и возвращает интерфейс на корневую ноду }
  function Items: TStrings;
   {* строки. }
 end;//TevStyleInterface
 
implementation

uses
 l3ImplUses
 , l3Base
 , TextPara_Const
 , l3Nodes
 , l3TreeInterfaces
 , k2SimpleTagList
 , l3Chars
 , evStyleTableSpy
;

end.
