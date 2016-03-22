unit evDocumentPreview;
 {* Предварительный просмотр печати документа }

// Модуль: "w:\common\components\gui\Garant\Everest\evDocumentPreview.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevDocumentPreview" MUID: (49CBD11A02CF)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evDocumentPreviewPrim
 , afwInterfaces
 , nevTools
 , nevBase
 , l3Variant
;

type
 TevDocumentPreview = class(TevDocumentPreviewPrim)
  {* Предварительный просмотр печати документа }
  public
   class function Make(const aText: InevStorable;
    const aKey: TevPreviewCacheKey;
    const aHAF: IafwHAFPainter = nil): IafwDocumentPreview; reintroduce; overload;
   class function Make(const aText: InevDocumentProvider;
    const aKey: TevPreviewCacheKey;
    const aHAF: IafwHAFPainter = nil): IafwDocumentPreview; reintroduce; overload;
   class function Make(aText: Tl3Variant;
    const aKey: TevPreviewCacheKey;
    const aHAF: IafwHAFPainter = nil): IafwDocumentPreview; overload;
 end;//TevDocumentPreview

implementation

uses
 l3ImplUses
;

class function TevDocumentPreview.Make(const aText: InevStorable;
 const aKey: TevPreviewCacheKey;
 const aHAF: IafwHAFPainter = nil): IafwDocumentPreview;
var
 l_Inst : TevDocumentPreview;
begin
 l_Inst := Create(aText, aKey, aHAF);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevDocumentPreview.Make

class function TevDocumentPreview.Make(const aText: InevDocumentProvider;
 const aKey: TevPreviewCacheKey;
 const aHAF: IafwHAFPainter = nil): IafwDocumentPreview;
var
 l_Inst : TevDocumentPreview;
begin
 l_Inst := Create(aText, aKey, aHAF);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevDocumentPreview.Make

class function TevDocumentPreview.Make(aText: Tl3Variant;
 const aKey: TevPreviewCacheKey;
 const aHAF: IafwHAFPainter = nil): IafwDocumentPreview;
//#UC START# *4CB58335014E_49CBD11A02CF_var*
var
 l_Data : InevStorable;
//#UC END# *4CB58335014E_49CBD11A02CF_var*
begin
//#UC START# *4CB58335014E_49CBD11A02CF_impl*
 if (aText = nil) then
  Result := nil
 else
 if aText.QT(InevStorable, l_Data) then
  try
   Result := Make(l_Data, aKey, aHAF);
  finally
   l_Data := nil;
  end//try..finally
 else
  Result := nil;   
//#UC END# *4CB58335014E_49CBD11A02CF_impl*
end;//TevDocumentPreview.Make

end.
