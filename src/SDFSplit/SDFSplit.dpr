program SDFSplit;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {frmMain};

{$R 'manifest.res' 'manifest.rc'}
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
