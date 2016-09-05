unit dtFamilyInfo;

// ������: "w:\common\components\rtl\Garant\DT\dtFamilyInfo.pas"
// ���������: "SimpleClass"
// ������� ������: "TdtFamilyInfo" MUID: (537F78410340)

{$Include w:\common\components\rtl\Garant\DT\DtDefine.inc}

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
 //#UC START# *537F78410340impl_uses*
 //#UC END# *537F78410340impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
