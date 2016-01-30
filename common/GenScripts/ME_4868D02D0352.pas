unit Design_Schema;
 {* ����� ��� ��������� ��� Design-time }

// ������: "w:\common\components\gui\Garant\Everest\Design_Schema.pas"
// ���������: "TagTable"

{$Include evDefine.inc}

interface

{$If Defined(DesignTimeLibrary)}
uses
 l3IntfUses
 , Everest_Schema
;

type
 // TDesignSchema
{$IfEnd} // Defined(DesignTimeLibrary)

implementation

{$If Defined(DesignTimeLibrary)}
uses
 l3ImplUses
 , Design_AttrValues
;

initialization
 TDesignSchema.SetAsDefault;
{$IfEnd} // Defined(DesignTimeLibrary)

end.
