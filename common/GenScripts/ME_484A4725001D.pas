unit evdNative_Schema;
 {* ���������� ����� ��������� EVD }

// ������: "w:\common\components\rtl\Garant\EVD\evdNative_Schema.pas"
// ���������: "TagTable"

{$Include evdDefine.inc}

interface

uses
 l3IntfUses
 , evdTasks_Schema
;

type
 // TevdNativeSchema

implementation

uses
 l3ImplUses
 , evdNative_AttrValues
;

initialization
 TevdNativeSchema.SetAsDefault;

end.
