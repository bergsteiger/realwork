unit f1ListTagDataFromDTP;
 {* ��������� ������ � ������ ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1ListTagDataFromDTP.pas"
// ���������: "SimpleClass"

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
  {* ��������� ������ � ������ ���������� }
 end;//Tf1ListTagDataFromDTP

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsParentedTagData.imp.pas}

end.
