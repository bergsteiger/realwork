unit ddRunCommandTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddRunCommandTaskPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddRunCommandTaskPrim" MUID: (53B6A75A024C)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , dt_Types
 , k2Base
;

type
 TddRunCommandTaskPrim = class(TddProcessTask)
  public
   constructor Create(aUserID: TUserID); override;
   class function GetTaggedDataType: Tk2Type; override;
 end;//TddRunCommandTaskPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , evdTaskTypes
 , RunCommandTask_Const
;

constructor TddRunCommandTaskPrim.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_53B6A75A024C_var*
//#UC END# *53B3D8A8011F_53B6A75A024C_var*
begin
//#UC START# *53B3D8A8011F_53B6A75A024C_impl*
 inherited;
 //TaskType := cs_ttRunCommand;
//#UC END# *53B3D8A8011F_53B6A75A024C_impl*
end;//TddRunCommandTaskPrim.Create

class function TddRunCommandTaskPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typRunCommandTask;
end;//TddRunCommandTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
