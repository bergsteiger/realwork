unit NOT_FINISHED_ddServerTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/NOT_FINISHED_ddServerTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::ArchiClientServer::ddServerTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  Classes,
  dt_Types,
  ddTaskItemPrim
  ;

type
 TddTaskItem = class(TddTaskItemPrim)
 protected
 // protected methods
   procedure DoLoadFrom(aStream: TStream;
     aIsPipe: Boolean); virtual;
   function GetDescription: AnsiString; virtual;
 public
 // public methods
   procedure AssignFrom(P: TddTaskItem);
   constructor Create(aUserID: TUserID); reintroduce; virtual;
   procedure DoSaveTo(aStream: TStream;
     aIsPipe: Boolean); virtual;
 end;//TddTaskItem

 TddTaskClass = class of TddTaskItem;
procedure RegisterTaskClass;
   {* Сигнатура метода RegisterTaskClass }
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csTaskListening,
  ddTaskClassManager
  ;

// start class TddTaskItem

procedure TddTaskItem.AssignFrom(P: TddTaskItem);
//#UC START# *52FA510700F0_52FA49DF00EF_var*
//#UC END# *52FA510700F0_52FA49DF00EF_var*
begin
//#UC START# *52FA510700F0_52FA49DF00EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52FA510700F0_52FA49DF00EF_impl*
end;//TddTaskItem.AssignFrom

constructor TddTaskItem.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_52FA49DF00EF_var*
//#UC END# *53B3D8A8011F_52FA49DF00EF_var*
begin
//#UC START# *53B3D8A8011F_52FA49DF00EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B3D8A8011F_52FA49DF00EF_impl*
end;//TddTaskItem.Create

procedure TddTaskItem.DoSaveTo(aStream: TStream;
  aIsPipe: Boolean);
//#UC START# *53E481990243_52FA49DF00EF_var*
//#UC END# *53E481990243_52FA49DF00EF_var*
begin
//#UC START# *53E481990243_52FA49DF00EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53E481990243_52FA49DF00EF_impl*
end;//TddTaskItem.DoSaveTo

procedure TddTaskItem.DoLoadFrom(aStream: TStream;
  aIsPipe: Boolean);
//#UC START# *53E481DF03D1_52FA49DF00EF_var*
//#UC END# *53E481DF03D1_52FA49DF00EF_var*
begin
//#UC START# *53E481DF03D1_52FA49DF00EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53E481DF03D1_52FA49DF00EF_impl*
end;//TddTaskItem.DoLoadFrom

function TddTaskItem.GetDescription: AnsiString;
//#UC START# *53FB28170339_52FA49DF00EF_var*
//#UC END# *53FB28170339_52FA49DF00EF_var*
begin
//#UC START# *53FB28170339_52FA49DF00EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53FB28170339_52FA49DF00EF_impl*
end;//TddTaskItem.GetDescription

procedure RegisterTaskClass;
//#UC START# *53B3D9E702BA_52FA49C7022C_var*
//#UC END# *53B3D9E702BA_52FA49C7022C_var*
begin
//#UC START# *53B3D9E702BA_52FA49C7022C_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B3D9E702BA_52FA49C7022C_impl*
end;//RegisterTaskClass
{$IfEnd} //not Nemesis

end.