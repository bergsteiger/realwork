unit Base_Operations_F1Specific_Controls;
 {* Операции, специфичные для F1 }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_F1Specific_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "F1Specific" MUID: (495237D80268)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_File = OfficeLike_Usual_Controls.en_File;
 en_capFile = OfficeLike_Usual_Controls.en_capFile;
 op_ToMSWord = 'ToMSWord';
 op_capToMSWord = 'Экспорт в Word';
 op_SendMailAsAttachment = 'SendMailAsAttachment';
 op_capSendMailAsAttachment = 'Послать по e-mail';

var opcode_File_ToMSWord: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_File_SendMailAsAttachment: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_File, op_ToMSWord, en_capFile, op_capToMSWord, False, False, opcode_File_ToMSWord)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_File, op_SendMailAsAttachment, en_capFile, op_capSendMailAsAttachment, False, True, opcode_File_SendMailAsAttachment)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
