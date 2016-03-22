unit Meta_Schema;

// ������: "w:\common\components\SandBox\Meta_Schema.pas"
// ���������: "TagTable"
// ������� ������: "Meta" MUID: (486203CB0282)
// ��� ����: "TMetaSchema"

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
;

type
 Visibility = (
  public
  , private
  , protected
 );//Visibility

 Abstract = (
  regular
  , abstract
  , final
 );//Abstract

 // TMetaSchema

implementation

uses
 l3ImplUses
;

initialization
 TMetaSchema.SetAsDefault;

end.
