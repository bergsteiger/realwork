unit a2dsBigBrother;

{ $Id: a2dsBigBrother.pas,v 1.14 2016/06/16 05:38:36 lukyanets Exp $}

// $Log: a2dsBigBrother.pas,v $
// Revision 1.14  2016/06/16 05:38:36  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.13  2015/07/09 10:35:01  lukyanets
// Готовимся вычитывать данные
//
// Revision 1.12  2015/04/30 11:14:36  lukyanets
// Заготовки Большого Брата
//
// Revision 1.11  2015/04/29 14:56:52  lukyanets
// Заготовки Большого Брата
//
// Revision 1.10  2013/11/07 08:25:57  fireton
// - не собиралось
//
// Revision 1.9  2009/03/06 14:18:19  fireton
// - попытка пересборки с обновленным VCM
//
// Revision 1.8  2009/01/29 14:22:48  fireton
// - пересборка под обновленный VCM
//
// Revision 1.7  2009/01/28 15:32:24  fireton
// - пересборка под обновленный VCM
//
// Revision 1.6  2008/11/10 14:27:31  fireton
// - новая версия VCM
//
// Revision 1.5  2008/06/20 14:48:41  lulin
// - используем префиксы элементов.
//
// Revision 1.4  2008/04/25 07:52:41  fireton
// - запись результатов ББ в файл
//
// Revision 1.3  2007/05/24 14:42:10  fireton
// - Большой Брат теперь умеет выдавать статистику по всем пользователям
// - Большой Брат умеет сводить статистику по пользователям и документам
//
// Revision 1.2  2007/05/07 08:11:41  fireton
// - bug fix: Большой Брат дергался два раза на один запрос
//
// Revision 1.1  2006/02/14 11:20:43  fireton
// - реализация Большого Брата
//

interface

uses
 l3Date,
 l3Tree,

 vcmInterfaces,
 vcmFormDataSource,

 a2Interfaces, l3TreeInterfaces;

type
 Ta2dsBigBrother = class (TvcmFormDataSource, Ia2dsBigBrother)
 private
  f_TargetProfile: Ia2Profile;
  f_Tree: Tl3Tree;
  function pm_GetSDS: Ia2sdsAdmin;
  procedure Refresh(aStart, aStop: TStDate; aDocID: Integer = 0);
  function pm_GetTree: Il3SimpleTree;
  function pm_GetProfile: Ia2Profile;
 protected
  procedure Cleanup; override;
 public
  procedure DoInit; override;
  procedure GotData; override;
  procedure SaveResult(aFileName: string);
  property SDS: Ia2sdsAdmin read pm_GetSDS;
  property Tree: Il3SimpleTree read pm_GetTree;
 end;

implementation
uses
 SysUtils,

 l3Base,
 l3Tree_TLB,
 l3Nodes,
 l3Filer,
 l3String,

 k2Tags,

 TextPara_Const,
 Document_Const,

 evdStyles,

 daDataProvider,

 daTypes,

 ddRTFWriter
 , ddDocument;

procedure Ta2dsBigBrother.Cleanup;
begin
 l3Free(f_Tree);
 inherited;
end;

procedure Ta2dsBigBrother.DoInit;
begin
 inherited;
 f_Tree := Tl3Tree.Create;
 f_TargetProfile := nil;
end;

procedure Ta2dsBigBrother.GotData;
begin
 inherited;
 Supports(PartData, Ia2Profile, f_TargetProfile);
end;

function Ta2dsBigBrother.pm_GetProfile: Ia2Profile;
begin
 Result := f_TargetProfile;
end;

function Ta2dsBigBrother.pm_GetSDS: Ia2sdsAdmin;
begin
 Supports(UseCaseController, Ia2sdsAdmin, Result);
end;

function Ta2dsBigBrother.pm_GetTree: Il3SimpleTree;
begin
 Result := f_Tree;
end;

procedure Ta2dsBigBrother.Refresh(aStart, aStop: TStDate; aDocID: Integer = 0);
var
 l_Profile: Ia2Profile;
 l_IsGroup: Boolean;
 l_UID    : TdaUserID;
begin
 f_Tree.Clear;
 l_UID := 0;
 l_IsGroup := False;
 if Supports(f_TargetProfile, Ia2Profile, l_Profile) then
 begin
   l_UID := l_Profile.ID;
   l_IsGroup := Supports(l_Profile, Ia2UserGroupProfile);
 end;
 GlobalDataProvider.Journal.CalcStatistics(aStart, aStop, aDocID, l_UID, l_IsGroup);
 f_Tree.RootNode := GlobalDataProvider.Journal.CurStatisticTreeRoot;
end;

procedure Ta2dsBigBrother.SaveResult(aFileName: string);
var
 l_Filer  : TevDOSFiler;
 l_Writer : TevRTFObjectGenerator;

 function NodeIterator(CurNode : Il3Node): Boolean;
 begin
  with l_Writer do
  begin
   StartChild(k2_typTextPara);
   try
    AddIntegerAtom(k2_tiFirstIndent, 0);
    AddIntegerAtom(k2_tiLeftIndent, 0);
    case CurNode.GetLevel of
     1:
      begin
       if CurNode.HasChild then
       begin
        AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
        AddIntegerAtom(k2_tiSpaceBefore, 346);  // 12 pt
       end;
      end;
     2:
      if CurNode.HasChild then
      begin
       AddIntegerAtom(k2_tiStyle, ev_saTxtHeader2);
       AddIntegerAtom(k2_tiSpaceBefore, 173); //  6 pt
       //AddIntegerAtom(k2_tiSpaceAfter, 346);  // 12 pt   ddRTFWriter
       //AddIntegerAtom(k2_tiSpaceBefore, 173); //  6 pt
      end;
     3:
      AddIntegerAtom(k2_tiLeftIndent, 200);
     4:
      begin
       AddIntegerAtom(k2_tiBullet, 1);
       AddIntegerAtom(k2_tiLeftIndent, 400);
      end;
    else
    end;
    AddStringAtom(k2_tiText, l3Str(CurNode.Text));
   finally
    Finish;
   end;
  end;
 end;

begin
 l_Filer := TevDOSFiler.Create(nil);
 try
  try
   l_Writer := TevRTFObjectGenerator.Create(nil);
   l_Writer.OneStep := False;
   l_Filer.FileName := aFileName;
   l_Writer.Filer := l_Filer;

   // собственно запись
   l_Writer.Start;
   try
    l_Writer.StartChild(k2_typDocument);
    f_Tree.IterateF(l3L2NA(@NodeIterator));
    l_Writer.Finish;
   finally
    l_Writer.Finish;
   end;
  finally
   l3Free(l_Writer);
  end;
 finally
  l3Free(l_Filer);
 end;
end;

end.
