unit ddAutolinkInterfaces;
 {* Интерфейсы для автопростановщика ссылок }

// Модуль: "w:\common\components\rtl\Garant\dd\ddAutolinkInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "ddAutolinkInterfaces" MUID: (4E8EAF5C020F)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Date
 , ddBaseAutoLinkDataSource
 , dt_Types
 , l3LongintList
;

type
 IddAutolinkDocEntry = interface
  ['{144A5C82-8AF4-4C42-B3F5-CC3128C343EB}']
  function Get_Sources(anIndex: Integer): Integer;
  function Get_DocType: Integer;
  procedure Set_DocType(aValue: Integer);
  function Get_Num: Il3CString;
  procedure Set_Num(const aValue: Il3CString);
  function Get_Date: TStDate;
  procedure Set_Date(const aValue: TStDate);
  function Get_SourceCount: Integer;
  function Get_DocID: TddALDocRec;
  procedure Set_DocID(const aValue: TddALDocRec);
  procedure AddSource(aSource: Integer);
  procedure DelSource(anIndex: Integer);
  procedure Clear;
   {* очищает все данные }
  function IsEmpty: Boolean;
   {* Если нет никаких данных... }
  function IsSame(const anEntry: IddAutolinkDocEntry): Boolean;
  function SourcesIdenticalTo(const anEntry: IddAutolinkDocEntry): Boolean;
  function Clone: IddAutolinkDocEntry;
  property Sources[anIndex: Integer]: Integer
   read Get_Sources;
  property DocType: Integer
   read Get_DocType
   write Set_DocType;
  property Num: Il3CString
   read Get_Num
   write Set_Num;
  property Date: TStDate
   read Get_Date
   write Set_Date;
  property SourceCount: Integer
   read Get_SourceCount;
  property DocID: TddALDocRec
   read Get_DocID
   write Set_DocID;
 end;//IddAutolinkDocEntry

 IddAutolinkArbitraryDocEntry = interface
  ['{F1638796-C90F-4314-A281-5BD53E75C0B6}']
  function Get_DocID: TDocID;
  function Get_TypesList: Tl3LongintList;
  property DocID: TDocID
   read Get_DocID;
  property TypesList: Tl3LongintList
   read Get_TypesList;
 end;//IddAutolinkArbitraryDocEntry

implementation

uses
 l3ImplUses
;

end.
