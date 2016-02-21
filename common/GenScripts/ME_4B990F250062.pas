unit ddAppConfigRes;
 {* ������� ��� ddAppConfig }

// ������: "w:\common\components\rtl\Garant\dd\ddAppConfigRes.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_ddmmSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddmmSettingsCaption'; rValue : '��������� ������������');
  {* '��������� ������������' }
 str_ddmmErrorCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddmmErrorCaption'; rValue : '������');
  {* '������' }
 {* ������������ ������ Errors }
 str_DifferentType: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DifferentType'; rValue : '��� �������� "%s" ���������� �� ������������');
  {* '��� �������� "%s" ���������� �� ������������' }
 str_PropertyAbsent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PropertyAbsent'; rValue : '�������� "%s" �����������');
  {* '�������� "%s" �����������' }
 str_PropertyExists: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PropertyExists'; rValue : '�������� � ������ "%s" ��� ����������');
  {* '�������� � ������ "%s" ��� ����������' }
 str_ListEmpty: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEmpty'; rValue : '������������ �����');
  {* '������������ �����' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_ddmmSettingsCaption.Init;
 {* ������������� str_ddmmSettingsCaption }
 str_ddmmErrorCaption.Init;
 {* ������������� str_ddmmErrorCaption }
 str_DifferentType.Init;
 {* ������������� str_DifferentType }
 str_PropertyAbsent.Init;
 {* ������������� str_PropertyAbsent }
 str_PropertyExists.Init;
 {* ������������� str_PropertyExists }
 str_ListEmpty.Init;
 {* ������������� str_ListEmpty }

end.
