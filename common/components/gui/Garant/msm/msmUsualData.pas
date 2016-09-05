unit msmUsualData;

// Модуль: "w:\common\components\gui\Garant\msm\msmUsualData.pas"
// Стереотип: "Interfaces"
// Элемент модели: "msmUsualData" MUID: (57B6AC48035C)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3TreeInterfaces
;

type
 ImsmTree = Il3SimpleTree;

 (*
 MmsmCountHolder = interface
  function Get_Count: Integer;
  property Count: Integer
   read Get_Count;
 end;//MmsmCountHolder
 *)

 (*
 MmsmStringList = interface(MmsmCountHolder)
  function Get_Strings(anIndex: Integer): Il3CString;
  function Get_StringsToFind(anIndex: Integer): Il3CString;
  property Strings[anIndex: Integer]: Il3CString
   read Get_Strings;
  property StringsToFind[anIndex: Integer]: Il3CString
   read Get_StringsToFind;
 end;//MmsmStringList
 *)

implementation

uses
 l3ImplUses
;

end.
