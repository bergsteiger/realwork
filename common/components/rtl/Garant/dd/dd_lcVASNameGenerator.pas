unit dd_lcVASNameGenerator;
{ Создание названий для постановлений ВАС }

{ $Id: dd_lcVASNameGenerator.pas,v 1.5 2014/04/07 10:01:56 lulin Exp $ }

// $Log: dd_lcVASNameGenerator.pas,v $
// Revision 1.5  2014/04/07 10:01:56  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.4  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.3  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.2  2013/10/18 16:01:26  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.1  2011/11/02 13:03:09  narry
// Отвалились названия ВАС (296627151)
//

interface

uses
  k2Interfaces,
  k2Base,

  l3Types, dd_lcTextFormatter2;

type
 Tdd_lcVASNameGenerator = class(Tdd_lcBaseFormatter)
 private
  f_IsFirstPara: Boolean;
 protected
  procedure DoStartChild(TypeID: Tk2Type); override;
  procedure DoWritePara(aLeaf: Tl3Variant); override;
 end;

implementation

uses
  k2tags, TextPara_Const, dd_lcSourceUtils, Document_Const;

procedure Tdd_lcVASNameGenerator.DoStartChild(TypeID: Tk2Type);
begin
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
  f_isFirstPara:= True;
end;

procedure Tdd_lcVASNameGenerator.DoWritePara(aLeaf: Tl3Variant);
begin
 if (Source2DossierType(f_Source) = lc_dtVAC) and aLeaf.IsKindOf(k2_typTextPara) and f_IsFirstPara then
 begin
  Generator.AddStringAtom(k2_tiName, aLeaf.StrA[k2_tiText]);
  f_IsFirstPara:= False;
 end;
 inherited DoWritePara(aLeaf);
end;

end.
