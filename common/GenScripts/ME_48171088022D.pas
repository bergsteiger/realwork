unit nevChildSpy.imp;

interface

uses
 l3IntfUses
 , nevTools
;

type
 _nevChildSpy_ = class
  procedure ChildAdded(const aList: InevParaList;
   const aChild: InevPara);
  procedure ChildDeleted(const aList: InevParaList;
   const aChild: InevPara);
 end;//_nevChildSpy_
 
implementation

uses
 l3ImplUses
;

end.
