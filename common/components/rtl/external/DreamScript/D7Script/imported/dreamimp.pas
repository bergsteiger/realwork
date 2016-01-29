{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dreamimp;

interface

{
  Files 
    *_D6.pas
    *_D5.pas
    *_D4.pas
    *_D3.pas
    *_C3.pas 
    *_C4.pas 
    *_C5.pas
  weren't included in registered version of Dream Scripter. You can get them
  automatically with \UTILS\UNITIMPORTER program or download any of the trial
  versions and extract these files from there. Alternatively you can comment
  out impreg from uses of main form of Instant Report, so Instant will be
  compiled without these "import" files.
}

{.$I dc.inc}
{$I dcprod.inc}

{$IFNDEF SKIPDREAMREG}

uses

{------------------------------}
{$IFDEF D7}
  {$IFDEF USE_DCGEN}
    {$IFDEF DCEDIT}
      dcedit_d7,
      {$IFDEF PRODELPHI}
        dcdbctl_d7,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DREAMIDE}
  dcapp_d7,
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcstring_d7,
  dcmemo_d7,
  {$IFDEF PRODELPHI}
  dcdbmemo_d7,
  {$ENDIF}
  editunit_d7,
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dcparser_d7,
  {$ENDIF}
  {$IFDEF DREAMSCRIPTER}
  dcscript_d7,
  {$ENDIF}
  {$IFDEF DREAMTREE}
  {$IFDEF PRODELPHI}
    {$IFDEF USE_DCGEN}
      dcdbtree_d7,
    {$ENDIF}
  {$ENDIF}
  DcimgEd_d7,
  dcTree_d7,
  dctsrc_d7,
  dctreeed_d7,
  treemod_d7,
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  oinspect_d7,
  glyphed_d7,
  dcstrled_d7,
  {$IFDEF PRODELPHI}
  dbinsp_d7,
  {$ENDIF}
  {$ENDIF}
  dcsystem_d7,
  dcCommon_d7,
  {$IFDEF USE_DCGEN}
  dcgen_d7,
  {$ENDIF}
  dcstdctl_d7;

{$ELSE}

{$IFDEF CPB6}
                
  {$IFDEF USE_DCGEN}
    {$IFDEF DCEDIT}
      dcedit_c6,
      {$IFDEF PRODELPHI}
        dcdbctl_c6,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DREAMIDE}
  dcapp_c6,
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcstring_c6,
  dcmemo_c6,
  {$IFDEF PRODELPHI}
  dcdbmemo_c6,
  {$ENDIF}
  editunit_c6,
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dcparser_c6,
  {$ENDIF}
  {$IFDEF DREAMSCRIPTER}
  dcscript_c6,
  {$ENDIF}
  {$IFDEF DREAMTREE}
  {$IFDEF PRODELPHI}
    {$IFDEF USE_DCGEN}
      dcdbtree_c6,
    {$ENDIF}
  {$ENDIF}
  DcimgEd_c6,
  dcTree_c6,
  dctsrc_c6,
  dctreeed_c6,
  treemod_c6,
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  oinspect_c6,
  glyphed_c6,
  dcstrled_c6,
  {$IFDEF PRODELPHI}
  dbinsp_c6,
  {$ENDIF}
  {$ENDIF}
  dcsystem_c6,
  dcCommon_c6,
  {$IFDEF USE_DCGEN}
  dcgen_c6,
  {$ENDIF}
  dcstdctl_c6;

{$ELSE}


