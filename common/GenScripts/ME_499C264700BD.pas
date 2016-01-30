unit nsDocumentsList_p;
 {* Обёртка для работы со списком документов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\nsDocumentsList_p.pas"
// Стереотип: "TestClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscTreeView
 {$IfEnd} // Defined(Nemesis)
 , l3TreeInterfaces
;

type
 // TnsDocumentsList
{$IfEnd} // NOT Defined(XE)

implementation

{$If NOT Defined(XE)}
uses
 l3ImplUses
 , TestDocListUtils
 , DynamicDocListUnit
 , DocumentUnit
 , MessageOnDesktop
 , TestStringUtils
 , SysUtils
 , Classes
 , Windows
;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE)

end.
