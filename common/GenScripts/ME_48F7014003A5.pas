unit evNodeData;

interface

uses
 l3IntfUses
 , l3TreeInterfaces
 , evNodeDataObject
 , l3Interfaces
;

type
 TevNodeData = class(_evTreeData_)
 end;//TevNodeData
 
implementation

uses
 l3ImplUses
 , evTypes
 , l3TreeConst
 , SysUtils
 , l3Base
 , l3InterfacesMisc
 , k2Tags
 , ddRTFWriter
 , l3Filer
 , Windows
 , l3String
 , l3Types
 , Document_Const
 , TextPara_Const
;

end.