{$IFDEF D6}
  {$IFDEF USE_DCGEN}
    {$IFDEF DCEDIT}
      dcedit_d6,
      {$IFDEF PRODELPHI}
        dcdbctl_d6,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DREAMIDE}
  dcapp_d6,
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcstring_d6,
  dcmemo_d6,
  {$IFDEF PRODELPHI}
  dcdbmemo_d6,
  {$ENDIF}
  editunit_d6,
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dcparser_d6,
  {$ENDIF}
  {$IFDEF DREAMSCRIPTER}
  dcscript_d6,
  {$ENDIF}
  {$IFDEF DREAMTREE}
  {$IFDEF PRODELPHI}
    {$IFDEF USE_DCGEN}
      dcdbtree_d6,
    {$ENDIF}
  {$ENDIF}
  DcimgEd_d6,
  dcTree_d6,
  dctsrc_d6,
  dctreeed_d6,
  treemod_d6,
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  oinspect_d6,
  glyphed_d6,
  dcstrled_d6,
  {$IFDEF PRODELPHI}
  dbinsp_d6,
  {$ENDIF}
  {$ENDIF}
  dcsystem_d6,
  dcCommon_d6,
  {$IFDEF USE_DCGEN}
  dcgen_d6,
  {$ENDIF}
  dcstdctl_d6;

{$ELSE}

{------------------------------}

{$IFDEF CPB5}
                
  {$IFDEF USE_DCGEN}
    {$IFDEF DCEDIT}
      dcedit_c5,
      {$IFDEF PRODELPHI}
        dcdbctl_c5,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DREAMIDE}
  dcapp_c5,
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcstring_c5,
  dcmemo_c5,
  {$IFDEF PRODELPHI}
  dcdbmemo_c5,
  {$ENDIF}
  editunit_c5,
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dcparser_c5,
  {$ENDIF}
  {$IFDEF DREAMSCRIPTER}
  dcscript_c5,
  {$ENDIF}
  {$IFDEF DREAMTREE}
  {$IFDEF PRODELPHI}
    {$IFDEF USE_DCGEN}
      dcdbtree_c5,
    {$ENDIF}
  {$ENDIF}
  DcimgEd_c5,
  dcTree_c5,
  dctsrc_c5,
  dctreeed_c5,
  treemod_c5,
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  oinspect_c5,
  glyphed_c5,
  dcstrled_c5,
  {$IFDEF PRODELPHI}
  dbinsp_c5,
  {$ENDIF}
  {$ENDIF}
  dcsystem_c5,
  dcCommon_c5,
  {$IFDEF USE_DCGEN}
  dcgen_c5,
  {$ENDIF}
  dcstdctl_c5;

{$ELSE}

{------------------------------}

{$IFDEF D5}

  {$IFDEF USE_DCGEN}
    {$IFDEF DCEDIT}
      dcedit_d5,
      {$IFDEF PRODELPHI}
        dcdbctl_d5,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DREAMIDE}
  dcapp_d5,
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcstring_d5,
  dcmemo_d5,
  {$IFDEF PRODELPHI}
  dcdbmemo_d5,
  {$ENDIF}
  editunit_d5,
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dcparser_d5,
  {$ENDIF}
  {$IFDEF DREAMSCRIPTER}
  dcscript_d5,
  {$ENDIF}
  {$IFDEF DREAMTREE}
  {$IFDEF PRODELPHI}
    {$IFDEF USE_DCGEN}
      dcdbtree_d5,
    {$ENDIF}
  {$ENDIF}
  DcimgEd_d5,
  dcTree_d5,
  dctsrc_d5,
  dctreeed_d5,
  treemod_d5,
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  oinspect_d5,
  glyphed_d5,
  dcstrled_d5,
  {$IFDEF PRODELPHI}
  dbinsp_d5,
  {$ENDIF}
  {$ENDIF}
  dcsystem_d5,
  dcCommon_d5,
  {$IFDEF USE_DCGEN}
  dcgen_d5,
  {$ENDIF}
  dcstdctl_d5;

{$ELSE}

{------------------------------}

