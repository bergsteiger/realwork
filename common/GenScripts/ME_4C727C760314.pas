unit f1ListTagDataFromDTP;
 {* Поставщик данных о списке параграфов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1ListTagDataFromDTP.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , f1TagDataFromDTP
 , DocumentUnit
;

type
 _nsParentedTagData_Parent_ = Tf1ListTagDataFromDTPPrim;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsParentedTagData.imp.pas}
 Tf1ListTagDataFromDTP = class(_nsParentedTagData_)
  {* Поставщик данных о списке параграфов }
 end;//Tf1ListTagDataFromDTP

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsParentedTagData.imp.pas}

end.
