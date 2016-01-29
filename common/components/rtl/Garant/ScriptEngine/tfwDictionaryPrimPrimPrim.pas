unit tfwDictionaryPrimPrimPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// ������: "tfwDictionaryPrimPrimPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::Dictionary::TtfwDictionaryPrimPrimPrim
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3ProtoDataContainer,
  l3Variant,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
 {$Undef l3Items_NeedsBeforeFreeItem}

 {$Undef l3Items_NoSort}

 {$Undef l3Items_CaseUnsensitive}

type
 _l3StringList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3StringList.imp.pas}
 TtfwDictionaryPrimPrimPrim = {abstract} class(_l3StringList_)
 end;//TtfwDictionaryPrimPrimPrim
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3String,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

type _Instance_R_ = TtfwDictionaryPrimPrimPrim;

{$Include w:\common\components\rtl\Garant\L3\l3StringList.imp.pas}


{$IfEnd} //not NoScripts
end.