unit nevSectionBreakList;

interface

uses
 l3IntfUses
 , nevSectionBreakListPrim
 , nevTools
;

type
 TnevSectionBreakList = class(TnevSectionBreakListPrim, InevSectionBreaks)
  {* ������ �������� �������� }
  function GetSectionWidth(const aChild: InevObject;
   out theWidth: Integer): Boolean;
  function GetSectionBreak(const aChild: InevObject;
   out theBreak: InevObject): Boolean;
   {* ���������� ������ ������� ��� ���������� ��������� �������� }
 end;//TnevSectionBreakList
 
implementation

uses
 l3ImplUses
 , evSectionPara
;

end.
