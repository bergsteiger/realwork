unit evdTasks_Schema;
 {* ����� ��� ��������� ������� � ALCU. ����� � ���� ����� �������� �������� }

// ������: "w:\common\components\rtl\Garant\EVD\evdTasks_Schema.pas"
// ���������: "TagTable"
// ������� ������: "evdTasks" MUID: (537DFE740339)
// ��� ����: "TevdTasksSchema"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , k2Native_Schema
;

type
 // TevdTasksSchema

implementation

uses
 l3ImplUses
 , ddTaskItemPrim
;

initialization
 TevdTasksSchema.SetAsDefault;

end.
