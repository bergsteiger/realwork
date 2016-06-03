unit l3FilerRes;

// ������: "w:\common\components\rtl\Garant\L3\l3FilerRes.pas"
// ���������: "UtilityPack"
// ������� ������: "l3FilerRes" MUID: (4BA206A400AC)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

{$If NOT Defined(Nemesis)}
const
 {* ������������ ������ Local }
 str_l3mmFileOp: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOp'; rValue : '�������� ��������');
  {* '�������� ��������' }
 str_l3mmFileOpFmt: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOpFmt'; rValue : '�������� �������� [%s]');
  {* '�������� �������� [%s]' }
{$IfEnd} // NOT Defined(Nemesis)
{$If Defined(Nemesis)}
const
 {* ������������ ������ LocalNemesis }
 str_l3mmFileOp: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOp'; rValue : '�������� ���������');
  {* '�������� ���������' }
 str_l3mmFileOpFmt: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOpFmt'; rValue : '�������� ��������� [%s]');
  {* '�������� ��������� [%s]' }
{$IfEnd} // Defined(Nemesis)

implementation

uses
 l3ImplUses
;

initialization
{$If NOT Defined(Nemesis)}
 str_l3mmFileOp.Init;
 {* ������������� str_l3mmFileOp }
{$IfEnd} // NOT Defined(Nemesis)
{$If NOT Defined(Nemesis)}
 str_l3mmFileOpFmt.Init;
 {* ������������� str_l3mmFileOpFmt }
{$IfEnd} // NOT Defined(Nemesis)
{$If Defined(Nemesis)}
 str_l3mmFileOp.Init;
 {* ������������� str_l3mmFileOp }
{$IfEnd} // Defined(Nemesis)
{$If Defined(Nemesis)}
 str_l3mmFileOpFmt.Init;
 {* ������������� str_l3mmFileOpFmt }
{$IfEnd} // Defined(Nemesis)

end.
