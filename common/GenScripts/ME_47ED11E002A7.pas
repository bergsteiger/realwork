unit DocumentFactoryKeyHelper;
 {* ��������� ����� ������������� �� ���������� ��������� ��� PID }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DocumentFactoryKeyHelper.pas"
// ���������: "UtilityPack"
// ������� ������: "DocumentFactoryKeyHelper" MUID: (47ED11E002A7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DocumentUnit
;

function server_document_to_key(const document): TFactoryKey;
 {* �� ���������� ��������� }
function PID_to_key(const pid): TFactoryKey;
 {* �� PID'� }

implementation

uses
 l3ImplUses
 , ApplicationHelper
;

function server_document_to_key(const document): TFactoryKey;
 {* �� ���������� ��������� }
//#UC START# *47ED12200202_47ED11E002A7_var*
//#UC END# *47ED12200202_47ED11E002A7_var*
begin
//#UC START# *47ED12200202_47ED11E002A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47ED12200202_47ED11E002A7_impl*
end;//server_document_to_key

function PID_to_key(const pid): TFactoryKey;
 {* �� PID'� }
//#UC START# *47ED1269019D_47ED11E002A7_var*
//#UC END# *47ED1269019D_47ED11E002A7_var*
begin
//#UC START# *47ED1269019D_47ED11E002A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47ED1269019D_47ED11E002A7_impl*
end;//PID_to_key

end.
