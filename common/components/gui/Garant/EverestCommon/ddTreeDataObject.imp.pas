{$IfNDef ddTreeDataObject_imp}

// Модуль: "w:\common\components\gui\Garant\EverestCommon\ddTreeDataObject.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "ddTreeDataObject" MUID: (469C68EC0226)
// Имя типа: "_ddTreeDataObject_"

{$Define ddTreeDataObject_imp}

 {$Include w:\common\components\rtl\Garant\L3\l3TreeDataObject.imp.pas}
 _ddTreeDataObject_ = class(_l3TreeDataObject_)
  {* Объект данных дерева }
  protected
   function GetCaptions: Tl3WString;
   function CreateFileName: AnsiString;
   procedure WriteFilesAndSetNames(aNames: Tl3StringList); override;
   function GetFormats: Tl3ClipboardFormats; override;
  public
   constructor Create(const aData: _DataType_;
    const aBitmap: Il3Bitmap); reintroduce;
   class function Make(const aData: _DataType_;
    const aBitmap: Il3Bitmap): IDataObject; reintroduce;
 end;//_ddTreeDataObject_

{$Else ddTreeDataObject_imp}

{$IfNDef ddTreeDataObject_imp_impl}

{$Define ddTreeDataObject_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3TreeDataObject.imp.pas}

constructor _ddTreeDataObject_.Create(const aData: _DataType_;
 const aBitmap: Il3Bitmap);
//#UC START# *4CDD4F46039D_469C68EC0226_var*
//#UC END# *4CDD4F46039D_469C68EC0226_var*
begin
//#UC START# *4CDD4F46039D_469C68EC0226_impl*
 inherited Create(aData);
 SetDragBitmap(aBitmap);
//#UC END# *4CDD4F46039D_469C68EC0226_impl*
end;//_ddTreeDataObject_.Create

class function _ddTreeDataObject_.Make(const aData: _DataType_;
 const aBitmap: Il3Bitmap): IDataObject;
var
 l_Inst : _ddTreeDataObject_;
begin
 l_Inst := Create(aData, aBitmap);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_ddTreeDataObject_.Make

function _ddTreeDataObject_.GetCaptions: Tl3WString;
//#UC START# *48F4B9F4010C_469C68EC0226_var*
var
 l_SNode : Il3SimpleNode;
//#UC END# *48F4B9F4010C_469C68EC0226_var*
begin
//#UC START# *48F4B9F4010C_469C68EC0226_impl*
 if Supports(Data, Il3SimpleNode, l_SNode) then
  try
   Result := l_SNode.Text;
  finally
   l_SNode := nil;
  end//try..finally
 else
  l3AssignNil(Result);
//#UC END# *48F4B9F4010C_469C68EC0226_impl*
end;//_ddTreeDataObject_.GetCaptions

function _ddTreeDataObject_.CreateFileName: AnsiString;
//#UC START# *48F4BA0E0261_469C68EC0226_var*
var
  l_Name : array [0..MAX_PATH] of Char;
  l_Path : array [0..MAX_PATH] of Char;
//#UC END# *48F4BA0E0261_469C68EC0226_var*
begin
//#UC START# *48F4BA0E0261_469C68EC0226_impl*
 Windows.GetTempPath(MAX_PATH, l_Path);
 Windows.GetTempFileName(l_Path, 'l3DO', 0, l_Name);
 Result := l_Name;
//#UC END# *48F4BA0E0261_469C68EC0226_impl*
end;//_ddTreeDataObject_.CreateFileName

procedure _ddTreeDataObject_.WriteFilesAndSetNames(aNames: Tl3StringList);
//#UC START# *48F3504301B7_469C68EC0226_var*
var
 l_Generator  : TevRTFObjectGenerator;
 l_Filer      : Tl3CustomFiler;
 l_FileName   : String;
//#UC END# *48F3504301B7_469C68EC0226_var*
begin
//#UC START# *48F3504301B7_469C68EC0226_impl*
 inherited;
 l_FileName := ChangeFileExt(CreateFileName, '.rtf');
 l_Generator := TevRTFObjectGenerator.Create;
 try
  l_Filer := Tl3DOSFiler.Make(l_FileName, l3_fmWrite, true);
  try
   l_Generator.Filer := l_Filer;
   with l_Generator do
   begin
    Start;
    try
     StartChild(k2_typDocument);
     try
      StartChild(k2_typTextPara);
      try
       AddStringAtom(k2_tiText, GetCaptions);
       aNames.Add(l_FileName);
      finally
       Finish;
      end;//try..finally
     finally
      Finish; {-закрываем }
     end;//try..finally
    finally
     Finish; {-закрываем документ}
    end;//try..finally
   end;//with l_Generator
  finally
   l3Free(l_Filer);
  end;//try..finally
 finally
  l3Free(l_Generator);
 end;//try..finally
//#UC END# *48F3504301B7_469C68EC0226_impl*
end;//_ddTreeDataObject_.WriteFilesAndSetNames

function _ddTreeDataObject_.GetFormats: Tl3ClipboardFormats;
//#UC START# *48F4B33501DE_469C68EC0226_var*
//#UC END# *48F4B33501DE_469C68EC0226_var*
begin
//#UC START# *48F4B33501DE_469C68EC0226_impl*
 Result := l3CatFormatArray(inherited GetFormats,
                            [CF_HDROP]);
//#UC END# *48F4B33501DE_469C68EC0226_impl*
end;//_ddTreeDataObject_.GetFormats

{$EndIf ddTreeDataObject_imp_impl}

{$EndIf ddTreeDataObject_imp}

