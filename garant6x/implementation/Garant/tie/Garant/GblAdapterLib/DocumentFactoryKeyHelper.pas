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

function ServerDocumentToKey(const document): TFactoryKey; stdcall;
 {* �� ���������� ��������� }
function PIDToKey(const pid): TFactoryKey; stdcall;
 {* �� PID'� }

implementation

uses
 l3ImplUses
 , ApplicationHelper
 //#UC START# *47ED11E002A7impl_uses*
 //#UC END# *47ED11E002A7impl_uses*
;

function ServerDocumentToKey(const document): TFactoryKey;
 {* �� ���������� ��������� }
//#UC START# *47ED12200202_47ED11E002A7_var*
//#UC END# *47ED12200202_47ED11E002A7_var*
begin
//#UC START# *47ED12200202_47ED11E002A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47ED12200202_47ED11E002A7_impl*
end;//ServerDocumentToKey

function PIDToKey(const pid): TFactoryKey;
 {* �� PID'� }
//#UC START# *47ED1269019D_47ED11E002A7_var*
//#UC END# *47ED1269019D_47ED11E002A7_var*
begin
//#UC START# *47ED1269019D_47ED11E002A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47ED1269019D_47ED11E002A7_impl*
end;//PIDToKey

end.
