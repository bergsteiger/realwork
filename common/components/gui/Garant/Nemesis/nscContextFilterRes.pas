unit nscContextFilterRes;
 {* ������� ��� TnscContextFilter }

// ������: "w:\common\components\gui\Garant\Nemesis\nscContextFilterRes.pas"
// ���������: "UtilityPack"
// ������� ������: "nscContextFilterRes" MUID: (4B97E1EA011F)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ ContextFilterMessages }
 str_nsc_LabelCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_LabelCaption'; rValue : '����������� ������');
  {* '����������� ������' }
 str_nsc_ContextEmptyMessage: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_ContextEmptyMessage'; rValue : '������� ����� ��� ������ � ����������');
  {* '������� ����� ��� ������ � ����������' }
 str_nsc_ButtonActiveHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_ButtonActiveHint'; rValue : '��������� ����������� ������');
  {* '��������� ����������� ������' }
 str_nsc_ButtonInActiveHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_ButtonInActiveHint'; rValue : '�������� ����������� ������');
  {* '�������� ����������� ������' }
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *4B97E1EA011Fimpl_uses*
 //#UC END# *4B97E1EA011Fimpl_uses*
;

initialization
 str_nsc_LabelCaption.Init;
 {* ������������� str_nsc_LabelCaption }
 str_nsc_ContextEmptyMessage.Init;
 {* ������������� str_nsc_ContextEmptyMessage }
 str_nsc_ButtonActiveHint.Init;
 {* ������������� str_nsc_ButtonActiveHint }
 str_nsc_ButtonInActiveHint.Init;
 {* ������������� str_nsc_ButtonInActiveHint }
{$IfEnd} // Defined(Nemesis)

end.
