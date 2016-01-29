unit vcmGUI;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/vcmGUI.pas"
// Начат: 12.02.2009 17:12
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VCM::vcmGUI
//
// Интерфейсы представления
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  ,
  l3MessageID
  ;

type
 TvcmMessageID = record
   rM : Integer;
 end;//TvcmMessageID

 IvcmUserInteraction = interface(IvcmBase)
   ['{7F0D0E1A-63B7-4AC9-8382-341711A72F7C}']
   function MessageDlg(const aMsg: Tl3MessageID;
     const aData: array of const): Integer; overload; 
   function MessageDlg(const aMsg: Tl3MessageID): Integer; overload; 
   function MessageDlg(const aMsg: IvcmCString;
    const aKey: AnsiString;
    aDlgType: TMsgDlgType = mtCustom;
    aButtons: TMsgDlgButtons = [mbOK]): Integer; overload; 
   function MessageDlg(const aMsg: TvcmMessageID): Integer; overload; 
   procedure Say(const aMsg: TvcmMessageID); overload; 
   procedure Say(const aMsg: TvcmMessageID;
    const aData: array of const); overload; 
   function Ask(const aMsg: TvcmMessageID): Boolean; overload; 
   function Ask(const aMsg: TvcmMessageID;
    const aData: array of const): Boolean; overload; 
   function Ask(const aMsg: Tl3MessageID;
    const aData: array of const): Boolean; overload; 
 end;//IvcmUserInteraction

 PvcmMessageID = ^TvcmMessageID;
{$IfEnd} //not NoVCM

implementation

end.