unit l3ParserInterfaces;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ParserInterfaces.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3ParserInterfaces" MUID: (4DC95A8D016F)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3Variant
 , l3Interfaces
;

type
 Il3KeywordFinder = interface
  ['{6B7313C8-EC12-43A4-9B0C-89C07EED8DA7}']
  function Get_KeywordByName(const aName: Il3CString): Tl3PrimString;
  property KeywordByName[const aName: Il3CString]: Tl3PrimString
   read Get_KeywordByName;
 end;//Il3KeywordFinder

implementation

uses
 l3ImplUses
;

end.
