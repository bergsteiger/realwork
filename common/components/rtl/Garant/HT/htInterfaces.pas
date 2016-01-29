unit htInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "HT"
// Модуль: "w:/common/components/rtl/Garant/HT/htInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi For Archi::HT::htInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\HT\htDefineDA.inc}

interface

uses
  daTypes,
  daInterfaces,
  l3Date
  {$If not defined(Nemesis)}
  ,
  HT_Const
  {$IfEnd} //not Nemesis
  
  ;

type
 IhtParamsStorage = interface(IdaParamsStorage)
   ['{68C7AC1A-2794-4F3B-92C2-EF264ED70759}']
   function Get_StationName: AnsiString;
   function Get_TablePath: AnsiString;
   procedure Set_TablePath(const aValue: AnsiString);
   function Get_LockPath: AnsiString;
   procedure Set_LockPath(const aValue: AnsiString);
   function Get_TempPath: AnsiString;
   procedure Set_TempPath(const aValue: AnsiString);
   function StationErrorMessage: AnsiString;
   function TablePathErrorMessage: AnsiString;
   function LockPathErrorMessage: AnsiString;
   property StationName: AnsiString
     read Get_StationName;
   property TablePath: AnsiString
     read Get_TablePath
     write Set_TablePath;
   property LockPath: AnsiString
     read Get_LockPath
     write Set_LockPath;
   property TempPath: AnsiString
     read Get_TempPath
     write Set_TempPath;
 end;//IhtParamsStorage

 IhtDataSchemeHelper = interface(IUnknown)
   ['{49B4A6A6-2FE1-4E28-BCD6-101B2639CC07}']
   function TableFullPath(aTable: TdaTables): AnsiString;
   function TablePassword(aTable: TdaTables): AnsiString;
   function TableFamily(aTable: TdaTables): TdaFamilyID;
 end;//IhtDataSchemeHelper

 IhtFromTable = interface(IdaFromTable)
   ['{07913015-B7DB-4C2B-8827-93BD8A6F6F24}']
   function Get_Handle: ThtTblHandle;
   procedure Prepare(const aHelper: IhtDataSchemeHelper;
    RequireNewHandle: Boolean);
   procedure Unprepare(const aHelper: IhtDataSchemeHelper);
   property Handle: ThtTblHandle
     read Get_Handle;
 end;//IhtFromTable

 IhtDataConverter = interface(IdaDataConverter)
   ['{B9607AE1-26FC-417B-810D-A1FE75CC6A45}']
   function ToLargeInt(aData: Pointer;
    const aDesc: OPEL): LargeInt;
   function ToInteger(aData: Pointer;
    const aDesc: OPEL): Integer;
   function ToStDate(aData: Pointer;
    const aDesc: OPEL): TStDate;
   function ToStTime(aData: Pointer;
    const aDesc: OPEL): TStTime;
   function ToString(aData: Pointer;
    const aDesc: OPEL): AnsiString;
   function ToByte(aData: Pointer;
    const aDesc: OPEL): Byte;
 end;//IhtDataConverter

 ThtSubItemDescriptionArray = array of OPEL;

implementation

end.