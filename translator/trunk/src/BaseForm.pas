unit BaseForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms;

type
  TfrmBase = class(TTntForm)
  private
    { Private declarations }
  protected
    procedure LoadFormPos; virtual;
    procedure SaveFormPos; virtual;

  public
    { Public declarations }
    procedure AfterConstruction; override;
    function CloseQuery: Boolean; override;
  end;

var
  frmBase: TfrmBase;

implementation
uses
  AppUtils, AppOptions;

{$R *.dfm}

{ TfrmBase }

procedure TfrmBase.AfterConstruction;
begin
  inherited;
  if Application <> nil then
  begin
    ShowHint := Application.ShowHint;
    if (Application.MainForm <> nil) and (Application.MainForm <> Self) then
      Self.Font := Application.MainForm.Font;
  end;
  GlobalLanguageFile.TranslateObject(Self, ClassName);
  LoadFormPos;
end;

function TfrmBase.CloseQuery: Boolean;
begin
  SaveFormPos;
  Result := inherited CloseQuery;
  ;
end;

procedure TfrmBase.LoadFormPos;
var
  W: TAppWindowInfo;
begin
  if GlobalAppOptions.SaveFormPos then
  begin
    if (Self = Application.MainForm) and IsIconic(Application.Handle) or IsZoomed(Handle) then
      ShowWindow(Handle, SW_RESTORE);
    W := GlobalAppOptions.WindowInfos[Self];
    if (W.WindowState = wsMinimized) and (Self = Application.MainForm) then
      ShowWindow(Application.Handle, SW_MINIMIZE);
    WindowState := W.WindowState;
    if WindowState = wsNormal then
    begin
      // set default (screen center)
      SetBounds((Screen.Width - Width) div 2, (Screen.Height - Height) div 2, Width, Height);
      if BorderStyle in [bsSizeable, bsSizeToolWin] then
        BoundsRect := W.BoundsRect
      else
      begin
        Top := W.BoundsRect.Top;
        Left := W.BoundsRect.Left;
      end;
    end;
  end;
end;

procedure TfrmBase.SaveFormPos;
var
  W: TAppWindowInfo;
begin
  if GlobalAppOptions.SaveFormPos then
  begin
    W.Name := self.Name;
    W.WindowState := WindowState;
    W.BoundsRect := BoundsRect;
    GlobalAppOptions.WindowInfos[self] := W;
  end;
  inherited;
end;

end.
