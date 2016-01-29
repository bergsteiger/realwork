unit kwCheckWithEtalonCommon.imp;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 _kwCheckWithEtalonCommon_ = class
  procedure ExecuteWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
  function DoOpenLog(const aView: InevView): AnsiString;
  procedure DoCloseLog(const aLogName: AnsiString);
 end;//_kwCheckWithEtalonCommon_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , StrUtils
;

end.
