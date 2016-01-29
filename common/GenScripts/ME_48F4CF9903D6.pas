unit evConstStringData;

interface

uses
 l3IntfUses
 , evConstStringDataObject
 , evdInterfaces
 , l3Interfaces
;

type
 TevConstStringData = class(_evTreeData_)
 end;//TevConstStringData
 
implementation

uses
 l3ImplUses
 , evTypes
 , SysUtils
 , l3Base
 , l3InterfacesMisc
 , k2Tags
 , ddRTFWriter
 , l3Filer
 , l3TreeInterfaces
 , Windows
 , l3String
 , l3Types
 , Document_Const
 , TextPara_Const
 , l3TreeConst
;

end.
