unit csRelPublishTask;

// Модуль: "w:\common\components\rtl\Garant\cs\csRelPublishTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsRelPublishTask" MUID: (53BA76F9001C)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csImport
 , k2Base
;

type
 TcsRelPublishTask = class(TcsImportTaskItem)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsRelPublishTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , RelPublishTask_Const
;

class function TcsRelPublishTask.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typRelPublishTask;
end;//TcsRelPublishTask.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
