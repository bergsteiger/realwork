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

var opcode_File_MakeHyperlinkToDocument: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Text_MakeHyperlinkToDocument: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_MakeHyperlinkToDocument: TvcmOPID = (rEnID : -1; rOpID : -1);

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_File, op_MakeHyperlinkToDocument, en_capFile, op_capMakeHyperlinkToDocument, False, False, opcode_File_MakeHyperlinkToDocument)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Text, op_MakeHyperlinkToDocument, en_capText, op_capMakeHyperlinkToDocument, False, False, opcode_Text_MakeHyperlinkToDocument)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_MakeHyperlinkToDocument, en_capDocument, op_capMakeHyperlinkToDocument, False, False, opcode_Document_MakeHyperlinkToDocument)) do
 begin
 end;


end.
