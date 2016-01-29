unit PrimeInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/PrimeInterfaces.pas"
// Начат: 09.02.2009 16:41
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Core::Common::Common$Lib::PrimeInterfaces
//
// Интерфейсы для ПРАЙМа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  l3Interfaces,
  afwInterfaces,
  l3TreeInterfaces,
  PrimeUnit
  ;

type
 InsNewsLineNotifier = interface(IUnknown)
   ['{B884CC7A-B18D-411B-A6AB-FC6A9AAA665D}']
   procedure DataChanged;
 end;//InsNewsLineNotifier

 InsNewsLine = interface(IUnknown)
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
{$IfEnd} //not Admin AND not Monitorings

implementation

end.