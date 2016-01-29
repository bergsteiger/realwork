unit evDescriptionReq;

interface

uses
 l3IntfUses
 , evCustomControlTool
 , evQueryCardInt
 , nevTools
 , l3Interfaces
;

type
 TevDescriptionReq = class(TevCustomControlTool, IevDescriptionReq)
  procedure Make(const aValue: InevPara);
  procedure InitModel;
  function ReqName: Il3CString;
  function Collapsed: Boolean;
 end;//TevDescriptionReq
 
implementation

uses
 l3ImplUses
 , k2Tags
 , SysUtils
 , evdTypes
 , nevFacade
 , ControlPara_Const
;

end.
