unit Folders_Result_Controls;
 {* ��������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders_Result_Controls.pas"
// ���������: "VCMControls"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 // Result

 // None

 // NewFolder

 // Edit

 // Load

 // Select

 // FolderSave

 // Ok

 // Bookmark

 // List

 // Query

 // Append

 // ResultExt
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