{$IFDEF CPB4}

  {$IFDEF USE_DCGEN}
    {$IFDEF DCEDIT}
      dcedit_c4,
      {$IFDEF PRODELPHI}
        dcdbctl_c4,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DREAMIDE}
  dcapp_c4,
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcstring_c4,
  dcmemo_c4,
  {$IFDEF PRODELPHI}
  dcdbmemo_c4,
  {$ENDIF}
  editunit_c4,
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dcparser_c4,
  {$ENDIF}
  {$IFDEF DREAMSCRIPTER}
  dcscript_c4,
  {$ENDIF}
  {$IFDEF DREAMTREE}
  {$IFDEF PRODELPHI}
    {$IFDEF USE_DCGEN}
      dcdbtree_c4,
    {$ENDIF}
  {$ENDIF}
  DcimgEd_c4,
  dcTree_c4,
  dctsrc_c4,
  dctreeed_c4,
  treemod_c4,
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  oinspect_c4,
  glyphed_c4,
  dcstrled_c4,
  {$IFDEF PRODELPHI}
  dbinsp_c4,
  {$ENDIF}
  {$ENDIF}
  dcsystem_c4,
  dcCommon_c4,
  {$IFDEF USE_DCGEN}
  dcgen_c4,
  {$ENDIF}
  dcstdctl_c4;

{$ELSE}

{------------------------------}

{$IFDEF D4}

  {$IFDEF USE_DCGEN}
    {$IFDEF DCEDIT}
      dcedit_d4,
      {$IFDEF PRODELPHI}
        dcdbctl_d4,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DREAMIDE}
  dcapp_d4,
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcstring_d4,
  dcmemo_d4,
  {$IFDEF PRODELPHI}
  dcdbmemo_d4,
  {$ENDIF}
  editunit_d4,
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dcparser_d4,
  {$ENDIF}
  {$IFDEF DREAMSCRIPTER}
  dcscript_d4,
  {$ENDIF}
  {$IFDEF DREAMTREE}
  {$IFDEF PRODELPHI}
    {$IFDEF USE_DCGEN}
      dcdbtree_d4,
    {$ENDIF}
  {$ENDIF}
  DcimgEd_d4,
  dcTree_d4,
  dctsrc_d4,
  dctreeed_d4,
  treemod_d4,
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  oinspect_d4,
  glyphed_d4,
  dcstrled_d4,
  {$IFDEF PRODELPHI}
  dbinsp_d4,
  {$ENDIF}
  {$ENDIF}
  dcsystem_d4,
  dcCommon_d4,
  {$IFDEF USE_DCGEN}
  dcgen_d4,
  {$ENDIF}
  dcstdctl_d4;

{$ELSE}

{------------------------------}

{$IFDEF CPB3}

  {$IFDEF USE_DCGEN}
    {$IFDEF DCEDIT}
      dcedit_c3,
      {$IFDEF PRODELPHI}
        dcdbctl_c3,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}  
  {$IFDEF DREAMIDE}
  dcapp_c3,
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcstring_c3,
  dcmemo_c3,
  {$IFDEF PRODELPHI}
  dcdbmemo_c3,
  {$ENDIF}
  editunit_c3,
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dcparser_c3,
  {$ENDIF}
  {$IFDEF DREAMSCRIPTER}
  dcscript_c3,
  {$ENDIF}
  {$IFDEF DREAMTREE}
  {$IFDEF PRODELPHI}
    {$IFDEF USE_DCGEN}
      dcdbtree_c3,
    {$ENDIF}
  {$ENDIF}
  DcimgEd_c3,
  dcTree_c3,
  dctsrc_c3,
  dctreeed_c3,
  treemod_c3,
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  oinspect_c3,
  glyphed_c3,
  dcstrled_c3,
  {$IFDEF PRODELPHI}
  dbinsp_c3,
  {$ENDIF}
  {$ENDIF}
  dcsystem_c3,
  dcCommon_c3,
  {$IFDEF USE_DCGEN}
  dcgen_c3,
  {$ENDIF}
  dcstdctl_c3;

{$ELSE}

{------------------------------}

