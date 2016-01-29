unit Base_Operations_F1Specific_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Base_Operations_F1Specific_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Core::Base Operations::View::F1Specific
//
// Операции, специфичные для F1
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;

(* File = operations(File)
  {* Файл }
   ['{3041ED2E-9529-4DC4-A83B-0367A48DC97B}']
   operation ToMSWord;
     {* Экспорт в Word }
   operation SendMailAsAttachment;
     {* Послать по e-mail }
 end;//File*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_File = OfficeLike_Usual_Controls.en_File;
 en_capFile = OfficeLike_Usual_Controls.en_capFile;
 op_ToMSWord = 'ToMSWord';
 op_capToMSWord = 'Экспорт в Word';
 op_SendMailAsAttachment = 'SendMailAsAttachment';
 op_capSendMailAsAttachment = 'Послать по e-mail';
{$IfEnd} //not Admin AND not Monitorings

implementation

end.