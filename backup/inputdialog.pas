unit inputDialog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm2 }

  input = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    LeftD: TRadioButton;
    Nothing: TRadioButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Right: TRadioButton;
    function Execute:Boolean;
  private

  public
    WhatToWrite:Char;
    WhereToGo:Integer;
  end;

var
  Form2: input;

implementation

uses tMaschine;

{$R *.lfm}

{ TForm2 }

function input.Execute: Boolean;
Var i:Integer;
begin
  Result := (ShowModal = mrOk);
  ComboBox1.Items.Clear;
  for i:=1 to Form1.StringGrid1.ColCount-1 do
  begin
     ComboBox1.Items.Add(Form1.StringGrid1.Cells[i,0]);
  end;
  ComboBox1.ItemIndex:=0;
  WhatToWrite:=ComboBox1.SelText[1];
  if LeftD.Checked then wheretogo:=-1;
  if Nothing.checked then wheretogo:=0;
  if Right.checked then wheretoGo:=1;
end;

end.

