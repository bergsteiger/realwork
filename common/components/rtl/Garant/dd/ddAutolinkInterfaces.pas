unit ddAutolinkInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddAutolinkInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::dd::ddAutolinkInterfaces
//
// Интерфейсы для автопростановщика ссылок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3Interfaces,
  dt_Types,
  l3LongintList,
  l3Date,
  ddBaseAutoLinkDataSource
  ;

type
 IddAutolinkDocEntry = interface(IUnknown)
   ['{144A5C82-8AF4-4C42-B3F5-CC3128C343EB}']
   procedure AddSource(aSource: Integer);
   procedure DelSource(anIndex: Integer);
   procedure Clear;
     {* очищает все данные }
   function IsEmpty: Boolean;
     {* Если нет никаких данных... }
   function IsSame(const anEntry: IddAutolinkDocEntry): Boolean;
   function SourcesIdenticalTo(const anEntry: IddAutolinkDocEntry): Boolean;
   function Clone: IddAutolinkDocEntry;
   function Get_Sources(anIndex: Integer): Integer;
   function Get_DocType: Integer;
   procedure Set_DocType(aValue: Integer);
   function Get_Num: Il3CString;
   procedure Set_Num(const aValue: Il3CString);
   function Get_Date: TStDate;
   procedure Set_Date(aValue: TStDate);
   function Get_SourceCount: Integer;
   function Get_DocID: TddALDocRec;
   procedure Set_DocID(const aValue: TddALDocRec);
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

 IddAutolinkArbitraryDocEntry = interface(IUnknown)
   ['{F1638796-C90F-4314-A281-5BD53E75C0B6}']
   function Get_DocID: TDocID;
   function Get_TypesList: Tl3LongintList;
   property DocID: TDocID
     read Get_DocID;
   property TypesList: Tl3LongintList
     read Get_TypesList;
 end;//IddAutolinkArbitraryDocEntry

implementation

end.