unit nevSectionBreakList;

interface

uses
 l3IntfUses
 , nevSectionBreakListPrim
 , nevTools
;

type
 TnevSectionBreakList = class(TnevSectionBreakListPrim, InevSectionBreaks)
  {* Список разрывов разделов }
  function GetSectionWidth(const aChild: InevObject;
   out theWidth: Integer): Boolean;
  function GetSectionBreak(const aChild: InevObject;
   out theBreak: InevObject): Boolean;
   {* Возвращает разрыв раздела для указанного дочернего элемента }
 end;//TnevSectionBreakList
 
implementation

uses
 l3ImplUses
 , evSectionPara
;

end.
