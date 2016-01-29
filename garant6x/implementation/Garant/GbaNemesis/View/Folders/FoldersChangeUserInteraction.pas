unit FoldersChangeUserInteraction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/FoldersChangeUserInteraction.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Основные прецеденты::Folders::View::Folders::TFoldersChangeUserInteraction
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
  FoldersDomainInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TFoldersChangeUserInteraction = class
 public
 // public methods
   class function AskAllowMerge: TnsListMergeKind;
   class procedure SayChildNodeDuplicated;
 end;//TFoldersChangeUserInteraction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsQuestionsWithChoices
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TFoldersChangeUserInteraction

class function TFoldersChangeUserInteraction.AskAllowMerge: TnsListMergeKind;
//#UC START# *51F65ADD01D0_51F65A1A03D3_var*
//#UC END# *51F65ADD01D0_51F65A1A03D3_var*
begin
//#UC START# *51F65ADD01D0_51F65A1A03D3_impl*
 Result := lmkDeny;
 case vcmMessageDlg(str_DropListToList, []) of
  -1:
   Result := lmkAllow;
  mrCancel:
   Result := lmkAbort;
 end;//case MessageDlg(str_DropListToList)

//#UC END# *51F65ADD01D0_51F65A1A03D3_impl*
end;//TFoldersChangeUserInteraction.AskAllowMerge

class procedure TFoldersChangeUserInteraction.SayChildNodeDuplicated;
//#UC START# *51F65B500160_51F65A1A03D3_var*
//#UC END# *51F65B500160_51F65A1A03D3_var*
begin
//#UC START# *51F65B500160_51F65A1A03D3_impl*
 vcmSay(err_DuplicateNameError);
//#UC END# *51F65B500160_51F65A1A03D3_impl*
end;//TFoldersChangeUserInteraction.SayChildNodeDuplicated

{$IfEnd} //not Admin AND not Monitorings

end.