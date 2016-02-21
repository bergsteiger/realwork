unit PrimeInterfaces;
 {* Интерфейсы для ПРАЙМа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\PrimeInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , afwInterfaces
 , l3Interfaces
 , l3TreeInterfaces
 , DocumentUnit
;

type
 InsNewsLineNotifier = interface
  ['{B884CC7A-B18D-411B-A6AB-FC6A9AAA665D}']
  procedure DataChanged;
 end;//InsNewsLineNotifier

 InsNewsLine = interface
  ['{CC1FD4A4-1733-4EDB-B696-92B5E74A634D}']
  function pm_GetThemeList: IafwStrings;
  function pm_GetCurrentTheme: Il3CString;
  procedure pm_SetCurrentTheme(const aValue: Il3CString);
  procedure SaveThemeToSettings;
  procedure LoadThemeFromSettings;
  procedure Subscribe(const aNotifier: InsNewsLineNotifier);
  procedure UnSubscribe(const aNotifier: InsNewsLineNotifier);
  function MakeCurrentThemeTreeStruct: Il3SimpleTree;
   {* Создать TreeStruct для текущей ленты }
  function ExtractAutoreferat(const aNode: Il3SimpleNode): IDocument;
  property ThemeList: IafwStrings
   read pm_GetThemeList;
  property CurrentTheme: Il3CString
   read pm_GetCurrentTheme
   write pm_SetCurrentTheme;
 end;//InsNewsLine
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
