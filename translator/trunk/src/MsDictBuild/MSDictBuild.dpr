program MSDictBuild;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {frmMain};

// for XP theme support
{$R 'manifest.res' 'manifest.rc'}
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

