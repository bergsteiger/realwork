unit Hypertext_Controls_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\Hypertext_Controls_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Controls" MUID: (4CDD18640278)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_File = 'File';
 en_capFile = '����';
 op_MakeHyperlinkToDocument = 'MakeHyperlinkToDocument';
 op_capMakeHyperlinkToDocument = '������� ������ �� ��������';
 en_Text = 'Text';
 en_capText = '�����';
 en_Document = 'Document';
 en_capDocument = '��������';

implementation

uses
 l3ImplUses
;

end.
