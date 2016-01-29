unit OutlinerTest;

interface

uses
 l3IntfUses
 , BaseTest
 , Outliner_Form
;

type
 TOutlinerTest = class(TBaseTest)
  procedure DoIt();
  procedure Load(aForm: TOutlinerFormForm;
   const aFileName: AnsiString);
   {* Загрузить данные в дерево. }
 end;//TOutlinerTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 , Forms
 , l3Base
;

end.
