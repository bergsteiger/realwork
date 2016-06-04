unit Hypertext_Controls_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\Hypertext_Controls_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Controls" MUID: (4CDD18640278)

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
 en_capFile = 'Файл';
 op_MakeHyperlinkToDocument = 'MakeHyperlinkToDocument';
 op_capMakeHyperlinkToDocument = 'Создать ссылку на документ';
 en_Text = 'Text';
 en_capText = 'Текст';
 en_Document = 'Document';
 en_capDocument = 'Документ';

implementation

uses
 l3ImplUses
;

end.