{$IFDEF D3}

  {$IFDEF USE_DCGEN}
    {$IFDEF DCEDIT}
      dcedit_d3,
      {$IFDEF PRODELPHI}
        dcdbctl_d3,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DREAMIDE}
  dcapp_d3,
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcstring_d3,
  dcmemo_d3,
  {$IFDEF PROFESSIONAL}
  dcdbmemo_d3,
  {$ENDIF}
  editunit_d3,
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dcparser_d3,
  {$ENDIF}
  {$IFDEF DREAMSCRIPTER}
  dcscript_d3,
  {$ENDIF}
  {$IFDEF DREAMTREE}
  {$IFDEF PRODELPHI}
    {$IFDEF USE_DCGEN}
      dcdbtree_d3,
    {$ENDIF}
  {$ENDIF}
  DcimgEd_d3,
  dcTree_d3,
  dctsrc_d3,
  dctreeed_d3,
  treemod_d3,
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  oinspect_d3,
  glyphed_d3,
  dcstrled_d3,
  {$IFDEF PRODELPHI}
  dbinsp_d3,
  {$ENDIF}
  {$ENDIF}
  dcsystem_d3,
  dcCommon_d3,
  {$IFDEF USE_DCGEN}
  dcgen_d3,
  {$ENDIF}
  dcstdctl_d3;

{$ELSE}

{------------------------------}

{$IFDEF CPB1}

  {$IFDEF USE_DCGEN}
    {$IFDEF DCEDIT}
      dcedit_c1,
      {$IFDEF PRODELPHI}
        dcdbctl_c1,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DREAMIDE}
  dcapp_c1,
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcstring_c1,
  dcmemo_c1,
  {$IFDEF PRODELPHI}
  dcdbmemo_c1,
  {$ENDIF}
  editunit_c1,
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dcparser_c1,
  {$ENDIF}
  {$IFDEF DREAMSCRIPTER}
  dcscript_c1,
  {$ENDIF}
  {$IFDEF DREAMTREE}
  {$IFDEF PRODELPHI}
    {$IFDEF USE_DCGEN}
      dcdbtree_c1,
    {$ENDIF}
  {$ENDIF}
  DcimgEd_c1,
  dcTree_c1,
  dctsrc_c1,
  dctreeed_c1,
  treemod_c1,
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  oinspect_c1,
  glyphed_c1,
  dcstrled_c1,
  {$IFDEF PRODELPHI}
  dbinsp_c1,
  {$ENDIF}
  {$ENDIF}
  dcsystem_c1,
  dcCommon_c1,
  {$IFDEF USE_DCGEN}
  dcgen_c1,
  {$ENDIF}
  dcstdctl_c1;

{$ELSE}

{------------------------------}

  {$IFDEF USE_DCGEN}
    {$IFDEF DCEDIT}
      dcedit_d2,
      {$IFDEF PRODELPHI}
        dcdbctl_d2,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DREAMIDE}
  dcapp_d2,
  {$ENDIF}
  {$IFDEF DREAMMEMO}
  dcstring_d2,
  dcmemo_d2,
  {$IFDEF PRODELPHI}
  dcdbmemo_d2,
  {$ENDIF}
  editunit_d2,
  {$ENDIF}
  {$IFDEF DREAMPARSER}
  dcparser_d2,
  {$ENDIF}
  {$IFDEF DREAMSCRIPTER}
  dcscript_d2,
  {$ENDIF}
  {$IFDEF DREAMTREE}
  {$IFDEF PRODELPHI}
    {$IFDEF USE_DCGEN}
      dcdbtree_d2,
    {$ENDIF}
  {$ENDIF}
  DcimgEd_d2,
  dcTree_d2,
  dctsrc_d2,
  dctreeed_d2,
  treemod_d2,
  {$ENDIF}
  {$IFDEF DREAMINSPECTOR}
  oinspect_d2,
  glyphed_d2,
  dcstrled_d2,
  {$IFDEF PRODELPHI}
  dbinsp_d2,
  {$ENDIF}
  {$ENDIF}
  dcsystem_d2,
  dcCommon_d2,
  {$IFDEF USE_DCGEN}
  dcgen_d2,
  {$ENDIF}
  dcstdctl_d2;

{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}

{$ENDIF}
{$ENDIF}
{$ENDIF}

implementation

end.
