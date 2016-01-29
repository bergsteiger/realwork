unit csRequestTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csRequestTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Tasks::csRequestTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  ddServerTask,
  CsDataPipe,
  k2Base,
  dt_Types
  ;

type
 TddRequestTask = class(TddTaskItem)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // overridden public methods
   constructor Create(aUserID: TUserID); override;
 public
 // public methods
   procedure SaveRequestToPipe(aPipe: TCsDataPipe); virtual;
 end;//TddRequestTask

 TddRequestTaskAsTask = class(TddRequestTask)
 public
 // public methods
   procedure SaveTaskToPipe(aPipe: TCsDataPipe);
 end;//TddRequestTaskAsTask
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  evdTaskTypes,
  RequestTask_Const,
  l3Memory,
  SysUtils
  ;

// start class TddRequestTask

procedure TddRequestTask.SaveRequestToPipe(aPipe: TCsDataPipe);
//#UC START# *54C0FDAD028B_52FA4AD90122_var*
//#UC END# *54C0FDAD028B_52FA4AD90122_var*
begin
//#UC START# *54C0FDAD028B_52FA4AD90122_impl*
// Do nothing
//#UC END# *54C0FDAD028B_52FA4AD90122_impl*
end;//TddRequestTask.SaveRequestToPipe

class function TddRequestTask.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typRequestTask;
end;//TddRequestTask.GetTaggedDataType

constructor TddRequestTask.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_52FA4AD90122_var*
//#UC END# *53B3D8A8011F_52FA4AD90122_var*
begin
//#UC START# *53B3D8A8011F_52FA4AD90122_impl*
 inherited;
 //TaskType := cs_ttRequest;
//#UC END# *53B3D8A8011F_52FA4AD90122_impl*
end;//TddRequestTask.Create
// start class TddRequestTaskAsTask

procedure TddRequestTaskAsTask.SaveTaskToPipe(aPipe: TCsDataPipe);
//#UC START# *54C650610228_54C6504A003A_var*
var
  l_Stream: Tl3MemoryStream;
//#UC END# *54C650610228_54C6504A003A_var*
begin
//#UC START# *54C650610228_54C6504A003A_impl*
 l_Stream:= Tl3MemoryStream.Create;
 try
  SaveTo(l_Stream, True);
  l_Stream.Seek(0, 0);
  aPipe.WriteStream(l_Stream);
 finally
  FreeAndNil(l_Stream);
 end;
//#UC END# *54C650610228_54C6504A003A_impl*
end;//TddRequestTaskAsTask.SaveTaskToPipe
{$IfEnd} //not Nemesis

initialization
{$If not defined(Nemesis)}
//#UC START# *53B3DA12012D*
 RegisterTaskClass(cs_ttRequest, TddRequestTask, 'запрос');
//#UC END# *53B3DA12012D*
{$IfEnd} //not Nemesis

end.