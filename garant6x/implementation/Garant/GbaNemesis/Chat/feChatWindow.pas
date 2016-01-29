unit feChatWindow;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Chat"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Chat/feChatWindow.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Integrated Products::Chat::Chat::ChatImpl::TfeChatWindow
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  l3SimpleObject,
  ChatTypes,
  ChatInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TfeChatWindow = class(Tl3SimpleObject, IfeChatWindow)
 private
 // private fields
   f_UID : TbsUserID;
   f_Name : Il3CString;
 protected
 // realized methods
   function Get_UID: TbsUserID;
   function Get_Name: Il3CString;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(anUID: TbsUserID;
    const aName: Il3CString); reintroduce;
   class function Make(anUID: TbsUserID;
    const aName: Il3CString): IfeChatWindow; reintroduce;
 end;//TfeChatWindow
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TfeChatWindow

constructor TfeChatWindow.Create(anUID: TbsUserID;
  const aName: Il3CString);
//#UC START# *4A66CF5D0036_4A66CECA03D0_var*
//#UC END# *4A66CF5D0036_4A66CECA03D0_var*
begin
//#UC START# *4A66CF5D0036_4A66CECA03D0_impl*
 inherited Create;
 f_UID := anUID;
 f_Name := aName;
//#UC END# *4A66CF5D0036_4A66CECA03D0_impl*
end;//TfeChatWindow.Create

class function TfeChatWindow.Make(anUID: TbsUserID;
  const aName: Il3CString): IfeChatWindow;
var
 l_Inst : TfeChatWindow;
begin
 l_Inst := Create(anUID, aName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TfeChatWindow.Get_UID: TbsUserID;
//#UC START# *4A66C7E2006C_4A66CECA03D0get_var*
//#UC END# *4A66C7E2006C_4A66CECA03D0get_var*
begin
//#UC START# *4A66C7E2006C_4A66CECA03D0get_impl*
 Result := f_UID;
//#UC END# *4A66C7E2006C_4A66CECA03D0get_impl*
end;//TfeChatWindow.Get_UID

function TfeChatWindow.Get_Name: Il3CString;
//#UC START# *4A66C86A033A_4A66CECA03D0get_var*
//#UC END# *4A66C86A033A_4A66CECA03D0get_var*
begin
//#UC START# *4A66C86A033A_4A66CECA03D0get_impl*
 Result := f_Name;
//#UC END# *4A66C86A033A_4A66CECA03D0get_impl*
end;//TfeChatWindow.Get_Name

procedure TfeChatWindow.Cleanup;
//#UC START# *479731C50290_4A66CECA03D0_var*
//#UC END# *479731C50290_4A66CECA03D0_var*
begin
//#UC START# *479731C50290_4A66CECA03D0_impl*
 f_Name := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4A66CECA03D0_impl*
end;//TfeChatWindow.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.