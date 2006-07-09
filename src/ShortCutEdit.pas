unit ShortCutEdit;

interface
uses
  Windows, Messages, SysUtils, Classes, StdCtrls;

type
  TShortCutEdit = class(TCustomEdit)
  private
    function GetShortCut: TShortCut;
    procedure SetShortCut(const Value: TShortCut);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;

  public
    property ShortCut: TShortCut read GetShortCut write SetShortCut;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BorderStyle;
    property OnChange;
  end;

implementation
uses
  AppUtils, Menus;

{ TShortCutEdit }

function TShortCutEdit.GetShortCut: TShortCut;
begin
  Result := TextToShortCut(Text);
end;

procedure TShortCutEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if ((Key = VK_BACK) or (Key = VK_ESCAPE)) and (Shift = []) then
  begin
    Text := '';
    Key := 0;
  end
  else if (Shift = []) and not (Key in [VK_F1..VK_F24, VK_INSERT, VK_DELETE]) then
  begin
    Key := 0;
    Exit;
  end
  else if (Shift = [ssShift]) and not (Key in [VK_SHIFT, VK_PRIOR..VK_DOWN, VK_F1..VK_F24, VK_INSERT, VK_DELETE]) then
  begin
    Key := 0;
    Exit;
  end
  else
  begin
    if (Key = VK_CONTROL) then
      Exclude(Shift, ssCtrl);
    if (Key = VK_SHIFT) then
      Exclude(Shift, ssShift);
    if (Key = VK_MENU) then
      Exclude(Shift, ssAlt);

    ShortCut := Menus.ShortCut(Key, Shift);
    SelStart := Length(Text);
    Key := 0;
  end;
end;

procedure TShortCutEdit.KeyPress(var Key: Char);
begin
  inherited;
  Key := #0;
end;

procedure TShortCutEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  Menus.ShortCutToKey(Self.ShortCut, Key, Shift);
  if (Key in [VK_CONTROL, VK_SHIFT, VK_MENU]) then
    Key := 0;
  ShortCut := Menus.ShortCut(Key, Shift);
  Key := 0;
end;

procedure TShortCutEdit.SetShortCut(const Value: TShortCut);
begin
  Text := MyShortCutToText(Value);
end;

end.
