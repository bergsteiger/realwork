unit msmModelElements;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElements.pas"
// Стереотип: "Interfaces"
// Элемент модели: "msmModelElements" MUID: (57A9F4A003C8)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3TreeInterfaces
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , msmUsualData
;

type
 ImsmBaseModelElement = interface
  ['{B406D099-30A8-4FA1-A23B-9A3C2CECACF3}']
  function Get_Name: Il3CString;
  function Get_UID: Il3CString;
  property Name: Il3CString
   read Get_Name;
  property UID: Il3CString
   read Get_UID;
 end;//ImsmBaseModelElement

 ImsmModelElementList = interface;

 ImsmModelElement = interface(ImsmBaseModelElement)
  ['{AD86B8AA-A81D-4203-AB9F-3851052AB311}']
  function Get_Parent: ImsmModelElement;
  function Get_Children: ImsmModelElementList;
  function Get_List(const aName: AnsiString): ImsmModelElementList;
  function Get_StringProp(const aName: AnsiString): Il3CString;
  function Get_IntProp(const aName: AnsiString): Integer;
  procedure Set_IntProp(const aName: AnsiString;
   aValue: Integer);
  function Get_BoolProp(const aName: AnsiString): Boolean;
  function Get_ElementProp(const aName: AnsiString): ImsmModelElement;
  function Get_MainWord: TtfwWord;
  function IsView: Boolean;
  function IsSameElement(const anOther: ImsmModelElement): Boolean;
  property Parent: ImsmModelElement
   read Get_Parent;
  property Children: ImsmModelElementList
   read Get_Children;
  property List[const aName: AnsiString]: ImsmModelElementList
   read Get_List;
  property StringProp[const aName: AnsiString]: Il3CString
   read Get_StringProp;
  property IntProp[const aName: AnsiString]: Integer
   read Get_IntProp
   write Set_IntProp;
  property BoolProp[const aName: AnsiString]: Boolean
   read Get_BoolProp;
  property ElementProp[const aName: AnsiString]: ImsmModelElement
   read Get_ElementProp;
  property MainWord: TtfwWord
   read Get_MainWord;
 end;//ImsmModelElement

 (*
 MmsmModelElementList = interface(MmsmCountHolder)
  function Get_Item(anIndex: Integer): ImsmModelElement;
  function Get_Owner: ImsmModelElement;
  function IndexOf(const anElement: ImsmModelElement): Integer;
  property Item[anIndex: Integer]: ImsmModelElement
   read Get_Item;
   default;
  property Owner: ImsmModelElement
   read Get_Owner;
 end;//MmsmModelElementList
 *)

 ImsmModelElementList = interface
  ['{BE9CA7E6-F043-4A30-88C6-631F86D4747F}']
  function Get_Item(anIndex: Integer): ImsmModelElement;
  function Get_Owner: ImsmModelElement;
  function Get_Count: Integer;
  function IndexOf(const anElement: ImsmModelElement): Integer;
  property Item[anIndex: Integer]: ImsmModelElement
   read Get_Item;
   default;
  property Owner: ImsmModelElement
   read Get_Owner;
  property Count: Integer
   read Get_Count;
 end;//ImsmModelElementList

implementation

uses
 l3ImplUses
;

end.
