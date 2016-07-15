unit Diction_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4C850F97017C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_Lang = 'Lang';
 en_capLang = '';
 op_Russian = 'Russian';
 op_capRussian = '';
 op_English = 'English';
 op_capEnglish = '';
 op_French = 'French';
 op_capFrench = '';
 op_Deutch = 'Deutch';
 op_capDeutch = '';
 op_Italian = 'Italian';
 op_capItalian = '';
 op_Spanish = 'Spanish';
 op_capSpanish = '';

var opcode_Lang_Russian: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Lang_English: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Lang_French: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Lang_Deutch: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Lang_Italian: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Lang_Spanish: TvcmOPID = (rEnID : -1; rOpID : -1);
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
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Lang, op_Russian, en_capLang, op_capRussian, False, False, opcode_Lang_Russian)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Lang, op_English, en_capLang, op_capEnglish, False, False, opcode_Lang_English)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Lang, op_French, en_capLang, op_capFrench, False, False, opcode_Lang_French)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Lang, op_Deutch, en_capLang, op_capDeutch, False, False, opcode_Lang_Deutch)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Lang, op_Italian, en_capLang, op_capItalian, False, False, opcode_Lang_Italian)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Lang, op_Spanish, en_capLang, op_capSpanish, False, False, opcode_Lang_Spanish)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
