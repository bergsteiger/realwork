unit dtFamilyInfo;

// ������: "w:\common\components\rtl\Garant\DT\dtFamilyInfo.pas"
// ���������: "SimpleClass"

{$Include DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
;

type
 TdtFamilyInfo = class(Tl3ProtoObject)
  public
   Number: Integer;
   Name: AnsiString;
   Path: AnsiString;
   DocGroup: Integer;
   Attributes: Integer;
 end;//TdtFamilyInfo
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
