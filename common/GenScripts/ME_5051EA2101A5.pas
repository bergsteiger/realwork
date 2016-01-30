unit atListEntryInfo;

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atListEntryInfo.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , DynamicDocListUnit
 , DocumentUnit
 , BaseTypesUnit
 , l3_Base
 , DynamicTreeUnit
;

type
 _EntityInterface_ = IListEntryInfo;
 {$Include atEntity.imp.pas}
 TatListEntryInfo = class(_atEntity_)
  protected
   function pm_GetDocument: IDocument; virtual;
   function pm_GetPID: TPId; virtual;
  public
   property Document: IDocument
    read pm_GetDocument;
   property PID: TPId
    read pm_GetPID;
 end;//TatListEntryInfo

implementation

uses
 l3ImplUses
 , SysUtils
 , IOUnit
;

{$Include atEntity.imp.pas}

function TatListEntryInfo.pm_GetDocument: IDocument;
//#UC START# *5051EB280111_5051EA2101A5get_var*
//#UC END# *5051EB280111_5051EA2101A5get_var*
begin
//#UC START# *5051EB280111_5051EA2101A5get_impl*
  f_Entity.GetDoc(Result);
//#UC END# *5051EB280111_5051EA2101A5get_impl*
end;//TatListEntryInfo.pm_GetDocument

function TatListEntryInfo.pm_GetPID: TPId;
//#UC START# *5061FF260047_5051EA2101A5get_var*
//#UC END# *5061FF260047_5051EA2101A5get_var*
begin
//#UC START# *5061FF260047_5051EA2101A5get_impl*
  f_Entity.GetPid(Result);
//#UC END# *5061FF260047_5051EA2101A5get_impl*
end;//TatListEntryInfo.pm_GetPID

end.
