unit afwCustomCaretType_p;

// ������: "w:\common\components\gui\Garant\Everest\afwCustomCaretType_p.pas"
// ���������: "TestClass"

{$Include l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , afwCustomCaretType
;

type
 // TafwCustomCaretType
{$IfEnd} // NOT Defined(XE)

implementation

{$If NOT Defined(XE)}
uses
 l3ImplUses
;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE)

end.
