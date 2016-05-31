unit csRequestTask;

// Модуль: "w:\common\components\rtl\Garant\cs\csRequestTask.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csRequestTask" MUID: (52FA4ACA0020)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ddServerTask
 , CsDataPipe
 , k2Base
 , dt_Types
;

type
 TddRequestTask = class(TddTaskItem)
  public
   procedure SaveRequestToPipe(aPipe: TCsDataPipe); virtual;
   constructor Create(aUserID: TUserID); override;
   class function GetTaggedDataType: Tk2Type; override;
 end;//TddRequestTask

 TddRequestTaskAsTask = class(TddRequestTask)
  public
   procedure SaveTaskToPipe(aPipe: TCsDataPipe);
 end;//TddRequestTaskAsTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , evdTaskTypes
 , RequestTask_Const
 , l3Memory
 , SysUtils
;

procedure TddRequestTask.SaveRequestToPipe(aPipe: TCsDataPipe);
//#UC START# *54C0FDAD028B_52FA4AD90122_var*
//#UC END# *54C0FDAD028B_52FA4AD90122_var*
begin
//#UC START# *54C0FDAD028B_52FA4AD90122_impl*
// Do nothing
//#UC END# *54C0FDAD028B_52FA4AD90122_impl*
end;//TddRequestTask.SaveRequestToPipe

constructor TddRequestTask.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_52FA4AD90122_var*
//#UC END# *53B3D8A8011F_52FA4AD90122_var*
begin
//#UC START# *53B3D8A8011F_52FA4AD90122_impl*
 inherited;
 //TaskType := cs_ttRequest;
//#UC END# *53B3D8A8011F_52FA4AD90122_impl*
end;//TddRequestTask.Create

class function TddRequestTask.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typRequestTask;
end;//TddRequestTask.GetTaggedDataType

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

initialization
//#UC START# *53B3DA12012D*
 RegisterTaskClass(cs_ttRequest, TddRequestTask, 'запрос');
//#UC END# *53B3DA12012D*
{$IfEnd} // NOT Defined(Nemesis)

end.
